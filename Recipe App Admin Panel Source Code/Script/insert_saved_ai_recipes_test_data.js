const mongoose = require('mongoose');
require('dotenv').config();

// Import database connection
require('./config/conn');

const savedAiRecipeModel = require('./model/savedAiRecipeModel');
const userModel = require('./model/userModel');

// Test data for saved AI recipes
const testSavedRecipes = [
    {
        id: 'ai_recipe_001',
        title: 'Grilled Chicken with Herbs',
        description: 'A delicious and healthy grilled chicken dish with fresh herbs and spices.',
        ingredients: [
            '2 chicken breasts',
            '2 tbsp olive oil',
            '1 tsp garlic powder',
            '1 tsp dried oregano',
            '1 tsp dried thyme',
            'Salt and pepper to taste',
            'Fresh parsley for garnish'
        ],
        instructions: [
            'Preheat grill to medium-high heat',
            'Season chicken breasts with olive oil, garlic powder, oregano, thyme, salt, and pepper',
            'Grill chicken for 6-7 minutes per side until cooked through',
            'Let rest for 5 minutes before slicing',
            'Garnish with fresh parsley and serve'
        ],
        cuisine: 'American',
        preparationTime: 15,
        cookingTime: 15,
        servings: 2,
        difficulty: 'Easy',
        tags: ['grilled', 'healthy', 'protein', 'herbs'],
        imageUrl: 'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?w=400',
        estimatedCalories: 320,
        recipeCreatedAt: new Date('2024-01-15T10:30:00Z'),
        userEmail: 'testuser@example.com',
        savedAt: new Date('2024-01-15T10:35:00Z'),
        deviceInfo: {
            platform: 'Android',
            version: '13.0 (API 33)'
        },
        status: 'active'
    },
    {
        id: 'ai_recipe_002',
        title: 'Vegetarian Pasta Primavera',
        description: 'Fresh vegetables tossed with pasta in a light garlic and herb sauce.',
        ingredients: [
            '12 oz penne pasta',
            '1 zucchini, sliced',
            '1 bell pepper, chopped',
            '1 cup cherry tomatoes, halved',
            '1/2 cup broccoli florets',
            '3 cloves garlic, minced',
            '1/4 cup olive oil',
            '1/4 cup parmesan cheese',
            'Fresh basil leaves',
            'Salt and pepper to taste'
        ],
        instructions: [
            'Cook pasta according to package directions, drain and reserve 1/2 cup pasta water',
            'Heat olive oil in large pan over medium heat',
            'Add garlic and cook for 30 seconds until fragrant',
            'Add zucchini, bell pepper, and broccoli, cook for 5-6 minutes',
            'Add cherry tomatoes and cook for 2-3 minutes',
            'Add cooked pasta and toss with vegetables',
            'Add pasta water if needed for moisture',
            'Season with salt, pepper, and top with parmesan and basil'
        ],
        cuisine: 'Italian',
        preparationTime: 20,
        cookingTime: 15,
        servings: 4,
        difficulty: 'Easy',
        tags: ['vegetarian', 'pasta', 'vegetables', 'italian'],
        imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc353d2e5?w=400',
        estimatedCalories: 385,
        recipeCreatedAt: new Date('2024-01-16T14:20:00Z'),
        userEmail: 'veggie.lover@example.com',
        savedAt: new Date('2024-01-16T14:25:00Z'),
        deviceInfo: {
            platform: 'iOS',
            version: '17.2'
        },
        status: 'active'
    },
    {
        id: 'ai_recipe_003',
        title: 'Asian Beef Stir Fry',
        description: 'Quick and flavorful beef stir fry with mixed vegetables in savory sauce.',
        ingredients: [
            '1 lb beef sirloin, sliced thin',
            '2 tbsp vegetable oil',
            '1 onion, sliced',
            '1 red bell pepper, sliced',
            '1 cup snap peas',
            '2 carrots, julienned',
            '3 cloves garlic, minced',
            '2 tbsp soy sauce',
            '1 tbsp oyster sauce',
            '1 tsp sesame oil',
            '1 tsp cornstarch',
            'Green onions for garnish'
        ],
        instructions: [
            'Mix beef with cornstarch and 1 tbsp soy sauce, let marinate 10 minutes',
            'Heat oil in wok or large pan over high heat',
            'Add beef and stir-fry for 2-3 minutes until browned',
            'Remove beef and set aside',
            'Add vegetables to pan and stir-fry for 3-4 minutes',
            'Return beef to pan with remaining soy sauce, oyster sauce, and sesame oil',
            'Stir-fry for 1-2 minutes until heated through',
            'Garnish with green onions and serve over rice'
        ],
        cuisine: 'Asian',
        preparationTime: 25,
        cookingTime: 10,
        servings: 4,
        difficulty: 'Medium',
        tags: ['stir-fry', 'beef', 'asian', 'quick'],
        imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=400',
        estimatedCalories: 285,
        recipeCreatedAt: new Date('2024-01-17T18:45:00Z'),
        userEmail: 'asian.food.fan@example.com',
        savedAt: new Date('2024-01-17T18:50:00Z'),
        deviceInfo: {
            platform: 'Android',
            version: '14.0 (API 34)'
        },
        status: 'active'
    },
    {
        id: 'ai_recipe_004',
        title: 'Chocolate Chip Cookies',
        description: 'Classic homemade chocolate chip cookies that are crispy on the outside and chewy inside.',
        ingredients: [
            '2 1/4 cups all-purpose flour',
            '1 tsp baking soda',
            '1 tsp salt',
            '1 cup butter, softened',
            '3/4 cup granulated sugar',
            '3/4 cup brown sugar',
            '2 large eggs',
            '2 tsp vanilla extract',
            '2 cups chocolate chips'
        ],
        instructions: [
            'Preheat oven to 375°F (190°C)',
            'Mix flour, baking soda, and salt in a bowl',
            'Cream butter with both sugars until light and fluffy',
            'Beat in eggs one at a time, then vanilla',
            'Gradually mix in flour mixture',
            'Stir in chocolate chips',
            'Drop rounded tablespoons onto ungreased baking sheets',
            'Bake 9-11 minutes until golden brown',
            'Cool on baking sheet for 2 minutes before transferring'
        ],
        cuisine: 'American',
        preparationTime: 20,
        cookingTime: 11,
        servings: 36,
        difficulty: 'Easy',
        tags: ['dessert', 'cookies', 'chocolate', 'baking'],
        imageUrl: 'https://images.unsplash.com/photo-1558961363-fa8fdf82db35?w=400',
        estimatedCalories: 142,
        recipeCreatedAt: new Date('2024-01-18T16:15:00Z'),
        userEmail: 'sweet.tooth@example.com',
        savedAt: new Date('2024-01-18T16:20:00Z'),
        deviceInfo: {
            platform: 'iOS',
            version: '17.1'
        },
        status: 'active'
    },
    {
        id: 'ai_recipe_005',
        title: 'Mediterranean Quinoa Salad',
        description: 'Fresh and healthy quinoa salad with Mediterranean flavors and vegetables.',
        ingredients: [
            '1 cup quinoa',
            '2 cups vegetable broth',
            '1 cucumber, diced',
            '1 cup cherry tomatoes, halved',
            '1/2 red onion, finely chopped',
            '1/2 cup kalamata olives, pitted',
            '1/2 cup feta cheese, crumbled',
            '1/4 cup fresh parsley, chopped',
            '2 tbsp fresh mint, chopped',
            '1/4 cup olive oil',
            '2 tbsp lemon juice',
            '1 clove garlic, minced',
            'Salt and pepper to taste'
        ],
        instructions: [
            'Rinse quinoa and cook in vegetable broth until tender, about 15 minutes',
            'Let quinoa cool completely',
            'Combine cucumber, tomatoes, red onion, olives, and feta in large bowl',
            'Add cooled quinoa to vegetables',
            'Whisk together olive oil, lemon juice, garlic, salt, and pepper',
            'Pour dressing over salad and toss gently',
            'Stir in fresh herbs',
            'Chill for at least 30 minutes before serving'
        ],
        cuisine: 'Mediterranean',
        preparationTime: 30,
        cookingTime: 15,
        servings: 6,
        difficulty: 'Easy',
        tags: ['healthy', 'quinoa', 'mediterranean', 'vegetarian', 'salad'],
        imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=400',
        estimatedCalories: 245,
        recipeCreatedAt: new Date('2024-01-19T12:00:00Z'),
        userEmail: 'healthy.eater@example.com',
        savedAt: new Date('2024-01-19T12:05:00Z'),
        deviceInfo: {
            platform: 'Android',
            version: '13.0 (API 33)'
        },
        status: 'active'
    }
];

// Function to create test users if they don't exist
async function createTestUsers() {
    const testUsers = [
        { email: 'testuser@example.com', firstname: 'John', lastname: 'Doe' },
        { email: 'veggie.lover@example.com', firstname: 'Sarah', lastname: 'Green' },
        { email: 'asian.food.fan@example.com', firstname: 'Mike', lastname: 'Chen' },
        { email: 'sweet.tooth@example.com', firstname: 'Emily', lastname: 'Baker' },
        { email: 'healthy.eater@example.com', firstname: 'Alex', lastname: 'Smith' }
    ];

    for (const userData of testUsers) {
        try {
            let user = await userModel.findOne({ email: userData.email });
            if (!user) {
                user = new userModel({
                    ...userData,
                    password: 'test123', // This should be hashed in real implementation
                    isVerified: true
                });
                await user.save();
                console.log(`Created test user: ${userData.email}`);
            }
        } catch (error) {
            console.log(`Error creating user ${userData.email}:`, error.message);
        }
    }
}

// Function to insert test data
async function insertTestData() {
    try {
        console.log('Creating test users...');
        await createTestUsers();

        console.log('Clearing existing saved AI recipes...');
        await savedAiRecipeModel.deleteMany({});

        console.log('Inserting test saved AI recipes...');
        
        for (const recipeData of testSavedRecipes) {
            // Find user by email
            const user = await userModel.findOne({ email: recipeData.userEmail });
            if (user) {
                const savedRecipe = new savedAiRecipeModel({
                    ...recipeData,
                    userId: user._id
                });
                await savedRecipe.save();
                console.log(`✅ Created saved recipe: ${recipeData.title}`);
            } else {
                console.log(`❌ User not found for email: ${recipeData.userEmail}`);
            }
        }

        console.log('✨ Test data insertion completed successfully!');
        
        // Display summary
        const totalSaved = await savedAiRecipeModel.countDocuments({ status: 'active' });
        const totalUsers = await userModel.countDocuments();
        
        console.log(`\n📊 Summary:`);
        console.log(`   • Total saved AI recipes: ${totalSaved}`);
        console.log(`   • Total users: ${totalUsers}`);
        console.log(`   • Admin panel URL: http://localhost:3000/saved-ai-recipes`);
        
    } catch (error) {
        console.error('Error inserting test data:', error);
    }
}

// Export for use in other files
module.exports = {
    insertTestData,
    testSavedRecipes
};

// Run the script if called directly
if (require.main === module) {
    insertTestData().then(() => {
        console.log('\n🎉 Script completed successfully!');
        process.exit(0);
    }).catch(error => {
        console.error('❌ Script failed:', error);
        process.exit(1);
    });
}
