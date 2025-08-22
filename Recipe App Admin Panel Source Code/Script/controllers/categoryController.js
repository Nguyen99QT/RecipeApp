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

        //  fetch admin
        const loginData = await loginModel.find();

        return res.render("category", { category, loginData });

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

        const recipes = await recipeModel.find({ categoryId: id });

        recipes.map(async (item) => {

            //delete image
            deleteImages(item.image);

            // delete gallery
            item.gallery.map((image) => {
                deleteImages(image);
            })

            if (item.video) {
                //delete video
                deleteVideo(item.video);
            }

            // delete recipe review
            await reviewModel.deleteMany({ recipeId: item._id });

            //delete user favourite recipe
            await favouriteRecipeModel.deleteMany({ recipeId: item._id });

        });

        //delete  recipe
        await recipeModel.deleteMany({ categoryId: id });

        // delete category
        const deletedCategory = await categoryModel.deleteOne({ _id: id });

        return res.redirect('back');

    } catch (error) {
        console.log(error.message);
    }
}

module.exports = {
    loadcategory,
    addCategory,
    editCategory,
    deleteCategory
}