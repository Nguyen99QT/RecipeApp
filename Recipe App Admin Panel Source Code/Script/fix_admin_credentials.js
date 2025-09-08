const sha256 = require("sha256");
const mongoose = require('mongoose');
const adminLoginModel = require('./model/adminLoginModel');

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/food-recipe', {}).then(() => {
    console.log('Connected to MongoDB');
    fixAdminCredentials();
}).catch(err => {
    console.error('MongoDB connection error:', err);
});

async function fixAdminCredentials() {
    try {
        console.log('\n=== Fixing Admin Credentials ===');
        
        // Check existing admins
        const existingAdmins = await adminLoginModel.find();
        console.log('Existing admins:', existingAdmins.length);
        
        if (existingAdmins.length > 0) {
            // Update the first admin with known credentials
            const firstAdmin = existingAdmins[0];
            const newPassword = sha256.x2('admin123');
            
            console.log(`Updating admin: ${firstAdmin.email}`);
            console.log(`New password hash: ${newPassword}`);
            
            await adminLoginModel.findByIdAndUpdate(firstAdmin._id, {
                email: 'admin@recipe.com',
                password: newPassword
            });
            
            console.log('✅ Admin credentials updated!');
            console.log('Login details:');
            console.log('  Email: admin@recipe.com');
            console.log('  Password: admin123');
            
        } else {
            // Create new admin
            console.log('Creating new admin...');
            const newAdmin = new adminLoginModel({
                name: 'Admin',
                email: 'admin@recipe.com',
                password: sha256.x2('admin123'),
                contact: '1234567890',
                avatar: 'default_avatar.jpg',
                is_admin: 1
            });
            
            await newAdmin.save();
            console.log('✅ New admin created!');
        }
        
        // Verify the fix
        console.log('\n=== Verification ===');
        const testEmail = 'admin@recipe.com';
        const testPassword = 'admin123';
        const hashedPassword = sha256.x2(testPassword);
        
        const adminUser = await adminLoginModel.findOne({ email: testEmail });
        if (adminUser && adminUser.password === hashedPassword) {
            console.log('✅ Admin login should work now!');
            console.log('✅ Email:', testEmail);
            console.log('✅ Password:', testPassword);
        } else {
            console.log('❌ Still not working');
        }
        
        mongoose.connection.close();
        
    } catch (error) {
        console.error('Fix error:', error);
        mongoose.connection.close();
    }
}
