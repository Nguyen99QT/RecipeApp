const mongoose = require('mongoose');
require('dotenv').config();

async function checkUserData() {
  try {
    await mongoose.connect(process.env.DB_CONNECTION);
    console.log('✅ Connected to MongoDB');
    
    // Check saved AI recipes with user data
    const savedAiRecipeModel = require('./model/savedAiRecipeModel');
    const userModel = require('./model/userModel');
    
    console.log('\n📊 CHECKING SAVED AI RECIPES WITH USER DATA:');
    
    // Get saved recipes with populated user data
    const recipesWithUsers = await savedAiRecipeModel.find()
      .populate('userId', 'firstname lastname email avatar')
      .sort({createdAt: -1})
      .limit(5);
    
    console.log(`Found ${recipesWithUsers.length} recipes with user data:`);
    
    recipesWithUsers.forEach((recipe, index) => {
      console.log(`\n${index + 1}. Recipe: "${recipe.title}"`);
      console.log(`   User ID (string): ${recipe.userId}`);
      console.log(`   User Email: ${recipe.userEmail}`);
      console.log(`   User Object:`, recipe.userId ? {
        firstname: recipe.userId.firstname,
        lastname: recipe.userId.lastname,
        email: recipe.userId.email,
        avatar: recipe.userId.avatar
      } : 'NULL');
    });
    
    // Check if user IDs from Flutter app exist in users collection
    console.log('\n🔍 CHECKING FLUTTER USER IN USERS COLLECTION:');
    const flutterUserId = '68a3130cc2e1811b5dbcfed8';
    
    // Check if this ID exists as ObjectId
    let userExists = false;
    try {
      const user = await userModel.findById(flutterUserId);
      if (user) {
        console.log(`✅ User found: ${user.firstname} ${user.lastname} (${user.email})`);
        console.log(`   Avatar: ${user.avatar || 'No avatar'}`);
        userExists = true;
      }
    } catch (e) {
      console.log('❌ User ID not valid ObjectId or not found');
    }
    
    if (!userExists) {
      // Check if userId exists as string in any user
      const userByString = await userModel.findOne({_id: flutterUserId}).catch(() => null);
      if (userByString) {
        console.log(`✅ User found by string ID: ${userByString.firstname} ${userByString.lastname}`);
      } else {
        console.log('❌ No user found with this ID');
        
        // Show some existing users for comparison
        console.log('\n📋 EXISTING USERS IN DATABASE:');
        const existingUsers = await userModel.find().limit(5);
        existingUsers.forEach((user, index) => {
          console.log(`${index + 1}. ID: ${user._id} - ${user.firstname} ${user.lastname} (${user.email})`);
        });
      }
    }
    
    mongoose.disconnect();
    console.log('\n✅ Check completed');
    
  } catch (error) {
    console.error('❌ Error:', error);
    mongoose.disconnect();
  }
}

checkUserData();
