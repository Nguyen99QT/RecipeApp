// Importing models
const categoryModel = require("../model/categoryModel");
const cuisinesModel = require("../model/cuisinesModel");
const recipeModel = require("../model/recipeModel");
const reviewModel = require("../model/reviewModel");
const userNotificationModel = require("../model/userNotificationModel");
const favouriteRecipeModel = require("../model/favouriteRecipeModel");
const loginModel = require("../model/adminLoginModel");
const notificationModel = require("../model/notificationModel");

// Importing the service function to send notification
const sendPushNotification = require("../services/sendPushNotification");

// Importing the service function to delete uploaded files
const { deleteImages, deleteVideo } = require("../services/deleteImage");

// Load view for adding a recipe
const loadAddRecipe = async (req, res) => {

    try {

        // fetch category
        const category = await categoryModel.find();

        // fetch cuisines
        const cuisines = await cuisinesModel.find();

        return res.render("addRecipe", { category, cuisines });

    } catch (error) {
        console.log(error.message);
    }
}

// Add a new recipe
const addRecipe = async (req, res) => {

    try {

        const loginData = await loginModel.findById(req.session.userId);

        if (loginData && loginData.is_admin === 1) {

            // Extract data from the request body
            const name = req.body.recipename;
            const ingredients = req.body.ingredientslist;
            const categoryId = req.body.category;
            const cuisinesId = req.body.cuisines;
            const prepTime = req.body.prepTime;
            const cookTime = req.body.cookTime;
            const totalCookTime = req.body.totalCookTime;
            const servings = req.body.servings;
            const difficultyLevel = req.body.difficultyLevel;
            const url = req.body.url;
            const overview = req.body.overview.replace(/"/g, '&quot;');
            const how_to_cook = req.body.how_to_cook.replace(/"/g, '&quot;');
            const image = req.files['image'] ? req.files['image'][0].filename : null;
            const gallery = req.files['gallery'] ? req.files['gallery'].map(file => file.filename) : [];
            const video = req.files['video'] ? req.files['video'][0].filename : null;

            //save recipe
            const newRecipe = await new recipeModel(
                {
                    name, image, ingredients: ingredients.map(item => item.ingredients), categoryId, cuisinesId, prepTime, cookTime,
                    totalCookTime, servings, difficultyLevel, url, video,
                    overview, how_to_cook: how_to_cook, gallery
                }
            ).save();

            // fetch user tokens
            const FindTokens = await userNotificationModel.find();
            const registrationTokens = FindTokens.map(item => item.registrationToken);

            // Notification details
            const title = `Check Out Our Newest Recipe!`

            const currentDate = new Date();
            const options = { year: 'numeric', month: 'long', day: 'numeric' };
            const formattedDate = currentDate.toLocaleDateString('en-US', options)
            const message = "Great news for food lovers! We’ve just added a fresh new recipe. Check it out and get ready to enjoy a delightful new dish."

            // save notification
            const newNotification = await notificationModel({ title: title, date: formattedDate, message }).save();

            // send notification
            await sendPushNotification(registrationTokens, title, message);

            return res.redirect('/recipe');

        } else {

            const image = req.files?.image?.[0]?.filename || "";
            const video = req.files?.video?.[0]?.filename || "";

            // Delete images in the gallery if any
            if (req.files && req.files['gallery']) {
                const galleryImages = req.files['gallery'].map(file => file.filename);
                for (const galleryImage of galleryImages) {
                    deleteImages(galleryImage);
                }
            }

            if (image) deleteImages(image);
            if (video) deleteVideo(video);

            req.flash('error', 'You have no access to add recipe, Only admin have access to this functionality...!!');
            return res.redirect('back');
        }

    } catch (error) {
        console.log(error.message);
        return res.redirect('back');
    }
}

// Load view for all recipe
const loadRecipe = async (req, res) => {

    try {

        // Fetch all recipe data 
        const recipe = await recipeModel.find()
            .populate({
                path: 'categoryId',
                select: 'name',
                model: 'categories'
            })
            .populate({
                path: 'cuisinesId', 
                select: 'name',
                model: 'cuisines'
            });

        //  fetch admin
        const loginData = await loginModel.find();

        return res.render("recipe", { recipe, IMAGE_URL: process.env.IMAGE_URL, loginData });

    } catch (error) {
        console.log(error.message);
    }
}

// Load view for editing a recipe
const loadEditRecipe = async (req, res) => {

    try {

        // Extract data from the request
        const id = req.query.id;

        // fetch recipe
        const recipe = await recipeModel.findById(id);

        // fetch category
        const category = await categoryModel.find();

        // fetch cuisines
        const cuisines = await cuisinesModel.find();

        return res.render("editRecipe", { recipe, category, cuisines, IMAGE_URL: process.env.IMAGE_URL });

    } catch (error) {
        console.log(error.message);
    }
}

// Edit a recipe
const editRecipe = async (req, res) => {

    try {

        // Extract data from the request
        const id = req.body.id;
        const name = req.body.recipename;
        const ingredients = req.body.ingredientslist;
        const oldImage = req.body.oldImage;
        const categoryId = req.body.category;
        const cuisinesId = req.body.cuisines;
        const prepTime = req.body.prepTime;
        const cookTime = req.body.cookTime;
        const totalCookTime = req.body.totalCookTime;
        const servings = req.body.servings;
        const difficultyLevel = req.body.difficultyLevel;
        const oldVideo = req.body.oldVideo;
        const url = req.body.url;
        const overview = req.body.overview.replace(/"/g, '&quot;');
        const how_to_cook = req.body.how_to_cook.replace(/"/g, '&quot;');

        let image = oldImage;
        if (req.files && req.files['image'] && req.files['image'][0]) {
            //delete old image
            deleteImages(oldImage);
            image = req.files['image'][0].filename;

        }

        let video = oldVideo;
        if (req.files && req.files['video'] && req.files['video'][0]) {
            //delete old  video
            deleteVideo(oldVideo);
            video = req.files['video'][0].filename;

        }

        //update recipe
        const updatedRecipe = await recipeModel.findByIdAndUpdate(
            { _id: id },
            {
                $set: {
                    name, image, categoryId, cuisinesId, prepTime, cookTime, totalCookTime, servings,
                    difficultyLevel, video, url, overview: overview,
                    ingredients: ingredients.map(item => item.ingredients), how_to_cook: how_to_cook
                }
            },
            { new: true }
        );

        return res.redirect("/recipe");

    } catch (error) {
        console.log(error.message);
    }
}

// delete recipe
const deleteRecipe = async (req, res) => {

    try {

        const id = req.query.id;

        const recipe = await recipeModel.findById(id);

        // delete recipe image
        deleteImages(recipe.image);

        if (recipe.video) {
            // delete recipe video
            deleteVideo(recipe.video);
        }

        // delete gallery
        recipe.gallery.map((image) => {
            deleteImages(image);
        })

        // delete review
        await reviewModel.deleteMany({ recipeId: id });

        // delete favourite recipe
        await favouriteRecipeModel.deleteMany({ recipeId: id })

        // delete recipe
        await recipeModel.deleteOne({ _id: id });

        return res.redirect('back');

    } catch (error) {
        console.log(error.message);
    }
}


// Load and render the view for gallery
const loadGallery = async (req, res) => {

    try {

        // Extract data from the request
        const id = req.query.id;

        // fetch gallery image
        const galleryImages = await recipeModel.findById(id);

        // fetch admin
        const loginData = await loginModel.find();

        return res.render("gallery", { galleryImages, loginData, IMAGE_URL: process.env.IMAGE_URL });

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
}

// add image 
const addImage = async (req, res) => {

    try {

        // Extract data from the request
        const id = req.body.id;

        // Extract gallery images from request
        const galleryImage = req.files['gallery'] ? req.files['gallery'].map(file => file.filename) : [];

        // Find the existing gallery entry
        const existingGallery = await recipeModel.findById(id);

        // Check if the gallery field is null and initialize it if necessary
        const gallery = existingGallery.gallery || [];

        // Update the gallery field with new images
        await recipeModel.updateOne({ _id: id }, { $set: { gallery: gallery.concat(galleryImage) } });

        return res.redirect('back');

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
}

// edit image
const editImage = async (req, res) => {

    try {

        // Extract data from the request body
        const id = req.body.id;
        const oldImage = req.body.oldImage;

        let galleryImage = oldImage;
        // old image delete
        if (req.file) {
            deleteImages(oldImage);
            galleryImage = req.file.filename;
        }

        // Update the gallery images 
        const updateResult = await recipeModel.findOneAndUpdate(
            { _id: id, 'gallery': oldImage },
            { $set: { 'gallery.$': galleryImage } },
            { new: true }
        );

        return res.redirect('back');

    } catch (error) {
        console.error('Error in editImage:', error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        return res.redirect('back');
    }
};

// delete image
const deleteGalleryImage = async (req, res) => {

    try {

        // Extract data from the request
        const id = req.query.id;
        const gallery = req.query.name;

        // Delete the old image
        deleteImages(gallery);

        // update gallery image
        await recipeModel.findByIdAndUpdate({ _id: id }, { $pull: { gallery: { $in: [gallery] } } }, { new: true });

        return res.redirect('back');

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'Something went wrong. Please try again.');
        res.redirect('back');
    }
}

module.exports = {

    loadAddRecipe,
    addRecipe,
    loadRecipe,
    loadEditRecipe,
    editRecipe,
    deleteRecipe,
    loadGallery,
    addImage,
    editImage,
    deleteGalleryImage
}