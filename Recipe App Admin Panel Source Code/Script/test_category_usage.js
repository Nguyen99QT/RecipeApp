const { MongoClient } = require('mongodb');

async function testCategoryDeletion() {
    const uri = 'mongodb://localhost:27017';
    const client = new MongoClient(uri);

    try {
        await client.connect();
        console.log('Connected to MongoDB');

        const db = client.db('food-recipe');
        
        // Check categories and their recipe counts
        console.log('\n=== Category Usage Analysis ===');
        
        const categories = await db.collection('categories').find({}).toArray();
        
        for (const category of categories) {
            const recipeCount = await db.collection('recipes').countDocuments({ 
                categoryId: category._id 
            });
            
            console.log(`📁 ${category.name} (ID: ${category._id})`);
            console.log(`   └── ${recipeCount} recipe(s)`);
            
            if (recipeCount > 0) {
                // Sample some recipes
                const sampleRecipes = await db.collection('recipes')
                    .find({ categoryId: category._id }, { projection: { name: 1 } })
                    .limit(3)
                    .toArray();
                
                sampleRecipes.forEach((recipe, index) => {
                    console.log(`       ${index + 1}. ${recipe.name}`);
                });
                
                if (recipeCount > 3) {
                    console.log(`       ... and ${recipeCount - 3} more`);
                }
            }
            console.log('');
        }
        
        console.log('📊 Summary:');
        console.log(`Total categories: ${categories.length}`);
        const totalRecipes = await db.collection('recipes').countDocuments({});
        console.log(`Total recipes: ${totalRecipes}`);

    } catch (error) {
        console.error('Error:', error);
    } finally {
        await client.close();
        console.log('\nDatabase connection closed');
    }
}

testCategoryDeletion();
