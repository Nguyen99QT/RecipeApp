const { MongoClient } = require('mongodb');

async function testDeleteProtection() {
    const uri = 'mongodb://localhost:27017';
    const client = new MongoClient(uri);

    try {
        await client.connect();
        console.log('Connected to MongoDB');

        const db = client.db('food-recipe');
        
        console.log('\n🛡️ DELETE PROTECTION TEST RESULTS:\n');
        
        // Check categories
        console.log('📁 CATEGORIES:');
        const categories = await db.collection('categories').find({}).toArray();
        
        for (const category of categories) {
            const recipeCount = await db.collection('recipes').countDocuments({ 
                categoryId: category._id 
            });
            
            const canDelete = recipeCount === 0;
            const status = canDelete ? '✅ CAN DELETE' : '🚫 PROTECTED';
            const reason = canDelete ? 'No recipes' : `${recipeCount} recipe(s)`;
            
            console.log(`   ${status} | ${category.name} (${reason})`);
        }
        
        console.log('\n🌍 CUISINES:');
        const cuisines = await db.collection('cuisines').find({}).toArray();
        
        for (const cuisine of cuisines) {
            const recipeCount = await db.collection('recipes').countDocuments({ 
                cuisinesId: cuisine._id 
            });
            
            const canDelete = recipeCount === 0;
            const status = canDelete ? '✅ CAN DELETE' : '🚫 PROTECTED';
            const reason = canDelete ? 'No recipes' : `${recipeCount} recipe(s)`;
            
            console.log(`   ${status} | ${cuisine.name} (${reason})`);
        }
        
        console.log('\n📊 SUMMARY:');
        const totalRecipes = await db.collection('recipes').countDocuments({});
        const protectedCategories = categories.filter(async cat => {
            const count = await db.collection('recipes').countDocuments({ categoryId: cat._id });
            return count > 0;
        }).length;
        
        console.log(`   Total categories: ${categories.length}`);
        console.log(`   Total cuisines: ${cuisines.length}`);
        console.log(`   Total recipes: ${totalRecipes}`);
        console.log(`   Protected items: Categories/Cuisines with recipes`);

    } catch (error) {
        console.error('Error:', error);
    } finally {
        await client.close();
        console.log('\nDatabase connection closed');
    }
}

testDeleteProtection();
