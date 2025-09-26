// Script to fix duplicate + signs in country_code field
// Run this script once to clean up existing data

const mongoose = require('mongoose');
require('dotenv').config();

// Import user model
const userModel = require('../Recipe App Admin Panel Source Code/Script/model/userModel');

const fixCountryCodeDuplicates = async () => {
    try {
        console.log('🔧 Starting country code cleanup...');
        
        // Connect to MongoDB
        await mongoose.connect(process.env.MONGODB_URL || 'mongodb://localhost:27017/food-recipe');
        console.log('✅ Connected to MongoDB');
        
        // Find all users with country_code issues
        const users = await userModel.find({
            $or: [
                { country_code: { $regex: '^\\+\\+' } }, // Multiple + signs
                { country_code: { $regex: '^[0-9]' } }   // Missing + sign
            ]
        });
        
        console.log(`📊 Found ${users.length} users with country code issues`);
        
        let fixedCount = 0;
        
        for (const user of users) {
            let cleanCountryCode = user.country_code;
            
            if (cleanCountryCode) {
                // Remove multiple + signs and ensure only one at the beginning
                cleanCountryCode = cleanCountryCode.replace(/^\++/, '+').replace(/\++/g, '+');
                
                // Ensure it starts with +
                if (!cleanCountryCode.startsWith('+')) {
                    cleanCountryCode = '+' + cleanCountryCode;
                }
                
                // Update if changed
                if (cleanCountryCode !== user.country_code) {
                    await userModel.findByIdAndUpdate(user._id, {
                        country_code: cleanCountryCode
                    });
                    
                    console.log(`🔄 Fixed user ${user.email}: "${user.country_code}" → "${cleanCountryCode}"`);
                    fixedCount++;
                }
            }
        }
        
        console.log(`✅ Fixed ${fixedCount} country codes`);
        console.log('🎉 Country code cleanup completed!');
        
    } catch (error) {
        console.error('❌ Error during cleanup:', error.message);
    } finally {
        await mongoose.disconnect();
        console.log('🔌 Disconnected from MongoDB');
    }
};

// Run the script
if (require.main === module) {
    fixCountryCodeDuplicates();
}

module.exports = fixCountryCodeDuplicates;