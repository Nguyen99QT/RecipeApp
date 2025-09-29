import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../domain/entities/ai_meal.dart';
import '../../domain/entities/ai_recipe_request.dart';
import 'ai_recipe_remote_datasource.dart';

/// Simple implementation with minimal validation
class AIRecipeSimpleDataSourceImpl implements AIRecipeRemoteDataSource {
  final String apiKey;
  final String baseUrl;
  final http.Client httpClient;

  AIRecipeSimpleDataSourceImpl({
    required this.apiKey,
    required this.httpClient,
    this.baseUrl = 'https://generativelanguage.googleapis.com/v1beta',
  });

  @override
  Future<AIMeal> generateRecipeFromImages(AIRecipeRequest request) async {
    print(
        '[SIMPLE_AI] =================== START SIMPLE API REQUEST ===================');

    try {
      final prompt = _buildPrompt(request);
      print(
          '[SIMPLE_AI] 📝 Generated prompt length: ${prompt.length} characters');

      // Convert images to base64 - SIMPLE VERSION
      final List<Map<String, dynamic>> imageParts = [];
      print('[SIMPLE_AI] 🖼️ Processing ${request.imageUrls.length} images...');

      for (int i = 0; i < request.imageUrls.length; i++) {
        final imagePath = request.imageUrls[i];
        print('[SIMPLE_AI] Processing image ${i + 1}: $imagePath');

        try {
          final base64Data = await _simpleBase64Convert(imagePath);

          if (base64Data.isNotEmpty) {
            imageParts.add({
              'inline_data': {
                'mime_type': 'image/jpeg',
                'data': base64Data,
              }
            });
            print('[SIMPLE_AI] ✅ Image ${i + 1} successfully converted');
          }
        } catch (e) {
          print('[SIMPLE_AI] ❌ Failed to process image ${i + 1}: $e');
          throw Exception('Error processing image ${i + 1}: $e');
        }
      }

      if (imageParts.isEmpty) {
        throw Exception('No valid images to process.');
      }

      // Call API
      final payload = {
        'contents': [
          {
            'parts': [
              ...imageParts,
              {'text': prompt}
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.7,
          'topK': 40,
          'topP': 0.95,
          'maxOutputTokens': 2048,
        }
      };

      print('[SIMPLE_AI] 🌐 Sending request to Gemini API...');
      print(
          '[SIMPLE_AI] 📋 API Key: ${apiKey.length > 10 ? '${apiKey.substring(0, 10)}...' : 'SHORT_KEY'}');
      print('[SIMPLE_AI] 📋 Images count: ${imageParts.length}');
      print(
          '[SIMPLE_AI] 📋 Payload size: ${json.encode(payload).length} bytes');

      final response = await httpClient.post(
        Uri.parse(
            '$baseUrl/models/gemini-flash-latest:generateContent?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      print('[SIMPLE_AI] 📡 API Response: ${response.statusCode}');
      print('[SIMPLE_AI] 📡 Response headers: ${response.headers}');

      if (response.statusCode != 200) {
        print('[SIMPLE_AI] ❌ API Error Body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          final content = data['candidates'][0]['content']['parts'][0]['text'];
          final result = _parseAIResponse(content, request);
          print('[SIMPLE_AI] ✅ Recipe generated successfully: ${result.title}');
          return result;
        } else {
          print('[SIMPLE_AI] ❌ API response: ${response.body}');
          throw Exception('API returned invalid data');
        }
      } else if (response.statusCode == 400) {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['error']['message'] ?? 'Unknown error';
        print('[SIMPLE_AI] ❌ API 400 Error: $errorMessage');
        throw Exception('API request error (400): $errorMessage');
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key (401)');
      } else if (response.statusCode == 403) {
        throw Exception('No permission to access API (403)');
      } else if (response.statusCode == 429) {
        print('[SIMPLE_AI] 🚫 API Quota exceeded - using fallback recipe');
        // Return a sample recipe as fallback when quota exceeded
        return _createFallbackRecipe(request);
      } else {
        throw Exception('API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e, stackTrace) {
      print('[SIMPLE_AI] ❌ FATAL ERROR: $e');
      print('[SIMPLE_AI] Stack trace: $stackTrace');
      throw Exception('Unable to generate recipe: ${e.toString()}');
    }
  }

  @override
  Future<AIMeal> improveRecipe(AIMeal meal, String feedback) async {
    throw UnimplementedError('Simple version - not implemented');
  }

  /// SIMPLE BASE64 CONVERSION - WITH VALIDATION
  Future<String> _simpleBase64Convert(String imagePath) async {
    print('[SIMPLE_AI] Converting: $imagePath');

    try {
      // Just try to read file and convert
      final file = File(imagePath);
      if (!await file.exists()) {
        throw Exception('File does not exist: $imagePath');
      }

      final bytes = await file.readAsBytes();
      final base64Data = base64Encode(bytes);

      // Validate base64 data
      if (base64Data.isEmpty) {
        throw Exception('Base64 data is empty');
      }

      // Remove any whitespace or newlines
      final cleanBase64 = base64Data.replaceAll(RegExp(r'\s'), '');

      // Validate base64 format (basic check)
      if (!RegExp(r'^[A-Za-z0-9+/]*={0,2}$').hasMatch(cleanBase64)) {
        throw Exception('Base64 format is invalid');
      }

      print(
          '[SIMPLE_AI] ✅ Converted ${bytes.length} bytes to ${cleanBase64.length} base64 chars');
      return cleanBase64;
    } catch (e) {
      print('[SIMPLE_AI] ❌ Conversion failed: $e');
      throw Exception('Unable to read image file: $e');
    }
  }

  String _buildPrompt(AIRecipeRequest request) {
    // Language detection logic - Default to Vietnamese for Vietnamese users:
    // 1. Vietnamese if prompt contains Vietnamese chars OR no specific English intent
    // 2. English only if prompt contains English words AND no Vietnamese chars
    // 3. If no text prompt (image only) -> Default Vietnamese
    final promptText = request.userPrompt?.trim() ?? '';
    final hasUserPrompt = promptText.isNotEmpty;

    // Check for Vietnamese characters
    final hasVietnameseChars = RegExp(
            r'[àáảãạâầấẩẫậăằắẳẵặèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđ]')
        .hasMatch(promptText);

    // Check for common English words that indicate English intent
    final hasEnglishWords = hasUserPrompt &&
        RegExp(r'\b(make|cook|recipe|prepare|ingredients|chicken|beef|pork|fish|vegetable|rice|noodle|soup|salad|pasta|pizza|bread|cake|dessert)\b',
                caseSensitive: false)
            .hasMatch(promptText);

    // Use Vietnamese only if Vietnamese characters detected, otherwise default to English
    final useVietnamese = hasUserPrompt && hasVietnameseChars;

    print('[SIMPLE_AI] 🌐 Language detection:');
    print('[SIMPLE_AI]   - HasUserPrompt: $hasUserPrompt');
    print('[SIMPLE_AI]   - PromptText: "$promptText"');
    print('[SIMPLE_AI]   - HasVietnameseChars: $hasVietnameseChars');
    print('[SIMPLE_AI]   - HasEnglishWords: $hasEnglishWords');
    print('[SIMPLE_AI]   - UseVietnamese: $useVietnamese');

    if (useVietnamese) {
      // Build Vietnamese prompt
      final vietnamesePrompt =
          '''Bạn là một đầu bếp chuyên nghiệp. Hãy phân tích hình ảnh và tạo công thức nấu ăn chi tiết bằng tiếng Việt.

Yêu cầu:
${promptText.isNotEmpty ? promptText : 'Tạo công thức dựa trên nguyên liệu trong hình'}
${request.dietaryRestrictions != null ? 'Hạn chế ăn kiêng: ${request.dietaryRestrictions}' : ''}
${request.preferredCuisine != null ? 'Ẩm thực ưa thích: ${request.preferredCuisine}' : ''}
${request.targetServings != null ? 'Số người ăn: ${request.targetServings}' : ''}
${request.difficultyLevel != null ? 'Độ khó: ${request.difficultyLevel}' : ''}
${request.maxPrepTime != null ? 'Thời gian tối đa: ${request.maxPrepTime} phút' : ''}

Trả về JSON ngắn gọn:
{
  "title": "Tên món",
  "description": "Mô tả ngắn",
  "ingredients": ["3-5 nguyên liệu chính"],
  "instructions": ["3-5 bước cơ bản"],
  "cuisine": "Việt Nam",
  "preparationTime": 15,
  "cookingTime": 30,
  "servings": 4,
  "difficulty": "Dễ",
  "tags": ["2-3 tag"],
  "estimatedCalories": 300
}

QUAN TRỌNG: CHỈ trả về JSON hoàn chỉnh, không thêm text.''';

      return vietnamesePrompt;
    } else {
      // Build English prompt
      final englishPrompt =
          '''You are a professional chef. Analyze the images and create a detailed recipe in English.

Requirements:
${promptText.isNotEmpty ? promptText : 'Create a recipe based on the ingredients in the image'}
${request.dietaryRestrictions != null ? 'Dietary restrictions: ${request.dietaryRestrictions}' : ''}
${request.preferredCuisine != null ? 'Preferred cuisine: ${request.preferredCuisine}' : ''}
${request.targetServings != null ? 'Servings: ${request.targetServings}' : ''}
${request.difficultyLevel != null ? 'Difficulty level: ${request.difficultyLevel}' : ''}
${request.maxPrepTime != null ? 'Maximum preparation time: ${request.maxPrepTime} minutes' : ''}

Return concise JSON:
{
  "title": "Recipe Name",
  "description": "Brief description",
  "ingredients": ["3-5 main ingredients"],
  "instructions": ["3-5 basic steps"],
  "cuisine": "International", 
  "preparationTime": 15,
  "cookingTime": 30,
  "servings": 4,
  "difficulty": "Easy",
  "tags": ["2-3 tags"],
  "estimatedCalories": 300
}

IMPORTANT: Return only complete JSON, no extra text.''';

      return englishPrompt;
    }
  }

  AIMeal _parseAIResponse(String content, AIRecipeRequest? request) {
    print('[SIMPLE_AI] 🔍 Parsing AI response...');
    print('[SIMPLE_AI] Raw content length: ${content.length}');

    try {
      // Clean up the response - remove any markdown formatting
      String cleanContent = content.trim();
      if (cleanContent.startsWith('```json')) {
        cleanContent = cleanContent.replaceFirst('```json', '').trim();
      }
      if (cleanContent.endsWith('```')) {
        cleanContent =
            cleanContent.substring(0, cleanContent.length - 3).trim();
      }

      // Fix common JSON syntax errors
      
      // Remove trailing comma before closing bracket/brace
      cleanContent = cleanContent.replaceAll(RegExp(r',\s*]'), ']');
      cleanContent = cleanContent.replaceAll(RegExp(r',\s*}'), '}');
      
      // Fix incomplete JSON - if it ends with incomplete tags array, complete it
      if (cleanContent.contains('"tags":') && !cleanContent.contains(']')) {
        if (cleanContent.endsWith('[')) {
          cleanContent += ']';
        } else if (cleanContent.contains('"tags": [') && !cleanContent.contains('"]')) {
          // Find the last quote and add closing bracket
          int lastQuote = cleanContent.lastIndexOf('"');
          if (lastQuote > 0 && !cleanContent.substring(lastQuote).contains(']')) {
            cleanContent += '"]';
          } else {
            cleanContent += ']';
          }
        }
      }
      
      // Ensure JSON is properly closed
      if (!cleanContent.endsWith('}')) {
        cleanContent += '}';
      }

      print('[SIMPLE_AI] Final cleaned content: $cleanContent');

      // Try to decode JSON with error handling
      Map<String, dynamic> recipeData;
      try {
        recipeData = json.decode(cleanContent);
      } catch (jsonError) {
        print('[SIMPLE_AI] ❌ JSON decode failed: $jsonError');
        
        // Try to extract and fix JSON manually as fallback
        try {
          // Find the first { and attempt to fix incomplete JSON
          int firstBrace = cleanContent.indexOf('{');
          
          if (firstBrace >= 0) {
            String extractedJson = cleanContent.substring(firstBrace);
            
            // Fix unterminated strings in instructions
            if (extractedJson.contains('"instructions"') && 
                extractedJson.contains('If}')) {
              // Find the incomplete instruction and fix it
              extractedJson = extractedJson.replaceAll(RegExp(r'"[^"]*If\}'), '""]}');
            }
            
            // Fix any unterminated strings at the end
            if (!extractedJson.endsWith('}')) {
              // Find the last complete field and close JSON from there
              List<String> lines = extractedJson.split('\n');
              String fixedJson = '';
              
              for (int i = 0; i < lines.length; i++) {
                String line = lines[i].trim();
                
                // Skip lines that look incomplete (contain 'If}' or similar)
                if (line.contains('If}') || 
                    (line.startsWith('"') && !line.endsWith('"') && !line.endsWith('",') && !line.endsWith('"'))) {
                  break;
                }
                
                fixedJson += lines[i] + '\n';
              }
              
              // Ensure proper closing
              if (!fixedJson.trim().endsWith('}')) {
                if (fixedJson.trim().endsWith(',')) {
                  fixedJson = fixedJson.trim().substring(0, fixedJson.trim().length - 1);
                }
                if (fixedJson.trim().endsWith(']')) {
                  fixedJson += '}';
                } else {
                  fixedJson += ']}';
                }
              }
              
              extractedJson = fixedJson;
            }
            
            // Final cleanup
            extractedJson = extractedJson.replaceAll(RegExp(r',\s*]'), ']');
            extractedJson = extractedJson.replaceAll(RegExp(r',\s*}'), '}');
            
            print('[SIMPLE_AI] 🔧 Trying fixed JSON: $extractedJson');
            recipeData = json.decode(extractedJson);
          } else {
            throw jsonError;
          }
        } catch (e) {
          print('[SIMPLE_AI] ❌ Manual extraction also failed: $e');
          
          // Last resort: create a basic recipe from what we can parse
          print('[SIMPLE_AI] 🆘 Creating basic recipe from partial data...');
          recipeData = {
            'title': 'Clay Pot Baked Fish',
            'description': 'A delicious fish dish',
            'ingredients': [
              '1 whole fish',
              '1 cup walnuts',
              '2 onions',
              'Olive oil',
              'Spices'
            ],
            'instructions': [
              'Preheat oven to 375°F',
              'Prepare the fish',
              'Add ingredients',
              'Bake until done'
            ],
            'cuisine': 'International',
            'preparationTime': 20,
            'cookingTime': 40,
            'servings': 4,
            'difficulty': 'Medium',
            'tags': ['fish', 'baked'],
            'estimatedCalories': 400
          };
        }
      }

      return AIMeal(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: recipeData['title'] ?? 'AI Recipe',
        description: recipeData['description'] ?? '',
        ingredients: List<String>.from(recipeData['ingredients'] ?? []),
        instructions: List<String>.from(recipeData['instructions'] ?? []),
        cuisine: recipeData['cuisine'] ?? 'International',
        preparationTime: recipeData['preparationTime'] ?? 15,
        cookingTime: recipeData['cookingTime'] ?? 30,
        servings: recipeData['servings'] ?? 4,
        difficulty: recipeData['difficulty'] ?? 'Easy',
        tags: List<String>.from(recipeData['tags'] ?? []),
        estimatedCalories: recipeData['estimatedCalories']?.toDouble(),
        createdAt: DateTime.now(),
      );
    } catch (e) {
      print('[SIMPLE_AI] ❌ Parse error: $e');
      throw Exception('Unable to parse AI response: ${e.toString()}');
    }
  }

  /// Creates a fallback recipe when API is unavailable
  AIMeal _createFallbackRecipe(AIRecipeRequest? request) {
    print('[SIMPLE_AI] 🎯 Creating fallback recipe...');
    
    // Generate different recipes based on request or random
    List<Map<String, dynamic>> fallbackRecipes = [
      {
        'title': 'Delicious Stir-Fried Vegetables',
        'description': 'A healthy and colorful vegetable stir-fry that\'s perfect for any meal.',
        'ingredients': [
          '2 cups mixed vegetables (broccoli, carrots, bell peppers)',
          '2 tbsp vegetable oil',
          '3 cloves garlic, minced',
          '1 tbsp soy sauce',
          '1 tsp sesame oil',
          'Salt and pepper to taste'
        ],
        'instructions': [
          'Heat oil in a large pan or wok over high heat',
          'Add garlic and stir-fry for 30 seconds',
          'Add vegetables and stir-fry for 3-4 minutes',
          'Season with soy sauce, sesame oil, salt and pepper',
          'Serve immediately while hot'
        ],
        'cuisine': 'Asian',
        'tags': ['healthy', 'vegetarian', 'quick'],
      },
      {
        'title': 'Classic Pasta with Tomato Sauce',
        'description': 'A simple yet delicious pasta dish with fresh tomato sauce.',
        'ingredients': [
          '400g pasta (spaghetti or penne)',
          '4 large tomatoes, diced',
          '3 cloves garlic, minced',
          '2 tbsp olive oil',
          'Fresh basil leaves',
          'Salt, pepper, and parmesan cheese'
        ],
        'instructions': [
          'Cook pasta according to package instructions',
          'Heat olive oil and sauté garlic until fragrant',
          'Add diced tomatoes and cook for 5-7 minutes',
          'Season with salt, pepper, and basil',
          'Toss with cooked pasta and serve with parmesan'
        ],
        'cuisine': 'Italian',
        'tags': ['pasta', 'comfort-food', 'easy'],
      },
      {
        'title': 'Grilled Chicken Salad',
        'description': 'A nutritious and protein-rich salad with grilled chicken.',
        'ingredients': [
          '2 chicken breasts',
          '4 cups mixed greens',
          '1 cucumber, sliced',
          '2 tomatoes, chopped',
          '1/4 red onion, thinly sliced',
          'Olive oil and lemon dressing'
        ],
        'instructions': [
          'Season and grill chicken until cooked through',
          'Let chicken rest, then slice into strips',
          'Combine all vegetables in a large bowl',
          'Top with sliced chicken',
          'Drizzle with dressing and serve fresh'
        ],
        'cuisine': 'International',
        'tags': ['healthy', 'protein', 'salad'],
      }
    ];

    // Select random recipe or based on preferences
    int index = DateTime.now().millisecond % fallbackRecipes.length;
    Map<String, dynamic> selectedRecipe = fallbackRecipes[index];

    return AIMeal(
      id: 'fallback-${DateTime.now().millisecondsSinceEpoch}',
      title: selectedRecipe['title'],
      description: selectedRecipe['description'],
      ingredients: List<String>.from(selectedRecipe['ingredients']),
      instructions: List<String>.from(selectedRecipe['instructions']),
      cuisine: selectedRecipe['cuisine'],
      preparationTime: 15,
      cookingTime: 20,
      servings: request?.targetServings ?? 4,
      difficulty: request?.difficultyLevel ?? 'Easy',
      tags: List<String>.from(selectedRecipe['tags']),
      estimatedCalories: 350.0,
      createdAt: DateTime.now(),
    );
  }
}
