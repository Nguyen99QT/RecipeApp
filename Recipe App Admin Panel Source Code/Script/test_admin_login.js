const sha256 = require("sha256");
const mongoose = require('mongoose');
const adminLoginModel = require('./model/adminLoginModel');

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/recipe_db', {
    useNewUrlParser: true,
    useUnifiedTopology: true
}).then(() => {
    console.log('Connected to MongoDB');
    testAdminLogin();
}).catch(err => {
    console.error('MongoDB connection error:', err);
});

async function testAdminLogin() {
    try {
        console.log('\n=== Testing Admin Login ===');
        
        // Check existing admin accounts
        const admins = await adminLoginModel.find();
        console.log('Existing admin accounts:', admins.length);
        
        if (admins.length > 0) {
            console.log('Admin accounts found:');
            admins.forEach((admin, index) => {
                console.log(`${index + 1}. Email: ${admin.email}, Name: ${admin.name}`);
            });
        } else {
            console.log('No admin accounts found. Creating default admin...');
            
            // Create default admin account
            const defaultAdmin = new adminLoginModel({
                name: 'Admin',
                email: 'admin@recipe.com',
                password: sha256.x2('admin123'), // Hash password using sha256.x2
                contact: '1234567890',
                avatar: 'default_avatar.jpg',
                is_admin: 1
            });
            
            await defaultAdmin.save();
            console.log('Default admin created successfully!');
            console.log('Email: admin@recipe.com');
            console.log('Password: admin123');
        }
        
        // Test login with existing credentials
        console.log('\n=== Testing Login Process ===');
        const testEmail = 'admin@recipe.com';
        const testPassword = 'admin123';
        const hashedPassword = sha256.x2(testPassword);
        
        console.log(`Testing login with email: ${testEmail}`);
        console.log(`Original password: ${testPassword}`);
        console.log(`Hashed password: ${hashedPassword}`);
        
        const adminUser = await adminLoginModel.findOne({ email: testEmail });
        if (adminUser) {
            console.log('Admin user found in database');
            console.log(`Stored password hash: ${adminUser.password}`);
            console.log(`Password match: ${hashedPassword === adminUser.password}`);
            
            if (hashedPassword === adminUser.password) {
                console.log('✅ Login test successful!');
            } else {
                console.log('❌ Password mismatch!');
            }
        } else {
            console.log('❌ Admin user not found');
        }
        
        mongoose.connection.close();
        
    } catch (error) {
        console.error('Error:', error);
        mongoose.connection.close();
    }
}
