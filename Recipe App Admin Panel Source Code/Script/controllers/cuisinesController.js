// Importing models
const cuisinesModel = require("../model/cuisinesModel");
const recipeModel = require("../model/recipeModel");
const reviewModel = require("../model/reviewModel");
const favouriteRecipeModel = require("../model/favouriteRecipeModel");
const loginModel = require("../model/adminLoginModel");

// Importing the service function to delete uploaded files
const { deleteImages, deleteVideo } = require("../services/deleteImage");

// Add a new cuisines
const addCuisines = async (req, res) => {

    try {

        // Extract data from the request
        const name = req.body.name;

        // Check if cuisine name already exists (case insensitive)
        const existingCuisine = await cuisinesModel.findOne({ 
            name: { $regex: new RegExp(`^${name}$`, 'i') } 
        });

        if (existingCuisine) {
            req.flash('error', `Cuisine "${name}" already exists! Please choose a different name.`);
            return res.redirect('back');
        }

        //save cuisines
        const newCuisines = await new cuisinesModel({ name }).save();

        req.flash('success', `Cuisine "${name}" has been added successfully.`);
        return res.redirect('back');

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'An error occurred while adding the cuisine. Please try again.');
        return res.redirect('back');
    }
}

// Load view for all cuisines
const loadCuisines = async (req, res) => {

    try {

        // Fetch all cuisines data 
        const cuisines = await cuisinesModel.find();

        // Add recipe count for each cuisine
        const cuisinesWithCounts = await Promise.all(cuisines.map(async (cuisine) => {
            const recipeCount = await recipeModel.countDocuments({ cuisinesId: cuisine._id });
            return {
                ...cuisine.toObject(),
                recipeCount: recipeCount
            };
        }));

        //  fetch admin
        const loginData = await loginModel.find();

        return res.render("cuisines", { cuisines: cuisinesWithCounts, loginData });

    } catch (error) {
        console.log(error.message);
    }
}

//Edit a cuisines
const editCuisines = async (req, res) => {

    try {

        // Extract data from the request
        const id = req.body.id;
        const name = req.body.name;

        // Check if another cuisine with the same name already exists (excluding current cuisine)
        const existingCuisine = await cuisinesModel.findOne({ 
            name: { $regex: new RegExp(`^${name}$`, 'i') },
            _id: { $ne: id }
        });

        if (existingCuisine) {
            req.flash('error', `Cuisine "${name}" already exists! Please choose a different name.`);
            return res.redirect('back');
        }

        //update cuisines
        const updatedCuisines = await cuisinesModel.findOneAndUpdate({ _id: id }, { $set: { name } }, { new: true });

        if (updatedCuisines) {
            req.flash('success', `Cuisine has been updated to "${name}" successfully.`);
        } else {
            req.flash('error', 'Cuisine not found!');
        }

        return res.redirect('back');

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'An error occurred while updating the cuisine. Please try again.');
        return res.redirect('back');
    }
}

//delete a cuisines
const deleteCuisines = async (req, res) => {

    try {

        // Extract data from the request
        const id = req.query.id;

        console.log(`[DELETE CUISINE] Checking cuisine ID: ${id}`);

        // First check if cuisine exists
        const cuisine = await cuisinesModel.findById(id);
        if (!cuisine) {
            req.flash('error', 'Cuisine not found!');
            return res.redirect('back');
        }

        // Check if there are recipes using this cuisine
        const recipeCount = await recipeModel.countDocuments({ cuisinesId: id });
        console.log(`[DELETE CUISINE] Found ${recipeCount} recipes using this cuisine`);

        if (recipeCount > 0) {
            // Prevent deletion and show error message
            req.flash('error', `Cannot delete cuisine "${cuisine.name}" because it contains ${recipeCount} recipe(s). Please move or delete the recipes first.`);
            console.log(`[DELETE CUISINE] Deletion blocked - cuisine contains ${recipeCount} recipes`);
            return res.redirect('back');
        }

        // If no recipes, proceed with deletion
        const deletedCuisine = await cuisinesModel.deleteOne({ _id: id });
        console.log(`[DELETE CUISINE] Cuisine "${cuisine.name}" deleted successfully`);

        req.flash('success', `Cuisine "${cuisine.name}" has been deleted successfully.`);

        return res.redirect('back');

    } catch (error) {
        console.log('[DELETE CUISINE ERROR]:', error.message);
        req.flash('error', 'An error occurred while deleting the cuisine. Please try again.');
        return res.redirect('back');
    }
}

module.exports = {
    addCuisines,
    loadCuisines,
    editCuisines,
    deleteCuisines
}


