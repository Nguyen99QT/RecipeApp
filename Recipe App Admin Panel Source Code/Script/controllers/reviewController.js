
// Importing models
const reviewModel = require("../model/reviewModel");
const settingModel = require("../model/settingModel");
const adminLoginModel = require("../model/adminLoginModel");

// Load view for all review
const loadReview = async (req, res) => {

    try {

        // Get filter parameter
        const statusFilter = req.query.status || 'all';
        const typeFilter = req.query.type || 'all';
        
        // Build query based on filters
        let query = {};
        let conditions = [];
        
        // Status filter
        if (statusFilter === 'enabled') {
            conditions.push({ isEnable: true });
        } else if (statusFilter === 'disabled') {
            conditions.push({ isEnable: false });
        }
        
        // Type filter with enhanced logic
        if (typeFilter === 'recipe') {
            // Recipe reviews: either feedbackType='recipe' OR have a recipeId
            conditions.push({
                $or: [
                    { feedbackType: 'recipe' },
                    { recipeId: { $exists: true, $ne: null } }
                ]
            });
        } else if (typeFilter === 'app') {
            // App reviews: feedbackType='app' OR no recipeId
            conditions.push({
                $or: [
                    { feedbackType: 'app' },
                    { recipeId: { $exists: false } },
                    { recipeId: null }
                ]
            });
        }
        
        // Combine all conditions with $and
        if (conditions.length > 0) {
            query = { $and: conditions };
        }

        console.log('[DEBUG] Review Filter Query:', JSON.stringify(query, null, 2));
        console.log('[DEBUG] Status filter:', statusFilter);
        console.log('[DEBUG] Type filter:', typeFilter);

        // fetch review với populate có điều kiện
        const allReviews = await reviewModel.find(query)
            .populate("userId")
            .populate({
                path: "recipeId",
                select: "name image"
            })
            .sort({ createdAt: -1 }); // Sắp xếp mới nhất trước

        // Filter out reviews with null userId after populate (users that were deleted)
        const reviews = allReviews.filter(review => {
            if (!review.userId) {
                console.log('[DEBUG] Found review with null userId:', review._id);
                return true; // Keep it but we'll handle null in template
            }
            return true;
        });

        // Calculate statistics with enhanced logic
        const totalReviews = await reviewModel.countDocuments({});
        const enabledReviews = await reviewModel.countDocuments({ isEnable: true });
        const disabledReviews = await reviewModel.countDocuments({ isEnable: false });
        
        // Recipe reviews: either feedbackType='recipe' OR have a recipeId
        const recipeReviews = await reviewModel.countDocuments({
            $or: [
                { feedbackType: 'recipe' },
                { recipeId: { $exists: true, $ne: null } }
            ]
        });
        
        // App reviews: feedbackType='app' OR no recipeId
        const appReviews = await reviewModel.countDocuments({
            $or: [
                { feedbackType: 'app' },
                { recipeId: { $exists: false } },
                { recipeId: null }
            ]
        });
        
        const approvedReviews = await reviewModel.countDocuments({ isApproved: true });

        const stats = {
            total: totalReviews,
            enabled: enabledReviews,
            disabled: disabledReviews,
            recipe: recipeReviews,
            app: appReviews,
            approved: approvedReviews
        };

        console.log('[DEBUG] Found reviews:', reviews.length);
        console.log('[DEBUG] Status filter:', statusFilter);
        console.log('[DEBUG] Type filter:', typeFilter);
        console.log('[DEBUG] Stats:', stats);

        return res.render("review", { 
            reviews, 
            currentStatusFilter: statusFilter,
            currentTypeFilter: typeFilter,
            stats 
        });

    } catch (error) {
        console.log('[ERROR] loadReview:', error.message);
        return res.render("review", { 
            reviews: [], 
            currentStatusFilter: 'all',
            currentTypeFilter: 'all',
            stats: { total: 0, enabled: 0, disabled: 0, recipe: 0, app: 0, approved: 0 }
        });
    }
}

//for active review
const isEnableReview = async (req, res) => {

    try {

        const loginData = await adminLoginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 1) {

            // Extract data from the request - check both params and query
            const id = req.params.id || req.query.id;

            // Validate ObjectId
            if (!id || !id.match(/^[0-9a-fA-F]{24}$/)) {
                console.log('[ERROR] Invalid ObjectId:', id);
                req.flash('error', 'Invalid review ID provided');
                return res.redirect('back');
            }

            // Find current review
            const currentReview = await reviewModel.findById(id);

            if (!currentReview) {
                console.log('[ERROR] Review not found with ID:', id);
                req.flash('error', 'Review not found');
                return res.redirect('back');
            }

            // update status
            await reviewModel.findByIdAndUpdate(id, { 
                $set: { isEnable: currentReview.isEnable === false ? true : false } 
            }, { new: true });

            console.log('[SUCCESS] Review status updated:', id);
            req.flash('success', 'Review status updated successfully');
            return res.redirect('back');

        }
        else {

            req.flash('error', 'You have no access to enable/disable review, Only admin have access to this functionality...!!');
            return res.redirect('back');
        }

    } catch (error) {
        console.log('[ERROR] isEnableReview:', error.message);
        req.flash('error', 'Error updating review status');
        return res.redirect('back');
    }
}

// Load view for recipe reviews only
const loadRecipeReviews = async (req, res) => {
    try {
        // Get filter parameter
        const statusFilter = req.query.status || 'all';
        
        // Build query for recipe reviews only
        let query = {
            $and: [
                {
                    $or: [
                        { feedbackType: 'recipe' },
                        { recipeId: { $exists: true, $ne: null } }
                    ]
                }
            ]
        };
        
        // Status filter
        if (statusFilter === 'enabled') {
            query.$and.push({ isEnable: true });
        } else if (statusFilter === 'disabled') {
            query.$and.push({ isEnable: false });
        }

        console.log('[DEBUG] Recipe Reviews Filter Query:', JSON.stringify(query, null, 2));

        // Fetch recipe reviews only
        const allReviews = await reviewModel.find(query)
            .populate("userId")
            .populate({
                path: "recipeId",
                select: "name image"
            })
            .sort({ createdAt: -1 });

        // Filter to only include reviews with recipes
        const reviews = allReviews.filter(review => review.recipeId && review.recipeId.name);

        console.log('[DEBUG] Found recipe reviews count:', reviews.length);

        // Setting Data in session for CSRF protection
        const settingData = await settingModel.findOne();
        
        console.log('[DEBUG] About to render recipe-reviews.ejs');
        console.log('[DEBUG] Current working directory:', process.cwd());
        console.log('[DEBUG] Views directory should be:', './views/admin');
        
        return res.render('recipe-reviews', { 
            settingData, 
            reviews,
            currentFilter: statusFilter,
            flash: {
                success: req.flash('success'),
                error: req.flash('error')
            }
        });

    } catch (error) {
        console.log('[ERROR] loadRecipeReviews:', error.message);
        req.flash('error', 'Error loading recipe reviews');
        return res.redirect('/dashboard');
    }
}

// Load view for app feedback only
const loadAppFeedback = async (req, res) => {
    try {
        // Get filter parameter
        const statusFilter = req.query.status || 'all';
        
        // Build query for app feedback only
        let query = {
            $and: [
                {
                    $or: [
                        { feedbackType: 'app' },
                        { recipeId: { $exists: false } },
                        { recipeId: null }
                    ]
                }
            ]
        };
        
        // Status filter
        if (statusFilter === 'enabled') {
            query.$and.push({ isEnable: true });
        } else if (statusFilter === 'disabled') {
            query.$and.push({ isEnable: false });
        }

        console.log('[DEBUG] App Feedback Filter Query:', JSON.stringify(query, null, 2));

        // Fetch app feedback only
        const allReviews = await reviewModel.find(query)
            .populate("userId")
            .sort({ createdAt: -1 });

        // Filter to only include feedback without recipes
        const reviews = allReviews.filter(review => !review.recipeId || !review.recipeId.name);

        console.log('[DEBUG] Found app feedback count:', reviews.length);

        // Setting Data in session for CSRF protection
        const settingData = await settingModel.findOne();
        
        console.log('[DEBUG] About to render app-feedback.ejs');
        console.log('[DEBUG] Current working directory:', process.cwd());
        console.log('[DEBUG] Views directory should be:', './views/admin');
        
        return res.render('app-feedback', { 
            settingData, 
            reviews,
            currentFilter: statusFilter,
            flash: {
                success: req.flash('success'),
                error: req.flash('error')
            }
        });

    } catch (error) {
        console.log('[ERROR] loadAppFeedback:', error.message);
        req.flash('error', 'Error loading app feedback');
        return res.redirect('/dashboard');
    }
}

module.exports = {
    loadReview,
    isEnableReview,
    loadRecipeReviews,
    loadAppFeedback,
}