const http = require('http');

// Test data với format chính xác như Flutter app
const flutterTestData = {
  "title": "Clay Pot Braised Fish with Garlic",
  "description": "A flavorful and aromatic fish dish braised in a clay pot with garlic and a rich sauce.",
  "instructions": [
    "Season the fish with salt and pepper",
    "Heat oil in clay pot",
    "Add garlic and aromatics",
    "Braise fish until tender"
  ],
  "ingredients": [
    "2 lbs whole fish",
    "8 cloves garlic",
    "2 tbsp soy sauce",
    "1 tbsp rice wine"
  ],
  "userId": "68a3130cc2e1811b5dbcfed8",
  "userEmail": "user@flutter.com",
  "preparationTime": "30", // String format như Flutter
  "cookingTime": "45",     // String format như Flutter
  "cuisine": "Vietnamese",
  "tags": ["fish", "claypot", "vietnamese"],
  "difficulty": "Medium",
  "servings": "4",         // String format như Flutter
  "estimatedCalories": "350", // String format như Flutter
  "imageUrl": "",          // Empty string như Flutter
  "createdAt": new Date().toISOString()
};

// Test với các edge cases có thể gây lỗi
const edgeCaseData = {
  "title": "",  // Empty title
  "description": "",  // Empty description
  "instructions": [],  // Empty array
  "ingredients": [],   // Empty array
  "userId": "",        // Empty userId
  "userEmail": "",     // Empty userEmail
  "preparationTime": "30",
  "cookingTime": "45",
  "cuisine": "Test",
  "tags": [],
  "difficulty": "Easy",
  "servings": "4",
  "estimatedCalories": "",
  "imageUrl": "",
  "createdAt": new Date().toISOString()
};

async function testEndpoint(data, testName) {
  return new Promise((resolve) => {
    const postData = JSON.stringify(data);
    
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
    
    console.log(`\n🧪 Testing: ${testName}`);
    
    const req = http.request(options, (res) => {
      let body = '';
      res.on('data', (chunk) => {
        body += chunk;
      });
      
      res.on('end', () => {
        console.log(`📊 Status: ${res.statusCode}`);
        try {
          const jsonResponse = JSON.parse(body);
          console.log(`📥 Response: ${JSON.stringify(jsonResponse, null, 2)}`);
        } catch (e) {
          console.log('📥 Raw response:', body);
        }
        resolve();
      });
    });
    
    req.on('error', (e) => {
      console.error(`❌ Error: ${e.message}`);
      resolve();
    });
    
    req.write(postData);
    req.end();
  });
}

async function runTests() {
  await testEndpoint(flutterTestData, "Valid Flutter Data");
  await testEndpoint(edgeCaseData, "Edge Case Data (Empty Fields)");
}

runTests();
