const { MongoClient } = require('mongodb');

async function verifyDates() {
    const uri = 'mongodb://localhost:27017';
    const client = new MongoClient(uri);

    try {
        await client.connect();
        console.log('Connected to MongoDB');

        const db = client.db('food-recipe');
        
        const targetDate = new Date('2025-08-17T00:00:00.000Z');
        
        // Check all categories
        console.log('\n=== All Categories ===');
        const categories = await db.collection('categories').find({}, { projection: { name: 1, createdAt: 1 } }).toArray();
        categories.forEach((cat, index) => {
            const isCorrect = cat.createdAt.getTime() === targetDate.getTime();
            console.log(`${index + 1}. ${cat.name} - ${cat.createdAt.toISOString()} ${isCorrect ? '✅' : '❌'}`);
        });

        // Check all cuisines
        console.log('\n=== All Cuisines ===');
        const cuisines = await db.collection('cuisines').find({}, { projection: { name: 1, createdAt: 1 } }).toArray();
        cuisines.forEach((cuisine, index) => {
            const isCorrect = cuisine.createdAt.getTime() === targetDate.getTime();
            console.log(`${index + 1}. ${cuisine.name} - ${cuisine.createdAt.toISOString()} ${isCorrect ? '✅' : '❌'}`);
        });

        console.log('\n📊 Summary:');
        console.log(`Categories total: ${categories.length}`);
        console.log(`Cuisines total: ${cuisines.length}`);
        console.log(`Target date: ${targetDate.toISOString()}`);

    } catch (error) {
        console.error('Error:', error);
    } finally {
        await client.close();
        console.log('\nDatabase connection closed');
    }
}

verifyDates();
