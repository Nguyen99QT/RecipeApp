const testGetReviews = async () => {
  const fetch = (await import('node-fetch')).default;
  
  const data = {
    recipeId: '68a17328e02661538f117092' // Oats Porridge
  };
  
  try {
    const response = await fetch('http://localhost:8190/api/GetReviewByRecipeId', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    });
    
    const result = await response.json();
    console.log('GetReviewByRecipeId API Test Results:');
    console.log('Status:', response.status);
    console.log('Response:', JSON.stringify(result, null, 2));
    
    if (response.status === 200 && result.status) {
      console.log('✅ GetReviewByRecipeId API is working correctly!');
      console.log('Number of reviews:', result.data ? result.data.length : 0);
    } else {
      console.log('❌ GetReviewByRecipeId API failed!');
    }
    
  } catch (error) {
    console.error('Error testing GetReviewByRecipeId API:', error.message);
  }
};

testGetReviews();
