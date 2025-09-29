const mongoose = require('mongoose');
require('dotenv').config();

async function checkAIRecipes() {
  try {
    await mongoose.connect(process.env.DB_CONNECTION);
    console.log('✅ Connected to MongoDB');
    
    // Check savedairecipes collection
    const savedAiRecipeModel = require('./model/savedAiRecipeModel');
    const savedRecipes = await savedAiRecipeModel.find().sort({createdAt: -1}).limit(10);
    const savedCount = await savedAiRecipeModel.countDocuments();
    
    console.log('\n📊 SAVED AI RECIPES:');
    console.log('Count:', savedCount);
    
    if (savedRecipes.length > 0) {
      console.log('Recent saved recipes:');
      savedRecipes.forEach((recipe, index) => {
        console.log(`${index + 1}. "${recipe.title}" - User: ${recipe.userId} - Email: ${recipe.userEmail} - Created: ${recipe.createdAt}`);
      });
    } else {
      console.log('❌ No saved AI recipes found');
    }
    
    // Check airecipes collection
    const aiRecipeModel = require('./model/aiRecipeModel');
    const aiRecipes = await aiRecipeModel.find().sort({createdAt: -1}).limit(10);
    const aiCount = await aiRecipeModel.countDocuments();
    
    console.log('\n📊 AI RECIPES:');
    console.log('Count:', aiCount);
    
    if (aiRecipes.length > 0) {
      console.log('Recent AI recipes:');
      aiRecipes.forEach((recipe, index) => {
        console.log(`${index + 1}. "${recipe.title}" - User: ${recipe.userId} - Created: ${recipe.createdAt}`);
      });
    } else {
      console.log('❌ No AI recipes found');
    }
    
    // Check for specific user ID from Flutter app
    console.log('\n🔍 CHECKING FOR FLUTTER USER: 68a3130cc2e1811b5dbcfed8');
    const userSavedRecipes = await savedAiRecipeModel.find({userId: '68a3130cc2e1811b5dbcfed8'});
    console.log(`Found ${userSavedRecipes.length} saved recipes for this user`);
    
    if (userSavedRecipes.length > 0) {
      userSavedRecipes.forEach((recipe, index) => {
        console.log(`${index + 1}. "${recipe.title}" - Created: ${recipe.createdAt}`);
      });
    }
    
    mongoose.disconnect();
    console.log('\n✅ Database check completed');
    
  } catch (error) {
    console.error('❌ Error:', error);
    mongoose.disconnect();
  }
}

checkAIRecipes();
