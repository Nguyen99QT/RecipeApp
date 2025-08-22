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

        //save cuisines
        const newCuisines = await new cuisinesModel({ name }).save();

        return res.redirect('back');

    } catch (error) {
        console.log(error.message);
    }
}

// Load view for all cuisines
const loadCuisines = async (req, res) => {

    try {

        // Fetch all  cuisines data 
        const cuisines = await cuisinesModel.find();

        //  fetch admin
        const loginData = await loginModel.find();

        return res.render("cuisines", { cuisines, loginData });

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

        //update cuisines
        const updatedCuisines = await cuisinesModel.findOneAndUpdate({ _id: id }, { $set: { name } }, { new: true });

        return res.redirect('back');

    } catch (error) {
        console.log(error.message);
    }
}

//delete a cuisines
const deleteCuisines = async (req, res) => {

    try {

        // Extract data from the request
        const id = req.query.id;

        const recipes = await recipeModel.find({ cuisinesId: id });

        recipes.map(async (item) => {
            // delete image
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
        })

        // delete recipe
        await recipeModel.deleteMany({ cuisinesId: id });

        // delete cuisines
        const deletedCuisines = await cuisinesModel.deleteOne({ _id: id });

        return res.redirect('back');

    } catch (error) {
        console.log(error.message);
    }
}

module.exports = {
    addCuisines,
    loadCuisines,
    editCuisines,
    deleteCuisines
}


