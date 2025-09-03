const testAddReview = async () => {
  const fetch = (await import('node-fetch')).default;
  
  const data = {
    recipeId: '68a17328e02661538f117092', // Oats Porridge
    rating: 5,
    comment: 'Great recipe! Very delicious from API test!'
  };
  
  try {
    const response = await fetch('http://localhost:8190/api/AddReview', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YTMxMzBjYzJlMTgxMWI1ZGJjZmVkOCIsImlhdCI6MTc1NjgyNjEyOSwiZXhwIjoxNzU5NDE4MTI5fQ.k_6c8O0z1ZmSBQ0moZG4xwZllAOLQ5wDqYORMS5SGGE'
      },
      body: JSON.stringify(data)
    });
    
    const result = await response.json();
    console.log('AddReview API Test Results:');
    console.log('Status:', response.status);
    console.log('Response:', JSON.stringify(result, null, 2));
    
    if (response.status === 200 && result.status) {
      console.log('✅ AddReview API is working correctly!');
    } else {
      console.log('❌ AddReview API failed!');
    }
    
  } catch (error) {
    console.error('Error testing AddReview API:', error.message);
  }
};

testAddReview();
