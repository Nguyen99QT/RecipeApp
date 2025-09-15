console.log('=== Manual Admin Login Test ===');
console.log('');
console.log('1. Open browser and go to: http://localhost:8190');
console.log('2. You should see the login page');
console.log('3. Use these credentials:');
console.log('   Email: admin@recipe.com');
console.log('   Password: admin123');
console.log('4. Click login');
console.log('5. You should be redirected to dashboard');
console.log('');
console.log('If login fails, check:');
console.log('- Server is running on port 8190');
console.log('- MongoDB is running');
console.log('- Admin account exists in database');
console.log('');
console.log('Server status: Check if server is running...');

// Test if server is running
const http = require('http');

const req = http.request('http://localhost:8190', (res) => {
    console.log('✅ Server is running on port 8190');
    console.log('✅ Login page should be accessible');
}).on('error', (err) => {
    console.log('❌ Server is not running:', err.message);
});

req.end();
