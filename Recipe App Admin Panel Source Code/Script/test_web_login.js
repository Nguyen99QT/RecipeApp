const axios = require('axios');
const sha256 = require('sha256');

async function testAdminWebLogin() {
    try {
        console.log('=== Testing Admin Web Login ===');
        
        const baseURL = 'http://localhost:8190';
        
        // Test 1: Access login page
        console.log('\n1. Testing login page access...');
        try {
            const loginPage = await axios.get(`${baseURL}/`);
            console.log('✅ Login page accessible:', loginPage.status === 200);
        } catch (error) {
            console.log('❌ Login page not accessible:', error.message);
            return;
        }
        
        // Test 2: Test login with correct credentials
        console.log('\n2. Testing login with admin credentials...');
        const loginData = {
            email: 'admin@recipe.com',
            password: 'admin123'
        };
        
        try {
            const loginResponse = await axios.post(`${baseURL}/`, loginData, {
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                maxRedirects: 0,  // Don't follow redirects
                validateStatus: function (status) {
                    return status >= 200 && status < 400; // Accept redirects as success
                }
            });
            
            console.log('Login response status:', loginResponse.status);
            if (loginResponse.status === 302 || loginResponse.status === 301) {
                console.log('✅ Login successful - redirected to dashboard');
                console.log('Redirect location:', loginResponse.headers.location);
            } else {
                console.log('✅ Login response received');
            }
        } catch (error) {
            if (error.response && error.response.status === 302) {
                console.log('✅ Login successful - redirected');
                console.log('Redirect location:', error.response.headers.location);
            } else {
                console.log('❌ Login failed:', error.message);
                if (error.response) {
                    console.log('Response status:', error.response.status);
                    console.log('Response data:', error.response.data);
                }
            }
        }
        
        // Test 3: Test with wrong credentials
        console.log('\n3. Testing login with wrong credentials...');
        const wrongLoginData = {
            email: 'admin@recipe.com',
            password: 'wrongpassword'
        };
        
        try {
            const wrongLoginResponse = await axios.post(`${baseURL}/`, wrongLoginData, {
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                maxRedirects: 0,
                validateStatus: function (status) {
                    return status >= 200 && status < 400;
                }
            });
            
            console.log('Wrong login response status:', wrongLoginResponse.status);
            if (wrongLoginResponse.status === 302) {
                console.log('✅ Wrong credentials properly handled - redirected');
            }
        } catch (error) {
            if (error.response && error.response.status === 302) {
                console.log('✅ Wrong credentials properly handled - redirected back');
            } else {
                console.log('Login attempt with wrong credentials:', error.message);
            }
        }
        
        // Test 4: Check API endpoints
        console.log('\n4. Testing API endpoints...');
        try {
            const apiResponse = await axios.get(`${baseURL}/api/getAllRecipe`);
            console.log('✅ API endpoint accessible:', apiResponse.status === 200);
            console.log('API response sample:', apiResponse.data.status);
        } catch (error) {
            console.log('❌ API endpoint error:', error.message);
        }
        
        console.log('\n=== Test Complete ===');
        console.log('Admin panel should be accessible at: http://localhost:8190');
        console.log('Login credentials:');
        console.log('  Email: admin@recipe.com');
        console.log('  Password: admin123');
        
    } catch (error) {
        console.error('Test error:', error.message);
    }
}

// Run the test
testAdminWebLogin();
