const { MongoClient } = require('mongodb');

async function updateDates() {
    const uri = 'mongodb://localhost:27017';
    const client = new MongoClient(uri);

    try {
        await client.connect();
        console.log('Connected to MongoDB');

        const db = client.db('food-recipe');
        
        // Set target date: 17/8/2025
        const targetDate = new Date('2025-08-17T00:00:00.000Z');
        console.log('Target date:', targetDate);

        // Update categories collection
        console.log('\n=== Updating Categories ===');
        const categoryResult = await db.collection('categories').updateMany(
            {},
            {
                $set: {
                    createdAt: targetDate,
                    updatedAt: targetDate
                }
            }
        );
        console.log(`Categories updated: ${categoryResult.modifiedCount} documents`);

        // Update cuisines collection
        console.log('\n=== Updating Cuisines ===');
        const cuisineResult = await db.collection('cuisines').updateMany(
            {},
            {
                $set: {
                    createdAt: targetDate,
                    updatedAt: targetDate
                }
            }
        );
        console.log(`Cuisines updated: ${cuisineResult.modifiedCount} documents`);

        // Verify updates
        console.log('\n=== Verification ===');
        const sampleCategory = await db.collection('categories').findOne({});
        const sampleCuisine = await db.collection('cuisines').findOne({});

        if (sampleCategory) {
            console.log('Sample category:', sampleCategory.name, '- Date:', sampleCategory.createdAt);
        }
        if (sampleCuisine) {
            console.log('Sample cuisine:', sampleCuisine.name, '- Date:', sampleCuisine.createdAt);
        }

        console.log('\n✅ Date update completed successfully!');

    } catch (error) {
        console.error('Error:', error);
    } finally {
        await client.close();
        console.log('Database connection closed');
    }
}

updateDates();
