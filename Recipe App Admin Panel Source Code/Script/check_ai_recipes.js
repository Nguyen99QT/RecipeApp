const mongoose = require('mongoose');
require('dotenv').config();

mongoose.connect(process.env.MONGO_URI || 'mongodb://localhost:27017/recipeapp', { useNewUrlParser: true, useUnifiedTopology: true });

const savedAiRecipeModel = require('./model/savedAiRecipeModel');

savedAiRecipeModel.find().populate('userId').then(recipes => {
    console.log('Found', recipes.length, 'AI recipes in database:');
    recipes.forEach((recipe, index) => {
        const recipeName = recipe.recipe?.name || 'No name';
        const userFirstName = recipe.userId?.firstname || 'Unknown';
        const userLastName = recipe.userId?.lastname || '';
        console.log(`${index + 1}. ${recipeName} - User: ${userFirstName} ${userLastName}`);
    });
    process.exit(0);
}).catch(err => {
    console.error('Error:', err.message);
    process.exit(1);
});
