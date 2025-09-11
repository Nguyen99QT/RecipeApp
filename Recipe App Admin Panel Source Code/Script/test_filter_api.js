async function testFilterRecipeAPI() {
    try {
        const response = await fetch('http://172.16.2.199:8190/api/FilterRecipe', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                categoryId: '',
                cuisinesIdList: [],
                userId: ''
            })
        });
        
        const data = await response.json();
        
        console.log('FilterRecipe API Response:');
        console.log('Status:', data.status);
        console.log('Data length:', data.data ? data.data.length : 0);
        
        if (data.data && data.data.length > 0) {
            console.log('First recipe structure:');
            console.log('- _id:', data.data[0]._id);
            console.log('- name:', data.data[0].name);
            console.log('- categoryId:', data.data[0].categoryId);
            console.log('- cuisinesId:', data.data[0].cuisinesId);
            console.log('Keys:', Object.keys(data.data[0]));
        }
        
    } catch (error) {
        console.error('Error testing FilterRecipe API:', error.message);
    }
}

testFilterRecipeAPI();
