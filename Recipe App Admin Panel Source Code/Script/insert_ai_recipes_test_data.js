// Insert test data for regular AI recipes (aiRecipes collection)
require('dotenv').config();
require('./config/conn');
const aiRecipeModel = require('./model/aiRecipeModel');
const userModel = require('./model/userModel');
const mongoose = require('mongoose');

async function insertTestAiRecipes() {
    try {
        console.log('🤖 Inserting test AI recipes...');

        // Get existing users or create test users
        let users = await userModel.find().limit(5);
        
        if (users.length === 0) {
            console.log('📝 Creating test users first...');
            const testUsers = [
                {
                    firstname: 'John',
                    lastname: 'Doe',
                    email: 'john.doe@test.com',
                    mobile: '1234567890',
                    password: 'password123',
                    isVerified: true
                },
                {
                    firstname: 'Jane',
                    lastname: 'Smith',
                    email: 'jane.smith@test.com',
                    mobile: '1234567891',
                    password: 'password123',
                    isVerified: true
                },
                {
                    firstname: 'Mike',
                    lastname: 'Johnson',
                    email: 'mike.johnson@test.com',
                    mobile: '1234567892',
                    password: 'password123',
                    isVerified: true
                }
            ];

            users = await userModel.insertMany(testUsers);
            console.log(`✅ Created ${users.length} test users`);
        }

        // Clear existing AI recipes
        await aiRecipeModel.deleteMany({});
        console.log('🗑️ Cleared existing AI recipes');

        // Test AI recipes data
        const aiRecipes = [
            {
                userId: users[0]._id,
                recipeName: "AI-Generated Spicy Thai Curry",
                recipeContent: `
## Ingredients:
- 500g chicken breast, sliced
- 2 tbsp red curry paste
- 400ml coconut milk
- 2 tbsp fish sauce
- 1 tbsp brown sugar
- Thai basil leaves
- Bell peppers, sliced

## Instructions:
1. Heat oil in a pan and add curry paste
2. Add chicken and cook until tender
3. Pour coconut milk and simmer
4. Add fish sauce and sugar
5. Add vegetables and basil
6. Serve with jasmine rice
                `,
                ingredients: [
                    "Chicken breast - 500g",
                    "Red curry paste - 2 tbsp",
                    "Coconut milk - 400ml",
                    "Fish sauce - 2 tbsp",
                    "Brown sugar - 1 tbsp",
                    "Thai basil leaves",
                    "Bell peppers"
                ],
                servingSize: 4,
                cookingTime: 30,
                difficultyLevel: 'Medium',
                tags: ['Thai', 'Spicy', 'Curry', 'AI-Generated']
            },
            {
                userId: users[1]._id,
                recipeName: "AI Mushroom Risotto",
                recipeContent: `
## Ingredients:
- 300g Arborio rice
- 500ml warm chicken stock
- 200g mixed mushrooms
- 1 onion, diced
- 2 cloves garlic
- 100ml white wine
- Parmesan cheese
- Butter and olive oil

## Instructions:
1. Sauté onions and garlic in olive oil
2. Add rice and stir for 2 minutes
3. Add wine and let it absorb
4. Gradually add warm stock, stirring constantly
5. In separate pan, cook mushrooms
6. Fold in mushrooms and parmesan
7. Finish with butter
                `,
                ingredients: [
                    "Arborio rice - 300g",
                    "Chicken stock - 500ml",
                    "Mixed mushrooms - 200g",
                    "Onion - 1 medium",
                    "Garlic - 2 cloves",
                    "White wine - 100ml",
                    "Parmesan cheese - 50g",
                    "Butter and olive oil"
                ],
                servingSize: 3,
                cookingTime: 45,
                difficultyLevel: 'Hard',
                tags: ['Italian', 'Vegetarian', 'Risotto', 'AI-Generated']
            },
            {
                userId: users[2]._id,
                recipeName: "AI Korean Bibimbap Bowl",
                recipeContent: `
## Ingredients:
- 2 cups cooked rice
- 200g beef strips
- Mixed vegetables (carrots, spinach, bean sprouts)
- Korean gochujang sauce
- Sesame oil
- Fried eggs
- Nori sheets

## Instructions:
1. Prepare all vegetables separately
2. Marinate and cook beef
3. Fry eggs sunny side up
4. Arrange rice in bowls
5. Top with vegetables, meat, and egg
6. Serve with gochujang sauce
7. Mix before eating
                `,
                ingredients: [
                    "Cooked rice - 2 cups",
                    "Beef strips - 200g",
                    "Mixed vegetables",
                    "Gochujang sauce - 2 tbsp",
                    "Sesame oil - 1 tbsp",
                    "Eggs - 2 pieces",
                    "Nori sheets"
                ],
                servingSize: 2,
                cookingTime: 40,
                difficultyLevel: 'Medium',
                tags: ['Korean', 'Healthy', 'Bowl', 'AI-Generated']
            },
            {
                userId: users[0]._id,
                recipeName: "AI Chocolate Lava Cake",
                recipeContent: `
## Ingredients:
- 100g dark chocolate
- 100g butter
- 2 eggs
- 2 egg yolks
- 50g sugar
- 2 tbsp flour
- Pinch of salt
- Vanilla ice cream

## Instructions:
1. Preheat oven to 200°C
2. Melt chocolate and butter
3. Whisk eggs, yolks, and sugar
4. Combine with chocolate mixture
5. Add flour and salt
6. Pour into ramekins
7. Bake for 12 minutes
8. Serve immediately with ice cream
                `,
                ingredients: [
                    "Dark chocolate - 100g",
                    "Butter - 100g",
                    "Eggs - 2 whole + 2 yolks",
                    "Sugar - 50g",
                    "Flour - 2 tbsp",
                    "Salt - pinch",
                    "Vanilla ice cream"
                ],
                servingSize: 2,
                cookingTime: 20,
                difficultyLevel: 'Easy',
                tags: ['Dessert', 'Chocolate', 'Quick', 'AI-Generated']
            },
            {
                userId: users[1]._id,
                recipeName: "AI Vietnamese Pho",
                recipeContent: `
## Ingredients:
- 200g rice noodles
- 500ml beef broth
- 150g beef slices
- Bean sprouts
- Fresh herbs (cilantro, mint, basil)
- Lime wedges
- Fish sauce and hoisin sauce
- Onion and ginger

## Instructions:
1. Prepare aromatic broth with onion and ginger
2. Cook rice noodles separately
3. Slice beef thinly
4. Prepare fresh herb plate
5. Place noodles in bowls
6. Add raw beef slices
7. Pour hot broth over
8. Serve with herbs and sauces
                `,
                ingredients: [
                    "Rice noodles - 200g",
                    "Beef broth - 500ml",
                    "Beef slices - 150g",
                    "Bean sprouts - 100g",
                    "Fresh herbs mix",
                    "Lime wedges",
                    "Fish sauce",
                    "Hoisin sauce",
                    "Onion and ginger"
                ],
                servingSize: 2,
                cookingTime: 60,
                difficultyLevel: 'Hard',
                tags: ['Vietnamese', 'Soup', 'Authentic', 'AI-Generated']
            }
        ];

        // Insert AI recipes
        const insertedRecipes = await aiRecipeModel.insertMany(aiRecipes);
        console.log(`✅ Created ${insertedRecipes.length} AI recipes`);

        // Summary
        console.log('\n📊 Summary:');
        console.log(`   • Total AI recipes: ${insertedRecipes.length}`);
        console.log(`   • Users: ${users.length}`);
        console.log(`   • Cuisines: Thai, Italian, Korean, Dessert, Vietnamese`);
        console.log(`   • Difficulty levels: Easy, Medium, Hard`);

        console.log('\n🌐 Admin Panel URLs:');
        console.log(`   • View AI recipes: http://localhost:3000/ai-recipes`);
        console.log(`   • View saved AI recipes: http://localhost:3000/saved-ai-recipes`);
        console.log(`   • AI Recipe Try-It: http://localhost:3000/ai-recipe-try-it`);

        console.log('\n🎉 Ready to view in admin panel!');

    } catch (error) {
        console.error('❌ Error inserting AI recipes:', error);
    } finally {
        mongoose.connection.close();
    }
}

// Run the script
insertTestAiRecipes();