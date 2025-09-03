const mongoose = require('mongoose');
const cuisinesModel = require('./model/cuisinesModel');

const connectDB = async () => {
    try {
        await mongoose.connect('mongodb://localhost:27017/food-recipe');
        console.log('✅ MongoDB connected successfully');
    } catch (error) {
        console.error('❌ MongoDB connection error:', error.message);
        process.exit(1);
    }
};

const listCuisines = async () => {
    await connectDB();
    
    try {
        const cuisines = await cuisinesModel.find({}).limit(10);
        console.log('🍽️ Available Cuisines:');
        cuisines.forEach(cuisine => {
            console.log(`- ${cuisine._id}: ${cuisine.name}`);
        });
        
    } catch (error) {
        console.error('❌ Error fetching cuisines:', error.message);
    } finally {
        mongoose.disconnect();
    }
};

listCuisines();
