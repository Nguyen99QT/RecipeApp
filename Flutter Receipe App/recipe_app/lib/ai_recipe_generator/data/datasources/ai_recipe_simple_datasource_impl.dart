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
          throw Exception('Lỗi xử lý hình ảnh ${i + 1}: $e');
        }
      }

      if (imageParts.isEmpty) {
        throw Exception('Không có hình ảnh hợp lệ để xử lý.');
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
          throw Exception('API trả về dữ liệu không hợp lệ');
        }
      } else if (response.statusCode == 400) {
        final errorData = json.decode(response.body);
        final errorMessage = errorData['error']['message'] ?? 'Unknown error';
        print('[SIMPLE_AI] ❌ API 400 Error: $errorMessage');
        throw Exception('Lỗi yêu cầu API (400): $errorMessage');
      } else if (response.statusCode == 401) {
        throw Exception('API key không hợp lệ (401)');
      } else if (response.statusCode == 403) {
        throw Exception('Không có quyền truy cập API (403)');
      } else if (response.statusCode == 429) {
        throw Exception('Quá giới hạn số lần gọi API (429)');
      } else {
        throw Exception('Lỗi API: ${response.statusCode} - ${response.body}');
      }
    } catch (e, stackTrace) {
      print('[SIMPLE_AI] ❌ FATAL ERROR: $e');
      print('[SIMPLE_AI] Stack trace: $stackTrace');
      throw Exception('Không thể tạo công thức: ${e.toString()}');
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
        throw Exception('File không tồn tại: $imagePath');
      }

      final bytes = await file.readAsBytes();
      final base64Data = base64Encode(bytes);

      // Validate base64 data
      if (base64Data.isEmpty) {
        throw Exception('Base64 data rỗng');
      }

      // Remove any whitespace or newlines
      final cleanBase64 = base64Data.replaceAll(RegExp(r'\s'), '');

      // Validate base64 format (basic check)
      if (!RegExp(r'^[A-Za-z0-9+/]*={0,2}$').hasMatch(cleanBase64)) {
        throw Exception('Base64 format không hợp lệ');
      }

      print(
          '[SIMPLE_AI] ✅ Converted ${bytes.length} bytes to ${cleanBase64.length} base64 chars');
      return cleanBase64;
    } catch (e) {
      print('[SIMPLE_AI] ❌ Conversion failed: $e');
      throw Exception('Không thể đọc file hình ảnh: $e');
    }
  }

  String _buildPrompt(AIRecipeRequest request) {
    return '''
Bạn là một đầu bếp chuyên nghiệp. Hãy phân tích hình ảnh và tạo công thức nấu ăn chi tiết bằng tiếng Việt.

Yêu cầu:
${request.userPrompt ?? 'Tạo công thức dựa trên nguyên liệu trong hình'}
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

CHÚ Ý: Chỉ trả về JSON, không thêm text khác.
''';
  }

  AIMeal _parseAIResponse(String content, AIRecipeRequest? request) {
    try {
      final jsonStart = content.indexOf('{');
      final jsonEnd = content.lastIndexOf('}') + 1;

      if (jsonStart == -1 || jsonEnd <= jsonStart) {
        throw Exception('Không tìm thấy JSON trong response');
      }

      final jsonString = content.substring(jsonStart, jsonEnd);
      final Map<String, dynamic> recipeData = json.decode(jsonString);

      return AIMeal(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: recipeData['title'] ?? 'Món ăn AI',
        description: recipeData['description'] ?? '',
        ingredients: List<String>.from(recipeData['ingredients'] ?? []),
        instructions: List<String>.from(recipeData['instructions'] ?? []),
        cuisine: recipeData['cuisine'] ?? 'Việt Nam',
        preparationTime: recipeData['preparationTime'] ?? 15,
        cookingTime: recipeData['cookingTime'] ?? 30,
        servings: recipeData['servings'] ?? 4,
        difficulty: recipeData['difficulty'] ?? 'Dễ',
        tags: List<String>.from(recipeData['tags'] ?? []),
        estimatedCalories: recipeData['estimatedCalories']?.toDouble(),
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Không thể phân tích response từ AI: ${e.toString()}');
    }
  }
}
