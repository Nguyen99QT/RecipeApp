const mongoose = require('mongoose');
const recipeModel = require('./model/recipeModel');
const cuisinesModel = require('./model/cuisinesModel');

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

// Update specific recipe
const updateSpecificRecipe = async () => {
    await connectDB();
    
    try {
        const recipeId = '68c19a6d95f5c7c50616af9c';
        console.log(`🔍 Looking for recipe: ${recipeId}`);
        
        // Find the recipe
        const recipe = await recipeModel.findById(recipeId);
        if (!recipe) {
            console.log('❌ Recipe not found');
            return;
        }
        
        console.log(`✅ Found recipe: ${recipe.name}`);
        
        // Find Indian cuisine
        const indianCuisine = await cuisinesModel.findOne({ name: 'Indian' });
        if (!indianCuisine) {
            console.log('❌ Indian cuisine not found');
            return;
        }
        
        console.log(`✅ Found Indian cuisine: ${indianCuisine._id}`);
        
        // Update recipe
        const updatedRecipe = await recipeModel.findByIdAndUpdate(
            recipeId,
            { cuisinesId: indianCuisine._id },
            { new: true }
        );
        
        if (updatedRecipe) {
            console.log('✅ Recipe updated successfully!');
            console.log(`   Recipe: ${updatedRecipe.name}`);
            console.log(`   Cuisine: ${indianCuisine.name} (${indianCuisine._id})`);
        }
        
    } catch (error) {
        console.error('❌ Error updating recipe:', error.message);
    } finally {
        mongoose.connection.close();
        console.log('🔌 Database connection closed');
    }
};

updateSpecificRecipe();