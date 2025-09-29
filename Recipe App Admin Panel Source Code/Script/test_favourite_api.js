const testFavouriteAPI = async () => {
  const fetch = (await import('node-fetch')).default;
  
  // User data from logs
  const userId = '68b5415812984b1cef66b9a8';
  const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YjU0MTU4MTI5ODRiMWNlZjY2YjlhOCIsImlhdCI6MTc1Nzk5NTYxNywiZXhwIjoxNzYwNTg3NjE3fQ.JeobCVh1ky_YAZNU9ZPb-LNR5rNMfly2icTFRrYdCfU';
  
  try {
    console.log('🔍 Testing getAllFavouriteRecipes API...');
    console.log('UserId:', userId);
    
    const response = await fetch('http://localhost:8190/api/GetAllFavouriteRecipes', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      },
      body: JSON.stringify({ userId: userId })
    });
    
    const result = await response.json();
    console.log('\n📊 API Response:');
    console.log('Status Code:', response.status);
    console.log('Response Body:', JSON.stringify(result, null, 2));
    
    if (response.status === 200 && result.status && result.data) {
      console.log('\n✅ API is working!');
      console.log('Number of favourite recipes:', result.data.length);
      
      // Check structure of first item
      if (result.data.length > 0) {
        const firstItem = result.data[0];
        console.log('\n🔍 First item structure:');
        console.log('Item ID:', firstItem._id);
        console.log('User ID:', firstItem.userId);
        console.log('Recipe ID structure:', firstItem.recipeId ? typeof firstItem.recipeId : 'missing');
        
        if (firstItem.recipeId) {
          console.log('\n📝 Recipe details:');
          console.log('Recipe _id:', firstItem.recipeId._id);
          console.log('Recipe name:', firstItem.recipeId.name);
          console.log('Recipe image:', firstItem.recipeId.image);
          console.log('Recipe prepTime:', firstItem.recipeId.prepTime);
          console.log('Recipe totalCookTime:', firstItem.recipeId.totalCookTime);
          
          // Check if populated fields exist
          console.log('\n🔗 Populated fields check:');
          console.log('Has categoryId:', !!firstItem.recipeId.categoryId);
          console.log('Has cuisinesId:', !!firstItem.recipeId.cuisinesId);
          console.log('Has averageRating:', !!firstItem.recipeId.averageRating);
          console.log('Has totalRating:', !!firstItem.recipeId.totalRating);
        }
      }
    } else {
      console.log('\n❌ API failed!');
      console.log('Error message:', result.message || 'No error message');
    }
    
  } catch (error) {
    console.error('\n💥 Error testing favourite API:', error.message);
  }
};

testFavouriteAPI();
