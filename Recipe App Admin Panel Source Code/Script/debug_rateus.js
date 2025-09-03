// Test script để debug Rate Us functionality
const testRateUsDebug = async () => {
  const fetch = (await import('node-fetch')).default;
  
  console.log('=== TESTING RATE US FUNCTIONALITY ===\n');
  
  // Test 1: Valid request
  console.log('🧪 Test 1: Valid AddReview request');
  const validData = {
    recipeId: '68a17328e02661538f117092',
    rating: 4,
    comment: 'Test from Flutter debug - This recipe is amazing!'
  };
  
  try {
    const response = await fetch('http://localhost:8190/api/AddReview', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YTMxMzBjYzJlMTgxMWI1ZGJjZmVkOCIsImlhdCI6MTc1NjgyNjEyOSwiZXhwIjoxNzU5NDE4MTI5fQ.k_6c8O0z1ZmSBQ0moZG4xwZllAOLQ5wDqYORMS5SGGE'
      },
      body: JSON.stringify(validData)
    });
    
    const result = await response.json();
    console.log('   Status:', response.status);
    console.log('   Response:', JSON.stringify(result, null, 2));
    console.log('   ✅ Status:', response.status === 200 ? 'PASS' : 'FAIL');
    
  } catch (error) {
    console.log('   ❌ Error:', error.message);
  }
  
  console.log('\n===========================================\n');
  
  // Test 2: Missing required fields
  console.log('🧪 Test 2: Missing rating field');
  const missingRatingData = {
    recipeId: '68a17328e02661538f117092',
    comment: 'Missing rating test'
  };
  
  try {
    const response = await fetch('http://localhost:8190/api/AddReview', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YTMxMzBjYzJlMTgxMWI1ZGJjZmVkOCIsImlhdCI6MTc1NjgyNjEyOSwiZXhwIjoxNzU5NDE4MTI5fQ.k_6c8O0z1ZmSBQ0moZG4xwZllAOLQ5wDqYORMS5SGGE'
      },
      body: JSON.stringify(missingRatingData)
    });
    
    const result = await response.json();
    console.log('   Status:', response.status);
    console.log('   Response:', JSON.stringify(result, null, 2));
    console.log('   ✅ Status:', response.status === 400 ? 'PASS (Expected error)' : 'FAIL');
    
  } catch (error) {
    console.log('   ❌ Error:', error.message);
  }
  
  console.log('\n===========================================\n');
  
  // Test 3: Invalid token
  console.log('🧪 Test 3: Invalid token');
  try {
    const response = await fetch('http://localhost:8190/api/AddReview', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer invalid_token_123'
      },
      body: JSON.stringify(validData)
    });
    
    const result = await response.json();
    console.log('   Status:', response.status);
    console.log('   Response:', JSON.stringify(result, null, 2));
    console.log('   ✅ Status:', response.status === 401 ? 'PASS (Expected unauthorized)' : 'FAIL');
    
  } catch (error) {
    console.log('   ❌ Error:', error.message);
  }
  
  console.log('\n=== TEST COMPLETED ===');
};

testRateUsDebug();
