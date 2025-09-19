const mongoose = require('mongoose');
require('dotenv').config();

async function checkDatabase() {
    try {
        await mongoose.connect(process.env.DB_CONNECTION || 'mongodb://localhost:27017/food-recipe');
        console.log('Connected to database');
        
        // List all collections
        const collections = await mongoose.connection.db.listCollections().toArray();
        console.log('Available collections:');
        collections.forEach(collection => {
            console.log('-', collection.name);
        });
        
        // Check if savedairecipes collection exists and has data
        const savedAiRecipesCollection = mongoose.connection.db.collection('savedairecipes');
        const count = await savedAiRecipesCollection.countDocuments();
        console.log('\nsavedairecipes collection count:', count);
        
        if (count > 0) {
            const samples = await savedAiRecipesCollection.find().limit(2).toArray();
            console.log('Sample documents:');
            samples.forEach((doc, index) => {
                console.log(`${index + 1}.`, doc.recipe?.name || 'No name', 'by user:', doc.userId);
            });
        }
        
        process.exit(0);
    } catch (err) {
        console.error('Database connection error:', err.message);
        process.exit(1);
    }
}

checkDatabase();