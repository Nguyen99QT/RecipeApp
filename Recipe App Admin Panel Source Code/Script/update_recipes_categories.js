const mongoose = require('mongoose');
const recipeModel = require('./model/recipeModel');
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

// Update all recipes with categories
const updateRecipesWithCategories = async () => {
    await connectDB();
    
    try {
        // Get all categories
        const categories = await categoryModel.find({});
        console.log('\n📋 Available categories:');
        categories.forEach(cat => console.log(`   - ${cat.name} (${cat._id})`));
        
        // Recipe-category mapping
        const recipeMapping = {
            'Leftover Rice Pancakes Recipe': 'Main-course',
            'Hamburgers and Fries Recipe': 'Main-course', 
            'Chilli Paneer Frankie Recipe': 'Snack',
            'Eggless Banana Pancake Recipe': 'Breakfast',
            'Honey Chilli Potato Recipe': 'Snack',
            'Oats Porridge': 'Breakfast'
        };
        
        console.log('\n🔄 Updating recipes with categories...');
        console.log('========================================');
        
        let updated = 0;
        let failed = 0;
        
        for (const [recipeName, categoryName] of Object.entries(recipeMapping)) {
            try {
                // Find recipe
                const recipe = await recipeModel.findOne({ name: recipeName });
                if (!recipe) {
                    console.log(`❌ Recipe not found: ${recipeName}`);
                    failed++;
                    continue;
                }
                
                // Find category
                const category = await categoryModel.findOne({ name: categoryName });
                if (!category) {
                    console.log(`❌ Category not found: ${categoryName}`);
                    failed++;
                    continue;
                }
                
                // Update recipe
                await recipeModel.findByIdAndUpdate(
                    recipe._id,
                    { categoryId: category._id },
                    { new: true }
                );
                
                console.log(`✅ Updated "${recipeName}"`);
                console.log(`   ➜ Category: ${categoryName} (${category._id})`);
                updated++;
                
            } catch (error) {
                console.log(`❌ Error updating ${recipeName}:`, error.message);
                failed++;
            }
        }
        
        console.log('\n📊 Update Summary:');
        console.log(`✅ Successfully updated: ${updated} recipes`);
        console.log(`❌ Failed updates: ${failed} recipes`);
        
        // Verify results
        console.log('\n🔍 Verifying updates...');
        console.log('========================================');
        
        const allRecipes = await recipeModel.find({}).populate('categoryId').populate('cuisinesId');
        let withCategory = 0;
        let withoutCategory = 0;
        
        allRecipes.forEach((recipe, index) => {
            console.log(`${index + 1}. ${recipe.name}`);
            console.log(`   Recipe ID: ${recipe._id}`);
            console.log(`   Category: ${recipe.categoryId ? `✅ CÓ ${recipe.categoryId.name}` : '❌ KHÔNG N/A'}`);
            console.log(`   Cuisine: ${recipe.cuisinesId ? `✅ CÓ ${recipe.cuisinesId.name}` : '❌ KHÔNG N/A'}`);
            console.log('');
            
            if (recipe.categoryId) withCategory++;
            else withoutCategory++;
        });
        
        console.log('📊 Final Statistics:');
        console.log(`✅ Recipes with category data: ${withCategory}`);
        console.log(`❌ Recipes without category data: ${withoutCategory}`);
        console.log(`📋 Total recipes checked: ${allRecipes.length}`);
        
    } catch (error) {
        console.error('❌ Error:', error.message);
    } finally {
        mongoose.connection.close();
        console.log('\n🔌 Database connection closed');
    }
};

updateRecipesWithCategories();
