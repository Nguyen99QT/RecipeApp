const mongoose = require('mongoose');
const recipeModel = require('./model/recipeModel');
const cuisinesModel = require('./model/cuisinesModel');
const categoryModel = require('./model/categoryModel');

// Database connection
const connectDB = async () => {
    try {
        await mongoose.connect('mongodb://localhost:27017/food-recipe', {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });
        console.log('✅ MongoDB connected successfully');
    } catch (error) {
        console.error('❌ MongoDB connection error:', error.message);
        process.exit(1);
    }
};

// Update recipe with cuisinesId
const updateRecipeWithCuisine = async () => {
    await connectDB();
    
    try {
        // Find the recipe
        const recipeId = '68a17328e02661538f117091';
        const recipe = await recipeModel.findById(recipeId);
        
        if (!recipe) {
            console.log('❌ Recipe not found');
            return;
        }
        
        console.log('✅ Current recipe:', recipe.name);
        console.log('Current cuisinesId:', recipe.cuisinesId);
        
        // Update with Chinese cuisine (since it's Honey Chilli Potato - Chinese dish)
        const chineseCuisineId = '68a17328e02661538f11707b'; // Chinese cuisine from database
        
        const updatedRecipe = await recipeModel.findByIdAndUpdate(
            recipeId,
            { cuisinesId: chineseCuisineId },
            { new: true }
        ).populate('cuisinesId', 'name').populate('categoryId', 'name');
        
        console.log('✅ Recipe updated successfully!');
        console.log('Updated cuisinesId:', updatedRecipe.cuisinesId);
        console.log('Category:', updatedRecipe.categoryId);
        
    } catch (error) {
        console.error('❌ Error updating recipe:', error.message);
    } finally {
        mongoose.disconnect();
        console.log('Database connection closed');
    }
};

updateRecipeWithCuisine();
