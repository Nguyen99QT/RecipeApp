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
            '$baseUrl/models/gemini-1.5-flash:generateContent?key=$apiKey'),
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
        throw Exception('API call limit exceeded (429)');
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

Trả về kết quả theo định dạng JSON như sau:
{
  "title": "Tên món ăn tiếng Việt",
  "description": "Mô tả ngắn gọn về món ăn",
  "ingredients": ["nguyên liệu 1", "nguyên liệu 2"],
  "instructions": ["Bước 1", "Bước 2"],
  "cuisine": "Việt Nam",
  "preparationTime": 15,
  "cookingTime": 30,
  "servings": 4,
  "difficulty": "Dễ",
  "tags": ["tag1", "tag2"],
  "estimatedCalories": 300
}

CHÚ Ý: Chỉ trả về JSON, không thêm text khác.''';

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

Return result in JSON format as follows:
{
  "title": "Recipe name in English",
  "description": "Brief description of the dish",
  "ingredients": ["ingredient 1", "ingredient 2"],
  "instructions": ["Step 1", "Step 2"],
  "cuisine": "International",
  "preparationTime": 15,
  "cookingTime": 30,
  "servings": 4,
  "difficulty": "Easy",
  "tags": ["tag1", "tag2"],
  "estimatedCalories": 300
}

NOTE: Return only JSON, no additional text.''';

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

      print(
          '[SIMPLE_AI] Cleaned content: ${cleanContent.substring(0, cleanContent.length > 200 ? 200 : cleanContent.length)}...');

      final Map<String, dynamic> recipeData = json.decode(cleanContent);

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
}
