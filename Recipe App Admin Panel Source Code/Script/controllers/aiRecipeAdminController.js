// Importing models
const aiRecipeModel = require("../model/aiRecipeModel");
const userModel = require("../model/userModel");
const loginModel = require("../model/adminLoginModel");

// Load AI Recipes page
const loadAiRecipes = async (req, res) => {
    try {
        // Fetch all AI recipes with user information
        const aiRecipes = await aiRecipeModel.find()
            .populate('userId', 'firstname lastname email')
            .sort({ createdAt: -1 });

        // Fetch admin data
        const loginData = await loginModel.find();

        return res.render("aiRecipes", { aiRecipes, loginData });

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
};

// View AI Recipe Details
const viewAiRecipe = async (req, res) => {
    try {
        const id = req.query.id;

        // Fetch AI recipe details
        const aiRecipe = await aiRecipeModel.findById(id)
            .populate('userId', 'firstname lastname email avatar');

        if (!aiRecipe) {
            req.flash('error', 'AI Recipe not found.');
            return res.redirect('/ai-recipes');
        }

        // Fetch admin data
        const loginData = await loginModel.find();

        return res.render("aiRecipeDetail", { aiRecipe, loginData });

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
};

// Delete AI Recipe (Admin)
const deleteAiRecipe = async (req, res) => {
    try {
        const id = req.query.id;

        // Delete the AI recipe
        await aiRecipeModel.deleteOne({ _id: id });

        req.flash('success', 'AI Recipe deleted successfully.');
        return res.redirect('/ai-recipes');

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
};

// Get AI Recipe Statistics
const getAiRecipeStats = async (req, res) => {
    try {
        const totalAiRecipes = await aiRecipeModel.countDocuments();
        const todayStart = new Date();
        todayStart.setHours(0, 0, 0, 0);
        
        const todayAiRecipes = await aiRecipeModel.countDocuments({
            createdAt: { $gte: todayStart }
        });

        const topUsers = await aiRecipeModel.aggregate([
            {
                $group: {
                    _id: '$userId',
                    count: { $sum: 1 }
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
                $unwind: '$user'
            },
            {
                $project: {
                    _id: 1,
                    count: 1,
                    name: { $concat: ['$user.firstname', ' ', '$user.lastname'] },
                    email: '$user.email'
                }
            },
            {
                $sort: { count: -1 }
            },
            {
                $limit: 5
            }
        ]);

        return res.json({
            status: true,
            data: {
                totalAiRecipes,
                todayAiRecipes,
                topUsers
            }
        });

    } catch (error) {
        console.log(error.message);
        return res.status(500).json({
            status: false,
            message: "Internal server error"
        });
    }
};

module.exports = {
    loadAiRecipes,
    viewAiRecipe,
    deleteAiRecipe,
    getAiRecipeStats
};
