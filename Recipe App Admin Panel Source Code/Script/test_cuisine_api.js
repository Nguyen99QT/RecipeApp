const http = require('http');

const postData = JSON.stringify({
  userId: '68a3130cc2e1811b5dbcfed8',
  recipeId: '68a17328e02661538f117091'  // Recipe từ app Flutter
});

const options = {
  hostname: 'localhost',
  port: 8190,
  path: '/api/GetRecipeById',
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YTMxMzBjYzJlMTgxMWI1ZGJjZmVkOCIsImlhdCI6MTc1NjgyNjEyOSwiZXhwIjoxNzU5NDE4MTI5fQ.k_6c8O0z1ZmSBQ0moZG4xwZllAOLQ5wDqYORMS5SGGE'
  }
};

const req = http.request(options, (res) => {
  console.log(`Status: ${res.statusCode}`);
  
  let data = '';
  res.on('data', (chunk) => {
    data += chunk;
  });
  
  res.on('end', () => {
    try {
      const result = JSON.parse(data);
      console.log('\n✅ API Response:');
      console.log(JSON.stringify(result, null, 2));
      
      if (result.data && result.data.cuisinesId) {
        console.log('\n🍽️ ✅ Cuisine Information Found:');
        console.log('cuisinesId:', result.data.cuisinesId);
        console.log('cuisine name:', result.data.cuisinesId.name);
      } else {
        console.log('\n❌ No cuisine information in response');
        console.log('Available fields:', Object.keys(result.data || {}));
      }
    } catch (error) {
      console.error('❌ Error parsing response:', error.message);
    }
  });
});

req.on('error', (error) => {
  console.error('❌ Request error:', error.message);
});

req.write(postData);
req.end();
