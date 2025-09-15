const sha256 = require("sha256");
const mongoose = require('mongoose');
const adminLoginModel = require('./model/adminLoginModel');

// Connect to MongoDB
mongoose.connect('mongodb://localhost:27017/food-recipe', {}).then(() => {
    console.log('Connected to MongoDB');
    debugLoginProcess();
}).catch(err => {
    console.error('MongoDB connection error:', err);
});

async function debugLoginProcess() {
    try {
        console.log('\n=== Debug Admin Login Process ===');
        
        // Test credentials
        const testEmail = 'admin@recipe.com';
        const testPassword = 'admin123';
        
        console.log('1. Test credentials:');
        console.log('   Email:', testEmail);
        console.log('   Password:', testPassword);
        
        // Hash password
        const hashedPassword = sha256.x2(testPassword);
        console.log('   Hashed password:', hashedPassword);
        
        // Find user in database
        console.log('\n2. Looking for user in database...');
        const adminUser = await adminLoginModel.findOne({ email: testEmail });
        
        if (!adminUser) {
            console.log('❌ Admin user not found in database');
            
            // List all users with their password hashes
            const allUsers = await adminLoginModel.find();
            console.log('Available users in database:', allUsers.length);
            allUsers.forEach((user, index) => {
                console.log(`   ${index + 1}. Email: ${user.email}, Name: ${user.name}`);
                console.log(`      Password hash: ${user.password}`);
                
                // Test if admin123 works with this user
                const testHash = sha256.x2('admin123');
                const testHashSingle = sha256('admin123');
                console.log(`      admin123 double hash match: ${testHash === user.password}`);
                console.log(`      admin123 single hash match: ${testHashSingle === user.password}`);
                
                // Test common passwords
                const commonPasswords = ['admin', 'password', '123456', 'admin@123', 'demo', 'demoadmin', 'root', 'test', '12345'];
                commonPasswords.forEach(pass => {
                    const hashDouble = sha256.x2(pass);
                    const hashSingle = sha256(pass);
                    if (hashDouble === user.password) {
                        console.log(`      ✅ Password found: "${pass}" (double hash)`);
                    }
                    if (hashSingle === user.password) {
                        console.log(`      ✅ Password found: "${pass}" (single hash)`);
                    }
                });
                console.log('');
            });
            
        } else {
            console.log('✅ Admin user found');
            console.log('   User ID:', adminUser._id);
            console.log('   Name:', adminUser.name);
            console.log('   Email:', adminUser.email);
            console.log('   Stored password hash:', adminUser.password);
            
            // Compare passwords
            console.log('\n3. Password comparison:');
            console.log('   Input hash:  ', hashedPassword);
            console.log('   Stored hash: ', adminUser.password);
            console.log('   Match:', hashedPassword === adminUser.password);
            
            if (hashedPassword === adminUser.password) {
                console.log('✅ Login should work!');
            } else {
                console.log('❌ Password mismatch - login will fail');
                
                // Test with different hash
                console.log('\n4. Testing different hash methods:');
                const singleHash = sha256(testPassword);
                console.log('   Single sha256:', singleHash);
                console.log('   Single match:', singleHash === adminUser.password);
            }
        }
        
        mongoose.connection.close();
        
    } catch (error) {
        console.error('Debug error:', error);
        mongoose.connection.close();
    }
}
