const axios = require('axios');
const qs = require('querystring');

async function testAdminLoginManual() {
    try {
        console.log('=== Testing Admin Login Manual ===');
        
        const baseURL = 'http://localhost:8190';
        
        // Test với credentials đã fix
        const loginData = {
            email: 'admin@recipe.com',
            password: 'admin123'
        };
        
        console.log('Testing login with:');
        console.log('Email:', loginData.email);
        console.log('Password:', loginData.password);
        
        // Use axios with proper form data
        const response = await axios({
            method: 'POST',
            url: baseURL + '/',
            data: qs.stringify(loginData),
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            maxRedirects: 0,
            validateStatus: function (status) {
                return status >= 200 && status < 400;
            }
        });
        
        console.log('Response status:', response.status);
        console.log('Response headers location:', response.headers.location);
        
        if (response.status === 302) {
            if (response.headers.location === '/dashboard') {
                console.log('✅ Login successful - redirected to dashboard');
            } else if (response.headers.location === '/') {
                console.log('❌ Login failed - redirected back to login');
            } else {
                console.log('? Unexpected redirect:', response.headers.location);
            }
        }
        
    } catch (error) {
        if (error.response) {
            console.log('Response status:', error.response.status);
            console.log('Response headers location:', error.response.headers.location);
            
            if (error.response.status === 302) {
                if (error.response.headers.location === '/dashboard') {
                    console.log('✅ Login successful - redirected to dashboard');
                } else if (error.response.headers.location === '/') {
                    console.log('❌ Login failed - redirected back to login');
                } else {
                    console.log('? Unexpected redirect:', error.response.headers.location);
                }
            }
        } else {
            console.log('Error:', error.message);
        }
    }
}

testAdminLoginManual();
