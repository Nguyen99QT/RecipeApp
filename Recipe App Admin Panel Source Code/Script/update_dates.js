const mongoose = require('mongoose');
const categoryModel = require('./model/categoryModel');
const cuisinesModel = require('./model/cuisinesModel');

// Database connection
mongoose.connect('mongodb://localhost:27017/food-recipe');

const db = mongoose.connection;

db.on('error', (error) => {
    console.error('Database connection error:', error);
});

db.once('open', async () => {
    console.log('Connected to MongoDB successfully');
    
    try {
        // Set target date: 17/8/2025
        const targetDate = new Date('2025-08-17T00:00:00.000Z');
        console.log('Target date:', targetDate);
        
        // First, let's check current documents
        const totalCategories = await categoryModel.countDocuments({});
        const totalCuisines = await cuisinesModel.countDocuments({});
        console.log(`Total categories: ${totalCategories}`);
        console.log(`Total cuisines: ${totalCuisines}`);
        
        // Update all categories
        console.log('\n=== Updating Categories ===');
        await categoryModel.updateMany(
            {}, // Empty filter to match all documents
            {
                createdAt: targetDate,
                updatedAt: targetDate
            }
        );
        console.log('Categories update command executed');
        
        // Update all cuisines
        console.log('\n=== Updating Cuisines ===');
        await cuisinesModel.updateMany(
            {}, // Empty filter to match all documents
            {
                createdAt: targetDate,
                updatedAt: targetDate
            }
        );
        console.log('Cuisines update command executed');
        
        // Verify updates
        console.log('\n=== Verification ===');
        const updatedCategories = await categoryModel.find({}, 'name createdAt').limit(3);
        const updatedCuisines = await cuisinesModel.find({}, 'name createdAt').limit(3);
        
        console.log('Updated categories:');
        updatedCategories.forEach(cat => {
            console.log(`- ${cat.name}: ${cat.createdAt}`);
        });
        
        console.log('Updated cuisines:');
        updatedCuisines.forEach(cuisine => {
            console.log(`- ${cuisine.name}: ${cuisine.createdAt}`);
        });
        
        console.log('\n✅ Date update completed successfully!');
        
    } catch (error) {
        console.error('Error updating dates:', error);
    } finally {
        // Close database connection
        await mongoose.connection.close();
        console.log('Database connection closed');
    }
});
