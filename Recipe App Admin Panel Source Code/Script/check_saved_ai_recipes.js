// Script to check saved AI recipes data
require('dotenv').config();
require('./config/conn');
const savedAiRecipeModel = require('./model/savedAiRecipeModel');

async function checkSavedAiRecipes() {
    try {
        console.log('🔍 Checking saved AI recipes data...');
        console.log('');
        
        // Count total recipes
        const totalCount = await savedAiRecipeModel.countDocuments();
        console.log(`📊 Total saved AI recipes: ${totalCount}`);
        
        if (totalCount === 0) {
            console.log('❌ No saved AI recipes found in database!');
            console.log('');
            console.log('🔧 Solutions:');
            console.log('   1. Run: node insert_saved_ai_recipes_test_data.js');
            console.log('   2. Or add recipes via Flutter app sync');
            process.exit(0);
        }
        
        // Count by status
        const activeCount = await savedAiRecipeModel.countDocuments({ status: 'active' });
        const inactiveCount = await savedAiRecipeModel.countDocuments({ status: 'inactive' });
        
        console.log(`   • Active recipes: ${activeCount}`);
        console.log(`   • Inactive recipes: ${inactiveCount}`);
        console.log('');
        
        // Get sample recipes
        console.log('📝 Sample recipes:');
        const sampleRecipes = await savedAiRecipeModel.find({ status: 'active' }).limit(3);
        
        sampleRecipes.forEach((recipe, index) => {
            console.log(`   ${index + 1}. ${recipe.title}`);
            console.log(`      • ID: ${recipe._id}`);
            console.log(`      • Cuisine: ${recipe.cuisine}`);
            console.log(`      • User: ${recipe.userEmail}`);
            console.log(`      • Saved At: ${recipe.savedAt}`);
            console.log('');
        });
        
        console.log('🌐 Admin Panel URLs:');
        console.log('   • Saved AI Recipes: http://localhost:3000/saved-ai-recipes');
        console.log('   • Login Page: http://localhost:3000/');
        console.log('');
        console.log('✅ Database check completed!');
        
    } catch (error) {
        console.error('💥 Error checking saved AI recipes:', error);
    }
    
    process.exit(0);
}

// Wait for DB connection then check
setTimeout(checkSavedAiRecipes, 2000);