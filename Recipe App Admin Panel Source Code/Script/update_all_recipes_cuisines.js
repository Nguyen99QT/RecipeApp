const mongoose = require('mongoose');
const Recipe = require('./model/recipeModel');
const Cuisine = require('./model/cuisinesModel');

// Database connection
const mongoURI = 'mongodb://localhost:27017/food-recipe';

async function updateRecipesCuisines() {
    try {
        // Connect to MongoDB
        await mongoose.connect(mongoURI);
        console.log('✅ MongoDB connected successfully');

        // Get all available cuisines first
        const cuisines = await Cuisine.find({}, '_id name');
        const cuisineMap = {};
        cuisines.forEach(cuisine => {
            cuisineMap[cuisine.name.toLowerCase()] = cuisine._id;
        });

        console.log('🌍 Available cuisines:', Object.keys(cuisineMap));

        // Define cuisine assignments based on recipe names and characteristics
        const recipeUpdates = [
            {
                name: 'Leftover Rice Pancakes Recipe',
                suggestedCuisine: 'Indian', // Rice pancakes are common in Indian cuisine
                reason: 'Rice pancakes are traditional Indian dish'
            },
            {
                name: 'Hamburgers and Fries Recipe', 
                suggestedCuisine: 'American', // Classic American fast food
                reason: 'Hamburgers and fries are classic American food'
            },
            {
                name: 'Chilli Paneer Frankie Recipe',
                suggestedCuisine: 'Indian', // Paneer and frankie are Indian
                reason: 'Paneer and frankie are Indian dishes'
            },
            {
                name: 'Eggless Banana Pancake Recipe',
                suggestedCuisine: 'American', // Pancakes are typically American/Continental
                reason: 'Pancakes are popular in American cuisine'
            },
            {
                name: 'Oats Porridge',
                suggestedCuisine: 'Continental', // Oats porridge is continental
                reason: 'Oats porridge is common in Continental cuisine'
            }
        ];

        console.log('\n🔄 Updating recipes with cuisine information...');
        console.log('================================================================================');

        let successCount = 0;
        let errorCount = 0;

        for (const update of recipeUpdates) {
            try {
                // Find the cuisine ID
                const cuisineId = cuisineMap[update.suggestedCuisine.toLowerCase()];
                
                if (!cuisineId) {
                    console.log(`❌ Cuisine "${update.suggestedCuisine}" not found for ${update.name}`);
                    errorCount++;
                    continue;
                }

                // Update the recipe
                const result = await Recipe.findOneAndUpdate(
                    { name: update.name },
                    { cuisinesId: cuisineId },
                    { new: true }
                );

                if (result) {
                    console.log(`✅ Updated "${update.name}"`);
                    console.log(`   ➜ Cuisine: ${update.suggestedCuisine} (${cuisineId})`);
                    console.log(`   ➜ Reason: ${update.reason}`);
                    successCount++;
                } else {
                    console.log(`❌ Recipe "${update.name}" not found`);
                    errorCount++;
                }
            } catch (err) {
                console.log(`❌ Error updating "${update.name}":`, err.message);
                errorCount++;
            }
            console.log('');
        }

        console.log('📊 Update Summary:');
        console.log(`✅ Successfully updated: ${successCount} recipes`);
        console.log(`❌ Failed updates: ${errorCount} recipes`);

        // Verify the updates by checking all recipes again
        console.log('\n🔍 Verifying updates...');
        console.log('================================================================================');
        
        const allRecipes = await Recipe.find({})
            .populate('cuisinesId', 'name')
            .populate('categoryId', 'name')
            .limit(10);

        allRecipes.forEach((recipe, index) => {
            const cuisineName = recipe.cuisinesId ? recipe.cuisinesId.name : 'N/A';
            const categoryName = recipe.categoryId ? recipe.categoryId.name : 'N/A';
            const hasData = recipe.cuisinesId ? '✅ CÓ' : '❌ KHÔNG';
            
            console.log(`${index + 1}. ${recipe.name}`);
            console.log(`   Recipe ID: ${recipe._id}`);
            console.log(`   Category: ${categoryName}`);
            console.log(`   Cuisine: ${hasData} ${cuisineName}`);
            console.log('');
        });

        const recipesWithCuisine = allRecipes.filter(recipe => recipe.cuisinesId);
        const recipesWithoutCuisine = allRecipes.filter(recipe => !recipe.cuisinesId);

        console.log('📊 Final Statistics:');
        console.log(`✅ Recipes with cuisine data: ${recipesWithCuisine.length}`);
        console.log(`❌ Recipes without cuisine data: ${recipesWithoutCuisine.length}`);
        console.log(`📋 Total recipes checked: ${allRecipes.length}`);

    } catch (error) {
        console.error('❌ Error:', error);
    } finally {
        // Close the database connection
        await mongoose.connection.close();
        console.log('\n🔌 Database connection closed');
    }
}

// Run the update function
updateRecipesCuisines();
