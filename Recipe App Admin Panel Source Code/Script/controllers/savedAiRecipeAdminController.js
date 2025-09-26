// Importing models
const savedAiRecipeModel = require("../model/savedAiRecipeModel");
const userModel = require("../model/userModel");
const loginModel = require("../model/adminLoginModel");

// Load Saved AI Recipes page
const loadSavedAiRecipes = async (req, res) => {
    try {
        console.log("[DEBUG] Loading Saved AI Recipes page...");
        
        // Get filter parameters
        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const skip = (page - 1) * limit;
        const search = req.query.search || '';
        const cuisine = req.query.cuisine || '';
        const difficulty = req.query.difficulty || '';
        const userId = req.query.userId || ''; // New: filter by user
        const sortBy = req.query.sort || 'savedAt';
        const sortOrder = req.query.order === 'asc' ? 1 : -1;

        // Build query filter
        let filter = { status: 'active' };
        
        // Filter by specific user if provided
        if (userId) {
            filter.userId = userId;
        }
        
        if (search) {
            filter.$or = [
                { title: { $regex: search, $options: 'i' } },
                { description: { $regex: search, $options: 'i' } },
                { userEmail: { $regex: search, $options: 'i' } },
                { ingredients: { $elemMatch: { $regex: search, $options: 'i' } } },
                { tags: { $elemMatch: { $regex: search, $options: 'i' } } }
            ];
        }

        if (cuisine) {
            filter.cuisine = { $regex: cuisine, $options: 'i' };
        }

        if (difficulty) {
            filter.difficulty = { $regex: difficulty, $options: 'i' };
        }

        // Build sort object
        let sortObj = {};
        sortObj[sortBy] = sortOrder;

        // Fetch saved AI recipes with pagination
        const savedAiRecipes = await savedAiRecipeModel.find(filter)
            .populate('userId', 'firstname lastname email avatar')
            .sort(sortObj)
            .limit(limit)
            .skip(skip);

        // Get total count for pagination
        const totalCount = await savedAiRecipeModel.countDocuments(filter);
        const totalPages = Math.ceil(totalCount / limit);

        // Get unique values for filters
        const cuisines = await savedAiRecipeModel.distinct('cuisine', { status: 'active' });
        const difficulties = await savedAiRecipeModel.distinct('difficulty', { status: 'active' });

        // Get list of users who have saved AI recipes for filter dropdown
        const usersWithRecipes = await savedAiRecipeModel.aggregate([
            { $match: { status: 'active' } },
            {
                $group: {
                    _id: '$userId',
                    userEmail: { $first: '$userEmail' },
                    recipeCount: { $sum: 1 }
                }
            },
            {
                $lookup: {
                    from: 'users',
                    localField: '_id',
                    foreignField: '_id',
                    as: 'userInfo'
                }
            },
            {
                $project: {
                    userId: '$_id',
                    userEmail: '$userEmail',
                    recipeCount: '$recipeCount',
                    userName: {
                        $cond: [
                            { $gt: [{ $size: '$userInfo' }, 0] },
                            { $concat: [
                                { $arrayElemAt: ['$userInfo.firstname', 0] }, 
                                ' ', 
                                { $arrayElemAt: ['$userInfo.lastname', 0] }
                            ]},
                            '$userEmail'
                        ]
                    }
                }
            },
            { $sort: { recipeCount: -1 } }
        ]);

        // Get statistics
        const stats = {
            total: await savedAiRecipeModel.countDocuments({ status: 'active' }),
            today: await savedAiRecipeModel.countDocuments({
                status: 'active',
                savedAt: { $gte: new Date(new Date().setHours(0, 0, 0, 0)) }
            }),
            thisWeek: await savedAiRecipeModel.countDocuments({
                status: 'active',
                savedAt: { $gte: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000) }
            }),
            thisMonth: await savedAiRecipeModel.countDocuments({
                status: 'active',
                savedAt: { $gte: new Date(new Date().getFullYear(), new Date().getMonth(), 1) }
            })
        };

        // Fetch admin data
        const loginData = await loginModel.find();

        return res.render("savedAiRecipes", { 
            savedAiRecipes,
            loginData,
            currentPage: page,
            totalPages,
            totalCount,
            limit,
            search,
            cuisine,
            difficulty,
            userId,
            sortBy,
            sortOrder: req.query.order || 'desc',
            cuisines,
            difficulties,
            usersWithRecipes,
            stats,
            IMAGE_URL: process.env.IMAGE_URL
        });

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Có lỗi xảy ra. Vui lòng thử lại.');
        res.redirect(req.get('Referrer') || '/');
    }
};

// View Saved AI Recipe Details
const viewSavedAiRecipe = async (req, res) => {
    try {
        const id = req.query.id;

        // Fetch saved AI recipe details
        const savedAiRecipe = await savedAiRecipeModel.findById(id)
            .populate('userId', 'firstname lastname email avatar');

        if (!savedAiRecipe) {
            req.flash('error', 'Không tìm thấy công thức AI đã lưu.');
            return res.redirect('/saved-ai-recipes');
        }

        // Fetch admin data
        const loginData = await loginModel.find();

        return res.render("savedAiRecipeDetail", { savedAiRecipe, loginData, IMAGE_URL: process.env.IMAGE_URL });

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Có lỗi xảy ra. Vui lòng thử lại.');
        res.redirect(req.get('Referrer') || '/');
    }
};

// Delete Saved AI Recipe (Admin)
const deleteSavedAiRecipe = async (req, res) => {
    try {
        const id = req.query.id;

        // Soft delete the saved AI recipe
        await savedAiRecipeModel.updateOne(
            { _id: id }, 
            { status: 'deleted' }
        );

        req.flash('success', 'Công thức AI đã được xóa thành công.');
        return res.redirect('/saved-ai-recipes');

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Có lỗi xảy ra. Vui lòng thử lại.');
        res.redirect(req.get('Referrer') || '/');
    }
};

// Get Saved AI Recipe Statistics (AJAX)
const getSavedAiRecipeStats = async (req, res) => {
    try {
        const totalSavedRecipes = await savedAiRecipeModel.countDocuments({ status: 'active' });
        
        const todayStart = new Date();
        todayStart.setHours(0, 0, 0, 0);
        const todaySavedRecipes = await savedAiRecipeModel.countDocuments({
            status: 'active',
            savedAt: { $gte: todayStart }
        });

        // Most active users (who saved most recipes)
        const topSavers = await savedAiRecipeModel.aggregate([
            { $match: { status: 'active' } },
            {
                $group: {
                    _id: '$userId',
                    count: { $sum: 1 },
                    email: { $first: '$userEmail' }
                }
            },
            {
                $lookup: {
                    from: 'users',
                    localField: '_id',
                    foreignField: '_id',
                    as: 'user'
                }
            },
            {
                $unwind: { 
                    path: '$user',
                    preserveNullAndEmptyArrays: true
                }
            },
            {
                $project: {
                    count: 1,
                    name: { 
                        $cond: [
                            { $ne: ['$user', null] },
                            { $concat: ['$user.firstname', ' ', '$user.lastname'] },
                            '$email'
                        ]
                    },
                    email: { 
                        $cond: [
                            { $ne: ['$user', null] },
                            '$user.email',
                            '$email'
                        ]
                    }
                }
            },
            { $sort: { count: -1 } },
            { $limit: 5 }
        ]);

        // Popular cuisines
        const popularCuisines = await savedAiRecipeModel.aggregate([
            { $match: { status: 'active' } },
            {
                $group: {
                    _id: '$cuisine',
                    count: { $sum: 1 }
                }
            },
            { $sort: { count: -1 } },
            { $limit: 10 }
        ]);

        return res.json({
            success: true,
            data: {
                totalSavedRecipes,
                todaySavedRecipes,
                topSavers,
                popularCuisines
            }
        });

    } catch (error) {
        console.log(error.message);
        return res.json({
            success: false,
            message: 'Có lỗi xảy ra khi tải thống kê.'
        });
    }
};

// Export recipes data
const exportSavedAiRecipes = async (req, res) => {
    try {
        const savedAiRecipes = await savedAiRecipeModel.find({ status: 'active' })
            .populate('userId', 'firstname lastname email')
            .sort({ savedAt: -1 });

        const csvData = savedAiRecipes.map(recipe => ({
            ID: recipe.id,
            Title: recipe.title,
            Cuisine: recipe.cuisine,
            Difficulty: recipe.difficulty,
            'Preparation Time': recipe.preparationTime + ' phút',
            'Cooking Time': recipe.cookingTime + ' phút',
            Servings: recipe.servings,
            'User Name': recipe.userId ? `${recipe.userId.firstname} ${recipe.userId.lastname}` : 'N/A',
            'User Email': recipe.userEmail,
            'Saved At': recipe.savedAt.toISOString().split('T')[0],
            Tags: recipe.tags.join(', ')
        }));

        return res.json({
            success: true,
            data: csvData,
            filename: `saved_ai_recipes_${new Date().toISOString().split('T')[0]}.csv`
        });

    } catch (error) {
        console.log(error.message);
        return res.json({
            success: false,
            message: 'Có lỗi xảy ra khi xuất dữ liệu.'
        });
    }
};

module.exports = {
    loadSavedAiRecipes,
    viewSavedAiRecipe,
    deleteSavedAiRecipe,
    getSavedAiRecipeStats,
    exportSavedAiRecipes
};