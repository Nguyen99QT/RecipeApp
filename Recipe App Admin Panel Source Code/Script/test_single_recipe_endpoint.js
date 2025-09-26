const http = require('http');

// Test data matching Flutter app format
const testData = {
  title: 'Test AI Recipe from Node.js',
  description: 'This is a test recipe to verify the endpoint',
  instructions: ['Step 1: Test', 'Step 2: Verify', 'Step 3: Success'],
  ingredients: ['Test ingredient 1', 'Test ingredient 2'],
  userId: '68a3130cc2e1811b5dbcfed8',
  userEmail: 'test@flutter.com',
  preparationTime: '30',
  cookingTime: '45',
  cuisine: 'Test Cuisine',
  tags: ['test', 'demo'],
  difficulty: 'Easy',
  servings: '4',
  estimatedCalories: '300',
  imageUrl: '',
  createdAt: new Date().toISOString()
};

const postData = JSON.stringify(testData);

const options = {
  hostname: 'localhost',
  port: 3000,
  path: '/api/saved-ai-recipes',
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Content-Length': Buffer.byteLength(postData)
  }
};

console.log('🧪 Testing /api/saved-ai-recipes endpoint...');
console.log('📤 Sending data:', JSON.stringify(testData, null, 2));

const req = http.request(options, (res) => {
  console.log(`\n📊 Status Code: ${res.statusCode}`);
  console.log('📋 Headers:', res.headers);
  
  let body = '';
  res.on('data', (chunk) => {
    body += chunk;
  });
  
  res.on('end', () => {
    console.log('\n📥 Response Body:');
    try {
      const jsonResponse = JSON.parse(body);
      console.log(JSON.stringify(jsonResponse, null, 2));
    } catch (e) {
      console.log('Raw response:', body);
    }
  });
});

req.on('error', (e) => {
  console.error(`❌ Problem with request: ${e.message}`);
});

req.write(postData);
req.end();