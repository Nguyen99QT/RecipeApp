// Importing models
const categoryModel = require("../model/categoryModel");
const recipeModel = require("../model/recipeModel");
const reviewModel = require("../model/reviewModel");
const favouriteRecipeModel = require("../model/favouriteRecipeModel");
const loginModel = require("../model/adminLoginModel");

// Importing the service function to delete uploaded files
const { deleteImages, deleteVideo } = require("../services/deleteImage");

//Add a new category
const addCategory = async (req, res) => {

    try {

        // Extract data from the request
        const name = req.body.name;

        //save category
        const newCategory = await new categoryModel({ name }).save();

        return res.redirect('back');

    } catch (error) {
        console.log(error.message);
    }
}

// Load view for all category
const loadcategory = async (req, res) => {

    try {

        //fetch all category data
        const category = await categoryModel.find();

        // Add recipe count for each category
        const categoryWithCounts = await Promise.all(category.map(async (cat) => {
            const recipeCount = await recipeModel.countDocuments({ categoryId: cat._id });
            return {
                ...cat.toObject(),
                recipeCount: recipeCount
            };
        }));

        //  fetch admin
        const loginData = await loginModel.find();

        return res.render("category", { category: categoryWithCounts, loginData });

    } catch (error) {
        console.log(error.message);
    }
}

//Edit a category
const editCategory = async (req, res) => {

    try {

        // Extract data from the request
        const id = req.body.id;
        const name = req.body.name;

        // update category
        const updatedCategory = await categoryModel.findOneAndUpdate({ _id: id }, { $set: { name } }, { new: true });

        return res.redirect('back');

    } catch (error) {
        console.log(error.message);
    }
}

// delete category
const deleteCategory = async (req, res) => {

    try {

        // Extract data from the request
        const id = req.query.id;

        console.log(`[DELETE CATEGORY] Checking category ID: ${id}`);

        // First check if category exists
        const category = await categoryModel.findById(id);
        if (!category) {
            req.flash('error', 'Category not found!');
            return res.redirect('back');
        }

        // Check if there are recipes using this category
        const recipeCount = await recipeModel.countDocuments({ categoryId: id });
        console.log(`[DELETE CATEGORY] Found ${recipeCount} recipes using this category`);

        if (recipeCount > 0) {
            // Prevent deletion and show error message
            req.flash('error', `Cannot delete category "${category.name}" because it contains ${recipeCount} recipe(s). Please move or delete the recipes first.`);
            console.log(`[DELETE CATEGORY] Deletion blocked - category contains ${recipeCount} recipes`);
            return res.redirect('back');
        }

        // If no recipes, proceed with deletion
        const deletedCategory = await categoryModel.deleteOne({ _id: id });
        console.log(`[DELETE CATEGORY] Category "${category.name}" deleted successfully`);

        req.flash('success', `Category "${category.name}" has been deleted successfully.`);

        return res.redirect('back');

    } catch (error) {
        console.log('[DELETE CATEGORY ERROR]:', error.message);
        req.flash('error', 'An error occurred while deleting the category. Please try again.');
        return res.redirect('back');
    }
}

// Check category usage before delete
const checkCategoryUsage = async (req, res) => {
    try {
        const id = req.query.id;
        
        const recipeCount = await recipeModel.countDocuments({ categoryId: id });
        const category = await categoryModel.findById(id);
        
        if (!category) {
            return res.status(404).json({
                status: false,
                message: 'Category not found'
            });
        }
        
        return res.json({
            status: true,
            data: {
                categoryName: category.name,
                recipeCount: recipeCount,
                canDelete: true,
                warningMessage: recipeCount > 0 ? 
                    `This will delete ${recipeCount} recipe(s) and all related data (reviews, favourites, images, videos)` : 
                    'This category can be safely deleted'
            }
        });
        
    } catch (error) {
        console.log('[CHECK CATEGORY USAGE ERROR]:', error.message);
        return res.status(500).json({
            status: false,
            message: 'Error checking category usage'
        });
    }
}

module.exports = {
    loadcategory,
    addCategory,
    editCategory,
    deleteCategory,
    checkCategoryUsage
}