const mongoose = require('mongoose');
require('dotenv').config();

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URL || 'mongodb://localhost:27017/recipe_app');

// Import intro model
const introModel = require('./model/introModel');

const sampleIntros = [
  {
    image: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400&h=300&fit=crop',
    title: 'Welcome to Recipe App',
    description: 'Discover thousands of delicious recipes from around the world. Cook amazing meals with step-by-step instructions.'
  },
  {
    image: 'https://images.unsplash.com/photo-1543353071-10c8c4e8f930?w=400&h=300&fit=crop',
    title: 'Cook with AI',
    description: 'Get personalized recipe suggestions powered by artificial intelligence. Upload your ingredients and get instant recipe ideas.'
  },
  {
    image: 'https://images.unsplash.com/photo-1556909114-2a5c4b3f18e0?w=400&h=300&fit=crop',
    title: 'Share Your Recipes',
    description: 'Upload and share your favorite recipes with the community. Help others discover amazing dishes from your kitchen.'
  }
];

async function seedIntroData() {
  try {
    // Clear existing intro data
    await introModel.deleteMany({});
    console.log('Cleared existing intro data');

    // Insert sample intro data
    const result = await introModel.insertMany(sampleIntros);
    console.log(`Inserted ${result.length} intro items:`);
    
    result.forEach((intro, index) => {
      console.log(`${index + 1}. ${intro.title}`);
      console.log(`   Image: ${intro.image}`);
      console.log(`   Description: ${intro.description.substring(0, 50)}...`);
      console.log('   ---');
    });

    process.exit(0);
  } catch (error) {
    console.error('Error seeding intro data:', error);
    process.exit(1);
  }
}

seedIntroData();
