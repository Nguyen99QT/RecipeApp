// Importing models
const categoryModel = require("../model/categoryModel");
const cuisinesModel = require("../model/cuisinesModel");
const recipeModel = require("../model/recipeModel");
const reviewModel = require("../model/reviewModel");
const userNotificationModel = require("../model/userNotificationModel");
const favouriteRecipeModel = require("../model/favouriteRecipeModel");
const loginModel = require("../model/adminLoginModel");

// Importing the service function to delete uploaded files
const { deleteImages, deleteVideo } = require("../services/deleteImage");

// Load view for adding a recipe
const loadAddRecipe = async (req, res) => {

    try {

        // fetch category
        const category = await categoryModel.find();

        // fetch cuisines
        const cuisines = await cuisinesModel.find();

        // Flash middleware already sets res.locals.flash
        console.log('Flash messages in loadAddRecipe (should be in res.locals)');

        return res.render("addRecipe", { 
            category, 
            cuisines
        });

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
            let ingredients = req.body.ingredients || req.body.ingredientslist || [];
            
            // Debug ingredients data
            console.log('Raw ingredients:', ingredients);
            console.log('Type of ingredients:', typeof ingredients);
            
            // Ensure ingredients is an array
            if (!Array.isArray(ingredients)) {
                ingredients = [ingredients].filter(Boolean);
            }
            
            // Clean up and format ingredients - keep as simple strings
            ingredients = ingredients
                .filter(ingredient => ingredient && ingredient.trim() !== '')
                .map(ingredient => {
                    // Extract string value from ingredient
                    if (typeof ingredient === 'string') {
                        return ingredient.trim();
                    } else if (ingredient.ingredients) {
                        return ingredient.ingredients.trim();
                    } else {
                        return String(ingredient).trim();
                    }
                });
            
            console.log('Processed ingredients:', ingredients);
            
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
                    name, 
                    image, 
                    ingredients,  // Now using processed ingredients directly
                    categoryId, 
                    cuisinesId, 
                    prepTime, 
                    cookTime,
                    totalCookTime, 
                    servings, 
                    difficultyLevel, 
                    url, 
                    video,
                    overview, 
                    how_to_cook: how_to_cook, 
                    gallery
                }
            ).save();

            // fetch user tokens
            const FindTokens = await userNotificationModel.find();
            const registrationTokens = Array.isArray(FindTokens) ? FindTokens.map(item => item.registrationToken).filter(token => token) : [];

            // Notification details
            const title = `Check Out Our Newest Recipe!`

            const currentDate = new Date();
            const options = { year: 'numeric', month: 'long', day: 'numeric' };
            const formattedDate = currentDate.toLocaleDateString('en-US', options)
            const message = "Great news for food lovers! We’ve just added a fresh new recipe. Check it out and get ready to enjoy a delightful new dish."

            console.log('Recipe saved successfully:', newRecipe.name);
            
            // Create a success response with SweetAlert2 popup
            return res.send(`
                <!DOCTYPE html>
                <html>
                <head>
                    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                </head>
                <body>
                    <script>
                        Swal.fire({
                            title: '🎉 Success!',
                            text: 'Recipe added successfully! The new recipe has been published.',
                            icon: 'success',
                            confirmButtonText: 'View Recipes',
                            confirmButtonColor: '#28a745',
                            allowOutsideClick: false,
                            timer: 3000,
                            timerProgressBar: true
                        }).then((result) => {
                            window.location.href = '/recipe';
                        });
                        
                        // Auto redirect after 3 seconds
                        setTimeout(() => {
                            window.location.href = '/recipe';
                        }, 3000);
                    </script>
                </body>
                </html>
            `);

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
            return res.redirect(req.get('Referrer') || '/recipe');
        }

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'An error occurred while adding the recipe. Please try again.');
        return res.redirect(req.get('Referrer') || '/addRecipe');
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

        // Flash middleware already sets res.locals.flash, no need to pass it manually
        console.log('Flash messages in getRecipe (should be in res.locals)');

        return res.render("recipe", { 
            recipe, 
            IMAGE_URL: process.env.IMAGE_URL, 
            loginData
        });

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
        let ingredients = req.body.ingredients || req.body.ingredientslist || [];
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

        // Debug ingredients data
        console.log('Edit Recipe - Raw ingredients:', ingredients);
        console.log('Edit Recipe - Type of ingredients:', typeof ingredients);
        
        // Ensure ingredients is an array and process it safely
        if (!Array.isArray(ingredients)) {
            ingredients = [ingredients].filter(Boolean);
        }
        
        // Clean up and format ingredients as strings
        ingredients = ingredients
            .filter(ingredient => ingredient && ingredient.trim !== undefined && ingredient.trim() !== '')
            .map(ingredient => {
                if (typeof ingredient === 'string') {
                    return ingredient.trim();
                } else if (ingredient.ingredients) {
                    return ingredient.ingredients.trim();
                } else {
                    return String(ingredient).trim();
                }
            });
        
        console.log('Edit Recipe - Processed ingredients:', ingredients);

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
                    name, 
                    image, 
                    categoryId, 
                    cuisinesId, 
                    prepTime, 
                    cookTime, 
                    totalCookTime, 
                    servings,
                    difficultyLevel, 
                    video, 
                    url, 
                    overview: overview,
                    ingredients: ingredients, // Now using processed ingredients directly
                    how_to_cook: how_to_cook
                }
            },
            { new: true }
        );

        if (updatedRecipe) {
            console.log('Recipe updated successfully:', updatedRecipe.name);
            
            // Send success popup
            return res.send(`
                <!DOCTYPE html>
                <html>
                <head>
                    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                </head>
                <body>
                    <script>
                        Swal.fire({
                            title: '✅ Updated Successfully!',
                            text: 'Recipe "${name}" has been updated successfully.',
                            icon: 'success',
                            confirmButtonText: 'View Recipes',
                            confirmButtonColor: '#28a745',
                            allowOutsideClick: false,
                            timer: 3000,
                            timerProgressBar: true
                        }).then((result) => {
                            window.location.href = '/recipe';
                        });
                        
                        // Auto redirect after 3 seconds
                        setTimeout(() => {
                            window.location.href = '/recipe';
                        }, 3000);
                    </script>
                </body>
                </html>
            `);
        } else {
            console.log('Failed to update recipe');
            req.flash('error', 'Failed to update recipe. Please try again.');
            return res.redirect(`/editRecipe?id=${id}`);
        }

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

        req.flash('success', 'Recipe deleted successfully');
        return res.redirect(req.get('Referrer') || '/recipe');

    } catch (error) {
        console.log(error.message);
        req.flash('error', 'An error occurred while deleting the recipe. Please try again.');
        return res.redirect(req.get('Referrer') || '/recipe');
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
        res.redirect(req.get('Referrer') || '/gallery');
    }
}

// add image 
const addImage = async (req, res) => {
    try {
        // Extract data from the request
        const id = req.body.id;

        if (!id) {
            req.flash('error', 'Recipe ID is required');
            return res.redirect(req.get('Referrer') || '/gallery');
        }

        // Extract gallery images from request
        const galleryImage = req.files['gallery'] ? req.files['gallery'].map(file => file.filename) : [];

        if (!galleryImage || galleryImage.length === 0) {
            req.flash('error', 'Please select at least one image to upload');
            return res.redirect(req.get('Referrer') || '/gallery');
        }

        // Find the existing gallery entry
        const existingGallery = await recipeModel.findById(id);
        
        if (!existingGallery) {
            req.flash('error', 'Recipe not found');
            return res.redirect('/recipe');
        }

        // Check if the gallery field is null and initialize it if necessary
        const gallery = Array.isArray(existingGallery.gallery) ? existingGallery.gallery : [];

        // Update the gallery field with new images
        await recipeModel.updateOne({ _id: id }, { $set: { gallery: gallery.concat(galleryImage) } });

        req.flash('success', `${galleryImage.length} image(s) added to gallery successfully`);
        return res.redirect(req.get('Referrer') || '/gallery');

    } catch (error) {
        console.error('Error in addImage:', error.message);
        req.flash('error', 'Something went wrong while adding images. Please try again.');
        res.redirect(req.get('Referrer') || '/gallery');
    }
}

// edit image
const editImage = async (req, res) => {
    try {
        // Extract data from the request body
        const id = req.body.id;
        const oldImage = req.body.oldImage;

        if (!id || !oldImage) {
            req.flash('error', 'Recipe ID and old image name are required');
            return res.redirect(req.get('Referrer') || '/gallery');
        }

        let galleryImage = oldImage;
        
        // Check if new image is uploaded
        if (req.file) {
            // Delete old image
            deleteImages(oldImage);
            galleryImage = req.file.filename;
        } else {
            req.flash('error', 'Please select a new image to upload');
            return res.redirect(req.get('Referrer') || '/gallery');
        }

        // Update the gallery images 
        const updateResult = await recipeModel.findOneAndUpdate(
            { _id: id, 'gallery': oldImage },
            { $set: { 'gallery.$': galleryImage } },
            { new: true }
        );

        if (!updateResult) {
            req.flash('error', 'Recipe or image not found');
            return res.redirect(req.get('Referrer') || '/gallery');
        }

        req.flash('success', 'Gallery image updated successfully');
        return res.redirect(req.get('Referrer') || '/gallery');

    } catch (error) {
        console.error('Error in editImage:', error.message);
        req.flash('error', 'Something went wrong while updating the image. Please try again.');
        return res.redirect(req.get('Referrer') || '/gallery');
    }
};

// delete image
const deleteGalleryImage = async (req, res) => {
    try {
        // Extract data from the request
        const id = req.query.id;
        const gallery = req.query.name;

        if (!id || !gallery) {
            req.flash('error', 'Recipe ID and image name are required');
            return res.redirect(req.get('Referrer') || '/gallery');
        }

        // Find the recipe to verify it exists
        const recipe = await recipeModel.findById(id);
        if (!recipe) {
            req.flash('error', 'Recipe not found');
            return res.redirect('/recipe');
        }

        // Check if the image exists in the gallery
        if (!Array.isArray(recipe.gallery) || !recipe.gallery.includes(gallery)) {
            req.flash('error', 'Image not found in gallery');
            return res.redirect(req.get('Referrer') || '/gallery');
        }

        // Delete the old image from filesystem
        deleteImages(gallery);

        // Remove image from gallery array
        await recipeModel.findByIdAndUpdate(
            { _id: id }, 
            { $pull: { gallery: { $in: [gallery] } } }, 
            { new: true }
        );

        req.flash('success', 'Gallery image deleted successfully');
        return res.redirect(req.get('Referrer') || '/gallery');

    } catch (error) {
        console.error('Error in deleteGalleryImage:', error.message);
        req.flash('error', 'Something went wrong while deleting the image. Please try again.');
        res.redirect(req.get('Referrer') || '/gallery');
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
