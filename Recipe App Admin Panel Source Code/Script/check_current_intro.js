const mongoose = require('mongoose');
require('dotenv').config();

// Connect to MongoDB
mongoose.connect(process.env.MONGODB_URL || 'mongodb://localhost:27017/recipe_app');

// Import intro model
const introModel = require('./model/introModel');

async function checkData() {
  try {
    const intros = await introModel.find();
    console.log('Current intro count:', intros.length);
    intros.forEach((intro, i) => {
      console.log(`${i+1}. Title: ${intro.title}`);
      console.log(`   Image: ${intro.image.substring(0, 80)}...`);
      console.log(`   Created: ${intro.createdAt}`);
    });
    process.exit(0);
  } catch (error) {
    console.error('Error:', error);
    process.exit(1);
  }
}

checkData();
