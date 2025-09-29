const mongoose = require('mongoose');
require('dotenv').config();

async function checkRecipeStructure() {
    try {
        await mongoose.connect(process.env.DB_CONNECTION);
        console.log('Connected to database');
        
        const savedAiRecipesCollection = mongoose.connection.db.collection('savedairecipes');
        const sample = await savedAiRecipesCollection.findOne();
        
        console.log('Sample savedairecipe document structure:');
        console.log(JSON.stringify(sample, null, 2));
        
        process.exit(0);
    } catch (err) {
        console.error('Error:', err.message);
        process.exit(1);
    }
}

checkRecipeStructure();
