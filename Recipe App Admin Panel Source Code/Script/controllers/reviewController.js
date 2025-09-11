
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
        const reviews = await reviewModel.find(query)
            .populate("userId")
            .populate({
                path: "recipeId",
                select: "name image"
            })
            .sort({ createdAt: -1 }); // Sắp xếp mới nhất trước

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

            // Extract data from the request
            const id = req.query.id;

            // Find current images
            const currentReview = await reviewModel.findById({ _id: id });

            // update status
            await reviewModel.findByIdAndUpdate({ _id: id }, { $set: { isEnable: currentReview.isEnable === false ? true : false } }, { new: true });

            return res.redirect('back');

        }
        else {

            req.flash('error', 'You have no access to enable/disable review, Only admin have access to this functionality...!!');
            return res.redirect('back');
        }

    } catch (error) {
        console.log(error.message);
    }
}

module.exports = {
    loadReview,
    isEnableReview,
}