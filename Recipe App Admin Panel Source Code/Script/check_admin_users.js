// Check admin users
require('dotenv').config();
const mongoose = require('mongoose');

async function checkAdminUsers() {
    try {
        await mongoose.connect('mongodb://127.0.0.1:27017/food-recipe');
        console.log('✅ Connected to MongoDB');
        
        const Admin = mongoose.model('Admin', new mongoose.Schema({}, { collection: 'admins' }));
        const admins = await Admin.find({}, { name: 1, email: 1, password: 1 }).limit(5);
        
        console.log('👥 Admin users:');
        admins.forEach((admin, i) => {
            console.log(`   ${i+1}. ${admin.name} - ${admin.email}`);
        });
        
        if (admins.length === 0) {
            console.log('❌ No admin users found!');
            console.log('🔧 Run: node debug_admin_login.js to create admin user');
        }
        
    } catch (error) {
        console.error('❌ Error:', error.message);
    }
    
    process.exit(0);
}

checkAdminUsers();
