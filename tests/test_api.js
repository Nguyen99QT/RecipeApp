const axios = require('axios');

async function testAPI() {
    try {
        console.log('=== Testing Admin Panel APIs ===');
        
        // Test 1: Check if server is running
        console.log('\n1. Testing server health...');
        const healthResponse = await axios.post('http://localhost:8190/api/getAllIntro', {});
        console.log('✓ Server is running');
        console.log('Response status:', healthResponse.status);
        console.log('Response data:', JSON.stringify(healthResponse.data, null, 2));
        
        // Test 2: Test login with known credentials
        console.log('\n2. Testing login...');
        const loginData = {
            email: 'admin@recipeapp.com',
            password: 'admin123'
        };
        
        try {
            const loginResponse = await axios.post('http://localhost:8190/api/SignIn', loginData);
            console.log('✓ Login successful');
            console.log('Login response:', JSON.stringify(loginResponse.data, null, 2));
            
            const token = loginResponse.data.token;
            
            // Test 3: Test protected API with token
            console.log('\n3. Testing protected API with token...');
            const userResponse = await axios.post('http://localhost:8190/api/GetUser', {}, {
                headers: {
                    'Authorization': `Bearer ${token}`,
                    'Content-Type': 'application/json'
                }
            });
            console.log('✓ Protected API working');
            console.log('User data:', JSON.stringify(userResponse.data, null, 2));
            
        } catch (loginError) {
            console.log('✗ Login failed');
            console.log('Login error:', loginError.response?.data || loginError.message);
        }
        
    } catch (error) {
        console.log('✗ Server not responding');
        console.log('Error:', error.message);
    }
}

testAPI();
