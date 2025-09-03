const testGetRecipeById = async () => {
  const fetch = (await import('node-fetch')).default;
  
  const data = {
    userId: '68a3130cc2e1811b5dbcfed8',
    recipeId: '68a17328e02661538f117092' // Oats Porridge
  };
  
  try {
    const response = await fetch('http://localhost:8190/api/GetRecipeById', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YTMxMzBjYzJlMTgxMWI1ZGJjZmVkOCIsImlhdCI6MTc1NjgyNjEyOSwiZXhwIjoxNzU5NDE4MTI5fQ.k_6c8O0z1ZmSBQ0moZG4xwZllAOLQ5wDqYORMS5SGGE'
      },
      body: JSON.stringify(data)
    });
    
    const result = await response.json();
    console.log('GetRecipeById API Test Results:');
    console.log('Status:', response.status);
    console.log('Response:', JSON.stringify(result, null, 2));
    
    // Kiểm tra thông tin cuisine cụ thể
    if (result.data && result.data.cuisinesId) {
      console.log('\n🍽️ Cuisine Information:');
      console.log('cuisinesId:', result.data.cuisinesId);
      console.log('cuisinesId.name:', result.data.cuisinesId.name);
    } else {
      console.log('\n❌ No cuisine information found in response!');
      console.log('Available data fields:', Object.keys(result.data || {}));
    }
    
  } catch (error) {
    console.error('Error testing GetRecipeById API:', error.message);
  }
};

testGetRecipeById();
