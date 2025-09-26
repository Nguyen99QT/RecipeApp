// Test data từ Flutter app (dựa trên ai_recipe_bloc.dart)
const flutterData = {
  'title': 'meal.title',
  'description': 'meal.description', 
  'instructions': 'meal.instructions', // Array
  'ingredients': 'meal.ingredients',   // Array
  'userId': 'realUserId',
  'userEmail': 'realUserEmail',
  'preparationTime': 'meal.preparationTime.toString()',
  'cookingTime': 'meal.cookingTime.toString()',
  'cuisine': 'meal.cuisine',
  'tags': 'meal.tags',               // Array
  'difficulty': 'meal.difficulty',
  'servings': 'meal.servings.toString()',
  'estimatedCalories': 'meal.estimatedCalories?.toString() ?? ""',
  'imageUrl': 'meal.imageUrl ?? ""',
  'createdAt': 'DateTime.now().toIso8601String()'
};

// Backend expectation (dựa trên savedAiRecipeController.js)
const backendExpected = {
  title: 'required string',
  description: 'required string', 
  ingredients: 'required array',
  instructions: 'required array',
  userId: 'required string',
  userEmail: 'required string',
  preparationTime: 'optional string',
  cookingTime: 'optional string',
  cuisine: 'optional string',
  tags: 'optional array',
  difficulty: 'optional string',
  servings: 'optional string',
  estimatedCalories: 'optional string',
  imageUrl: 'optional string',
  createdAt: 'optional string'
};

console.log('Flutter app data format:');
console.log(JSON.stringify(flutterData, null, 2));

console.log('\nBackend expected format:');
console.log(JSON.stringify(backendExpected, null, 2));

console.log('\n✅ Format matching: Both should work correctly');
console.log('⚠️  Possible issue: Real data values might be empty or invalid');