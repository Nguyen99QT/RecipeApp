const mongoose = require('mongoose');
require('dotenv').config();

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URL || 'mongodb://localhost:27017/recipe_app');

const introModel = require('./model/introModel');

async function checkIntros() {
  try {
    const intros = await introModel.find().sort({ createdAt: 1 });
    console.log('=== INTRO DATA FROM MONGODB ===');
    
    intros.forEach((intro, index) => {
      console.log(`${index + 1}. ID: ${intro._id}`);
      console.log(`   Title: ${intro.title}`);
      console.log(`   Image: ${intro.image}`);
      console.log(`   Image starts with http: ${intro.image.startsWith('http')}`);
      console.log(`   Description: ${intro.description.substring(0, 50)}...`);
      console.log('   ---');
    });
    
    process.exit(0);
  } catch (error) {
    console.error('Error:', error);
    process.exit(1);
  }
}

checkIntros();
