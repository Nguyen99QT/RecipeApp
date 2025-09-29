// Test Flutter Mobile App Sync API directly
// This simulates the actual Flutter app calling the sync API

const http = require('http');

// Test data simulating Flutter app saved recipes from SharedPreferences
const testMobileRecipes = [
    {
        "id": "ai_recipe_1758245850123_1",
        "title": "Vietnamese Salted Egg and Winter Melon Soup",
        "description": "A comforting and flavorful Vietnamese soup featuring salted duck eggs, winter melon, and fresh herbs.",
        "ingredients": [
            "5 salted duck eggs",
            "500g winter melon, peeled, seeded, and cubed", 
            "4 cups chicken broth",
            "1/4 cup chopped cilantro",
            "2 scallions, thinly sliced",
            "1-2 small red chilies, thinly sliced (optional)",
            "1 teaspoon ground black pepper",
            "1 tablespoon fish sauce (or to taste)",
            "1 teaspoon sugar (optional)"
        ],
        "instructions": [
            "Crack salted eggs into a bowl, separate whites and yolks",
            "Heat chicken broth in a large pot over medium heat",
            "Add winter melon cubes and cook for 10-15 minutes until tender",
            "Slowly pour in egg whites while stirring to create silky ribbons",
            "Add crumbled egg yolks and simmer for 2-3 minutes",
            "Season with fish sauce, pepper, and sugar to taste",
            "Remove from heat and garnish with cilantro, scallions, and chilies",
            "Serve hot with steamed rice"
        ],
        "cuisine": "Vietnamese",
        "preparationTime": 20,
        "cookingTime": 25,
        "servings": 5,
        "difficulty": "Medium",
        "tags": ["vietnamese", "soup", "comfort-food", "salted-egg", "winter-melon"],
        "imageUrl": "https://via.placeholder.com/400x300?text=Vietnamese+Soup",
        "estimatedCalories": 350,
        "createdAt": new Date().toISOString()
    },
    {
        "id": "ai_recipe_1758245850123_2", 
        "title": "Bit Tết Bò Kiểu Pháp với Rau Củ Nướng",
        "description": "Món bit tết bò mềm mại, thơm ngon được chế biến theo phong cách Pháp, ăn kèm với rau củ nướng và khoai tây nghiền, tao nên một bữa ăn tinh tế và đậy đủ dinh dưỡng.",
        "ingredients": [
            "1.2 kg thịt bò thăn ngoài (Ribeye) hoặc thăn lưng (Sirloin)",
            "2 củ hành tím, băm nhỏ", 
            "4 tép tỏi, băm nhỏ",
            "2 nhành rosemary tươi",
            "1 muỗng canh dầu olive",
            "Muối và tiêu đen xay",
            "200g khoai tây, gọt vỏ và cắt nhỏ",
            "100g bơ lạt"
        ],
        "instructions": [
            "Ướp thịt bò với muối, tiêu, dầu olive và rosemary trong 30 phút",
            "Luộc khoai tây cho đến khi mềm, sau đó nghiền với bơ",
            "Nướng rau củ trong lò 200°C trong 25-30 phút", 
            "Chiên thịt bò trên chảo nóng mỗi mặt 3-4 phút để có độ medium rare",
            "Để thịt nghỉ 5 phút trước khi thái",
            "Bày trí thịt bò cùng khoai tây nghiền và rau củ nướng",
            "Trang trí với rosemary tươi và phục vụ ngay"
        ],
        "cuisine": "French",
        "preparationTime": 45,
        "cookingTime": 30,
        "servings": 4,
        "difficulty": "Hard",
        "tags": ["french", "beef", "steak", "elegant", "roasted-vegetables"],
        "imageUrl": "https://via.placeholder.com/400x300?text=French+Steak",
        "estimatedCalories": 650,
        "createdAt": new Date().toISOString()
    }
];

async function testFlutterSyncAPI() {
    const userId = '68b5415812984b1cef66b9a8'; // Huy's user ID 
    const authToken = 'test_token_flutter_app';
    
    const syncData = {
        userId: userId,
        savedRecipes: testMobileRecipes,
        deviceInfo: {
            platform: 'flutter',
            os: 'Android',
            version: '13', 
            device: 'Samsung Galaxy S23',
            appVersion: '1.0.0'
        }
    };

    const postData = JSON.stringify(syncData);
    
    const options = {
        hostname: 'localhost',
        port: 8190,
        path: '/api/testSyncSavedAiRecipes',
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${authToken}`,
            'Content-Length': Buffer.byteLength(postData)
        }
    };

    return new Promise((resolve, reject) => {
        console.log('📱 Testing Flutter Mobile App Sync...');
        console.log(`   User: ${userId}`);
        console.log(`   Recipes to sync: ${testMobileRecipes.length}`);
        console.log(`   URL: http://localhost:8190/api/testSyncSavedAiRecipes`);
        console.log('');

        const req = http.request(options, (res) => {
            let responseData = '';

            res.on('data', (chunk) => {
                responseData += chunk;
            });

            res.on('end', () => {
                try {
                    const result = JSON.parse(responseData);
                    
                    if (result.success) {
                        console.log('✅ Sync successful!');
                        console.log(`   Synced: ${result.data.syncedCount} recipes`);
                        console.log(`   Duplicates: ${result.data.duplicateCount} recipes`);
                        console.log(`   Errors: ${result.data.errorCount} recipes`);
                        console.log('');
                        console.log('🌐 Recipes now available in admin panel:');
                        console.log('   Check admin panel: http://localhost:8190/saved-ai-recipes');
                        console.log('');
                        console.log('📱 Flutter recipes synced:');
                        testMobileRecipes.forEach((recipe, index) => {
                            console.log(`   ${index + 1}. ${recipe.title}`);
                            console.log(`      Cuisine: ${recipe.cuisine} | Difficulty: ${recipe.difficulty}`);
                        });
                    } else {
                        console.log('❌ Sync failed:', result.message);
                    }
                    
                    resolve(result);
                } catch (e) {
                    console.error('❌ Error parsing response:', e.message);
                    console.log('Raw response:', responseData);
                    reject(e);
                }
            });
        });

        req.on('error', (err) => {
            console.error('❌ Request error:', err.message);
            reject(err);
        });

        req.write(postData);
        req.end();
    });
}

testFlutterSyncAPI().catch(console.error);
