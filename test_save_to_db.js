const http = require('http');

const testData = {
  savedRecipes: [{
    id: 'test_recipe_' + Date.now(),
    title: 'Vietnamese Shrimp and Pork Noodle Soup (Bún Tôm Nướng)',
    description: 'A flavorful and aromatic Vietnamese noodle soup featuring succulent shrimp, savory pork, and a vibrant broth.',
    ingredients: [
      '200g rice vermicelli noodles',
      '300g fresh shrimp, peeled and deveined',
      '200g pork belly, sliced',
      '2 cloves garlic, minced',
      '1 shallot, sliced'
    ],
    instructions: [
      'Cook rice vermicelli according to package instructions',
      'Grill shrimp and pork until cooked through',
      'Prepare aromatic broth with herbs and spices',
      'Assemble bowl with noodles, proteins, and broth'
    ],
    cuisine: 'Vietnamese',
    preparationTime: 20,
    cookingTime: 25,
    servings: 2,
    difficulty: 'Medium',
    tags: ['vietnamese', 'noodle-soup', 'seafood'],
    imageUrl: null,
    estimatedCalories: 450,
    createdAt: new Date().toISOString()
  }],
  userId: 'test_user_flutter',
  userEmail: 'test@example.com',
  deviceInfo: {
    platform: 'flutter',
    version: '1.0.0',
    timestamp: new Date().toISOString()
  }
};

const postData = JSON.stringify(testData);

const options = {
  hostname: 'localhost',
  port: 3000,
  path: '/api/testSyncSavedAiRecipes',
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Content-Length': Buffer.byteLength(postData)
  }
};

console.log('🧪 Testing save to database...');
console.log('📤 Sending request to: http://localhost:3000/api/testSyncSavedAiRecipes');

const req = http.request(options, (res) => {
  console.log(`📊 Status Code: ${res.statusCode}`);
  
  let data = '';
  
  res.on('data', (chunk) => {
    data += chunk;
  });
  
  res.on('end', () => {
    console.log('📋 Response:', data);
    try {
      const response = JSON.parse(data);
      if (response.success) {
        console.log('✅ SUCCESS: Recipe saved to database!');
        console.log(`   Synced: ${response.data?.syncedCount || 0} recipes`);
      } else {
        console.log('❌ FAILED:', response.message);
      }
    } catch (e) {
      console.log('❌ Failed to parse response:', e.message);
    }
  });
});

req.on('error', (e) => {
  console.error('❌ Request error:', e.message);
  console.log('💡 Make sure server is running on port 3000');
});

req.write(postData);
req.end();