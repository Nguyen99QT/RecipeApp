import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../domain/entities/ai_meal.dart';
import '../../domain/entities/ai_recipe_request.dart';
import 'ai_recipe_remote_datasource.dart';

class AIRecipeRemoteDataSourceImpl implements AIRecipeRemoteDataSource {
  final String apiKey;
  final String baseUrl;
  final http.Client httpClient;

  AIRecipeRemoteDataSourceImpl({
    required this.apiKey,
    required this.httpClient,
    this.baseUrl = 'https://generativelanguage.googleapis.com/v1beta',
  });

  @override
  Future<AIMeal> generateRecipeFromImages(AIRecipeRequest request) async {
    print(
        '[AI_REMOTE_DATASOURCE] =================== START API REQUEST ===================');
    print('[AI_REMOTE_DATASOURCE] Request details:');
    print(
        '[AI_REMOTE_DATASOURCE] - Preferred cuisine: ${request.preferredCuisine}');
    print(
        '[AI_REMOTE_DATASOURCE] - Dietary restrictions: ${request.dietaryRestrictions}');
    print(
        '[AI_REMOTE_DATASOURCE] - Difficulty level: ${request.difficultyLevel}');
    print(
        '[AI_REMOTE_DATASOURCE] - Target servings: ${request.targetServings}');
    print('[AI_REMOTE_DATASOURCE] - Max prep time: ${request.maxPrepTime}');
    print('[AI_REMOTE_DATASOURCE] - User prompt: ${request.userPrompt}');
    print(
        '[AI_REMOTE_DATASOURCE] - Number of images: ${request.imageUrls.length}');
    print('[AI_REMOTE_DATASOURCE] - Images: ${request.imageUrls}');

    try {
      final prompt = _buildPrompt(request);
      print(
          '[AI_REMOTE_DATASOURCE] 📝 Generated prompt length: ${prompt.length} characters');

      // Convert images to base64
      final List<Map<String, dynamic>> imageParts = [];
      print(
          '[AI_REMOTE_DATASOURCE] 🖼️ Processing ${request.imageUrls.length} images...');

      for (int i = 0; i < request.imageUrls.length; i++) {
        final imagePath = request.imageUrls[i];
        print(
            '[AI_REMOTE_DATASOURCE] Processing image ${i + 1}/${request.imageUrls.length}: $imagePath');

        try {
          final base64Data = await _getBase64FromImagePath(imagePath);

          if (base64Data.isNotEmpty) {
            print(
                '[AI_REMOTE_DATASOURCE] 🔍 Validating converted base64 data...');

            // Simple validation: just check if we can decode the base64
            print('[AI_REMOTE_DATASOURCE] 🔍 Validating base64 data...');

            try {
              final decodedBytes = base64Decode(base64Data);
              print(
                  '[AI_REMOTE_DATASOURCE] ✅ Base64 validation passed. Decoded ${decodedBytes.length} bytes');
            } catch (e) {
              print(
                  '[AI_REMOTE_DATASOURCE] ❌ CRITICAL ERROR: Base64 decode validation failed: $e');
              throw Exception('Dữ liệu hình ảnh không hợp lệ: $e');
            }

            imageParts.add({
              'inline_data': {
                'mime_type': 'image/jpeg',
                'data': base64Data,
              }
            });
            print(
                '[AI_REMOTE_DATASOURCE] ✅ Image ${i + 1} successfully added to request');
          } else {
            print(
                '[AI_REMOTE_DATASOURCE] ⚠️ Skipping empty base64 data for image ${i + 1}: $imagePath');
          }
        } catch (e) {
          print(
              '[AI_REMOTE_DATASOURCE] ❌ Failed to process image ${i + 1}: $e');
          throw Exception('Lỗi xử lý hình ảnh ${i + 1}: $e');
        }
      }

      if (imageParts.isEmpty) {
        print(
            '[AI_REMOTE_DATASOURCE] ❌ CRITICAL ERROR: No valid images processed');
        throw Exception(
            'Không có hình ảnh hợp lệ để xử lý. Vui lòng kiểm tra lại hình ảnh.');
      }

      print(
          '[AI_REMOTE_DATASOURCE] 📤 Preparing API request with ${imageParts.length} images');
      print(
          '[AI_REMOTE_DATASOURCE] 📤 Prompt preview: ${prompt.length > 200 ? '${prompt.substring(0, 200)}...' : prompt}');

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

      print('[AI_REMOTE_DATASOURCE] 🌐 Sending request to Gemini API...');
      print(
          '[AI_REMOTE_DATASOURCE] API URL: $baseUrl/models/gemini-1.5-flash:generateContent');
      print(
          '[AI_REMOTE_DATASOURCE] Payload size: ${json.encode(payload).length} characters');

      final response = await httpClient.post(
        Uri.parse(
            '$baseUrl/models/gemini-1.5-flash:generateContent?key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      print(
          '[AI_REMOTE_DATASOURCE] 📡 API Response received: ${response.statusCode}');
      print(
          '[AI_REMOTE_DATASOURCE] Response length: ${response.body.length} characters');

      if (response.statusCode == 200) {
        print('[AI_REMOTE_DATASOURCE] ✅ API Success! Parsing response...');
        final data = json.decode(response.body);
        print(
            '[AI_REMOTE_DATASOURCE] Response structure: ${data.keys.toList()}');

        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          final content = data['candidates'][0]['content']['parts'][0]['text'];
          print(
              '[AI_REMOTE_DATASOURCE] Content length: ${content.length} characters');
          print(
              '[AI_REMOTE_DATASOURCE] Content preview: ${content.length > 300 ? content.substring(0, 300) + '...' : content}');

          final result = _parseAIResponse(content, request);
          print(
              '[AI_REMOTE_DATASOURCE] ✅ Recipe parsed successfully: ${result.title}');
          print(
              '[AI_REMOTE_DATASOURCE] =================== END API REQUEST SUCCESS ===================');
          return result;
        } else {
          print(
              '[AI_REMOTE_DATASOURCE] ❌ CRITICAL ERROR: No candidates in response');
          throw Exception('API trả về dữ liệu không hợp lệ');
        }
      } else {
        print('[AI_REMOTE_DATASOURCE] ❌ API ERROR ${response.statusCode}');
        print('[AI_REMOTE_DATASOURCE] Error body: ${response.body}');
        print(
            '[AI_REMOTE_DATASOURCE] =================== END API REQUEST FAILED ===================');
        throw Exception('Lỗi API: ${response.statusCode} - ${response.body}');
      }
    } catch (e, stackTrace) {
      print(
          '[AI_REMOTE_DATASOURCE] ❌ FATAL ERROR in generateRecipeFromImages: $e');
      print('[AI_REMOTE_DATASOURCE] Stack trace: $stackTrace');
      print(
          '[AI_REMOTE_DATASOURCE] =================== END API REQUEST FAILED ===================');
      throw Exception('Không thể tạo công thức: ${e.toString()}');
    }
  }

  @override
  Future<AIMeal> improveRecipe(AIMeal meal, String feedback) async {
    try {
      final prompt = '''
Cải thiện công thức nấu ăn sau dựa trên phản hồi của người dùng:

CÔNG THỨC HIỆN TẠI:
Tên: ${meal.title}
Mô tả: ${meal.description}
Nguyên liệu: ${meal.ingredients.join(', ')}
Hướng dẫn: ${meal.instructions.join(' ')}
Thời gian chuẩn bị: ${meal.preparationTime} phút
Thời gian nấu: ${meal.cookingTime} phút

PHẢN HỒI CỦA NGƯỜI DÙNG:
$feedback

Hãy cải thiện công thức dựa trên phản hồi và trả về kết quả theo định dạng JSON như mẫu:
{
  "title": "Tên công thức đã cải thiện",
  "description": "Mô tả chi tiết",
  "ingredients": ["nguyên liệu 1", "nguyên liệu 2"],
  "instructions": ["bước 1", "bước 2"],
  "cuisine": "Việt Nam",
  "preparationTime": 15,
  "cookingTime": 30,
  "servings": 4,
  "difficulty": "Dễ",
  "tags": ["tag1", "tag2"],
  "estimatedCalories": 300
}
''';

      final payload = {
        'contents': [
          {
            'parts': [
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

      final response = await httpClient.post(
        Uri.parse(
            '$baseUrl/models/gemini-1.5-flash:generateContent?key=$apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final content = data['candidates'][0]['content']['parts'][0]['text'];
        return _parseAIResponse(content, null);
      } else {
        throw Exception(
            'Lỗi API khi cải thiện công thức: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Không thể cải thiện công thức: ${e.toString()}');
    }
  }

  String _buildPrompt(AIRecipeRequest request) {
    final basePrompt = '''
Bạn là một đầu bếp chuyên nghiệp và chuyên gia AI phân tích hình ảnh. Hãy phân tích những hình ảnh tôi gửi và tạo ra một công thức nấu ăn chi tiết bằng tiếng Việt.

Yêu cầu cụ thể:
${request.userPrompt ?? 'Tạo công thức dựa trên nguyên liệu trong hình'}
${request.dietaryRestrictions != null ? 'Hạn chế ăn kiêng: ${request.dietaryRestrictions}' : ''}
${request.preferredCuisine != null ? 'Ẩm thực ưa thích: ${request.preferredCuisine}' : ''}
${request.targetServings != null ? 'Số người ăn: ${request.targetServings}' : ''}
${request.difficultyLevel != null ? 'Độ khó: ${request.difficultyLevel}' : ''}
${request.maxPrepTime != null ? 'Thời gian tối đa: ${request.maxPrepTime} phút' : ''}
${request.availableIngredients != null ? 'Nguyên liệu có sẵn: ${request.availableIngredients!.join(', ')}' : ''}
${request.allergies != null ? 'Dị ứng: ${request.allergies!.join(', ')}' : ''}

Hãy trả về kết quả theo định dạng JSON chính xác như sau:
{
  "title": "Tên món ăn tiếng Việt",
  "description": "Mô tả ngắn gọn về món ăn",
  "ingredients": ["nguyên liệu 1 với đơn vị", "nguyên liệu 2 với đơn vị"],
  "instructions": ["Bước 1: chi tiết", "Bước 2: chi tiết"],
  "cuisine": "Tên ẩm thực (VD: Việt Nam, Châu Âu)",
  "preparationTime": 15,
  "cookingTime": 30,
  "servings": 4,
  "difficulty": "Dễ/Trung bình/Khó",
  "tags": ["tag1", "tag2"],
  "estimatedCalories": 300
}

CHÚ Ý: Chỉ trả về JSON, không thêm bất kỳ text nào khác.
''';

    return basePrompt;
  }

  Future<String> _getBase64FromImagePath(String imagePath) async {
    print(
        '[AI_REMOTE_DATASOURCE] =================== START BASE64 CONVERSION ===================');
    print('[AI_REMOTE_DATASOURCE] Input imagePath: "$imagePath"');
    print('[AI_REMOTE_DATASOURCE] Input type: ${imagePath.runtimeType}');
    print('[AI_REMOTE_DATASOURCE] Input length: ${imagePath.length}');

    try {
      // Step 1: Validate input
      if (imagePath.trim().isEmpty) {
        print(
            '[AI_REMOTE_DATASOURCE] ❌ CRITICAL ERROR: Empty or whitespace-only image path');
        throw Exception('Image path is empty');
      }

      final String cleanPath = imagePath.trim();
      print('[AI_REMOTE_DATASOURCE] Clean path: "$cleanPath"');

      // Step 2: Check if it's already base64 data URL
      if (cleanPath.contains('data:image')) {
        print('[AI_REMOTE_DATASOURCE] 🔍 Detected data URL format');
        final parts = cleanPath.split(',');
        if (parts.length < 2) {
          print(
              '[AI_REMOTE_DATASOURCE] ❌ Invalid data URL format - missing comma separator');
          throw Exception('Invalid data URL format');
        }

        final base64Data = parts.last;
        print(
            '[AI_REMOTE_DATASOURCE] Extracted base64 part length: ${base64Data.length}');

        // Validate base64
        if (_isValidBase64(base64Data)) {
          print('[AI_REMOTE_DATASOURCE] ✅ Valid base64 data found in data URL');
          return base64Data;
        } else {
          print('[AI_REMOTE_DATASOURCE] ❌ Invalid base64 data in data URL');
          throw Exception('Invalid base64 data in data URL');
        }
      }

      // Step 3: Check if it's already pure base64
      print('[AI_REMOTE_DATASOURCE] 🔍 Checking if input is pure base64...');

      // First try with strict validation
      if (_isValidBase64(cleanPath)) {
        print(
            '[AI_REMOTE_DATASOURCE] ✅ Valid pure base64 format confirmed (strict)');
        return cleanPath;
      }

      // Fallback: try less strict validation for base64
      print('[AI_REMOTE_DATASOURCE] Trying fallback base64 validation...');
      if (cleanPath.length > 1000 &&
          !cleanPath.contains('\\') &&
          !cleanPath.contains('C:') &&
          !cleanPath.contains('D:') &&
          !cleanPath.contains('.jpg') &&
          !cleanPath.contains('.png')) {
        try {
          final testDecode = base64Decode(cleanPath);
          if (testDecode.length > 1000) {
            print(
                '[AI_REMOTE_DATASOURCE] ✅ Valid pure base64 format confirmed (fallback)');
            return cleanPath;
          }
        } catch (e) {
          print('[AI_REMOTE_DATASOURCE] Fallback base64 decode failed: $e');
        }
      }

      // Step 4: Handle HTTP URLs
      if (cleanPath.startsWith('http://') || cleanPath.startsWith('https://')) {
        print('[AI_REMOTE_DATASOURCE] 🌐 Downloading from URL: $cleanPath');
        try {
          final response = await httpClient.get(Uri.parse(cleanPath));

          if (response.statusCode == 200) {
            print(
                '[AI_REMOTE_DATASOURCE] URL downloaded successfully. Bytes length: ${response.bodyBytes.length}');

            if (response.bodyBytes.isEmpty) {
              print('[AI_REMOTE_DATASOURCE] ❌ Downloaded file is empty');
              throw Exception('Downloaded image is empty');
            }

            // Validate image format
            if (!_isValidImageFormat(response.bodyBytes)) {
              print(
                  '[AI_REMOTE_DATASOURCE] ❌ Downloaded file is not a valid image');
              throw Exception('Downloaded file is not a valid image');
            }

            final base64Data = base64Encode(response.bodyBytes);
            print(
                '[AI_REMOTE_DATASOURCE] ✅ URL downloaded and converted, size: ${response.bodyBytes.length} bytes');
            return base64Data;
          } else {
            print(
                '[AI_REMOTE_DATASOURCE] ❌ Failed to download URL: ${response.statusCode}');
            throw Exception(
                'Failed to download image from URL: ${response.statusCode}');
          }
        } catch (e) {
          print('[AI_REMOTE_DATASOURCE] ❌ URL download error: $e');
          throw Exception('Error downloading image from URL: $e');
        }
      }

      // Step 5: Handle file paths - try multiple approaches
      print('[AI_REMOTE_DATASOURCE] 🔍 Treating as file path');

      // Try different path formats
      final List<String> pathsToTry = [
        cleanPath,
        cleanPath.startsWith('file://') ? cleanPath.substring(7) : cleanPath,
        cleanPath.replaceAll('\\', '/'),
        cleanPath.replaceAll('/', '\\'),
      ];

      // Remove duplicates
      final uniquePaths = pathsToTry.toSet().toList();
      print(
          '[AI_REMOTE_DATASOURCE] Trying ${uniquePaths.length} path variations');

      for (int i = 0; i < uniquePaths.length; i++) {
        final pathToTry = uniquePaths[i];
        print('[AI_REMOTE_DATASOURCE] Attempt ${i + 1}: "$pathToTry"');

        try {
          final file = File(pathToTry);
          print('[AI_REMOTE_DATASOURCE] File object created for: ${file.path}');
          print('[AI_REMOTE_DATASOURCE] Absolute path: ${file.absolute.path}');

          final exists = await file.exists();
          print('[AI_REMOTE_DATASOURCE] File exists check: $exists');

          if (exists) {
            print('[AI_REMOTE_DATASOURCE] 📁 Reading file bytes...');
            final bytes = await file.readAsBytes();
            print(
                '[AI_REMOTE_DATASOURCE] File read successfully. Bytes length: ${bytes.length}');

            if (bytes.isEmpty) {
              print('[AI_REMOTE_DATASOURCE] ❌ File is empty, trying next path');
              continue;
            }

            // Check file size (max 10MB)
            const maxSize = 10 * 1024 * 1024;
            if (bytes.length > maxSize) {
              print(
                  '[AI_REMOTE_DATASOURCE] ❌ File too large: ${bytes.length} bytes');
              throw Exception('Image file too large (max 10MB)');
            }

            // Validate image format
            if (!_isValidImageFormat(bytes)) {
              print(
                  '[AI_REMOTE_DATASOURCE] ❌ Invalid image format, first 20 bytes: ${bytes.take(20).map((b) => b.toRadixString(16).padLeft(2, '0')).join(' ')}');
              continue; // Try next path variation
            }

            print('[AI_REMOTE_DATASOURCE] 🔄 Converting bytes to base64...');
            final base64Data = base64Encode(bytes);
            print(
                '[AI_REMOTE_DATASOURCE] ✅ File converted to base64, size: ${bytes.length} bytes, base64 length: ${base64Data.length}');
            print(
                '[AI_REMOTE_DATASOURCE] =================== END BASE64 CONVERSION SUCCESS ===================');
            return base64Data;
          } else {
            print(
                '[AI_REMOTE_DATASOURCE] File does not exist at: "$pathToTry"');
          }
        } catch (e) {
          print('[AI_REMOTE_DATASOURCE] Error with path "$pathToTry": $e');
          continue; // Try next path
        }
      }

      // Step 6: If all file path attempts failed
      print(
          '[AI_REMOTE_DATASOURCE] ❌ CRITICAL ERROR: Could not process image path with any method');
      print('[AI_REMOTE_DATASOURCE] Original path: "$imagePath"');
      print(
          '[AI_REMOTE_DATASOURCE] Tried ${uniquePaths.length} path variations');
      print(
          '[AI_REMOTE_DATASOURCE] =================== FAILED BASE64 CONVERSION ===================');
      throw Exception(
          'Không thể đọc file hình ảnh. Vui lòng thử chọn hình ảnh khác.');
    } catch (e, stackTrace) {
      print('[AI_REMOTE_DATASOURCE] ❌ FATAL ERROR in base64 conversion: $e');
      print('[AI_REMOTE_DATASOURCE] Stack trace: $stackTrace');
      print(
          '[AI_REMOTE_DATASOURCE] =================== FAILED BASE64 CONVERSION ===================');

      // Re-throw with more user-friendly message
      if (e.toString().contains('Permission denied') ||
          e.toString().contains('Access denied')) {
        throw Exception(
            'Không có quyền truy cập file hình ảnh. Vui lòng kiểm tra quyền ứng dụng.');
      } else if (e.toString().contains('No such file') ||
          e.toString().contains('does not exist')) {
        throw Exception(
            'File hình ảnh không tồn tại. Vui lòng chọn hình ảnh khác.');
      } else if (e.toString().contains('Invalid image format')) {
        throw Exception(
            'Định dạng hình ảnh không được hỗ trợ. Vui lòng chọn file JPG hoặc PNG.');
      } else {
        throw Exception('Lỗi xử lý hình ảnh: ${e.toString()}');
      }
    }
  }

  AIMeal _parseAIResponse(String content, AIRecipeRequest? request) {
    try {
      // Tìm JSON trong response
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

  // Helper method to validate base64 string
  bool _isValidBase64(String str) {
    try {
      // Remove whitespace
      final cleanStr = str.replaceAll(RegExp(r'\s+'), '');
      if (cleanStr.isEmpty) {
        return false;
      }

      // Should not contain obvious file path indicators
      if (cleanStr.contains('C:\\') ||
          cleanStr.contains('D:\\') ||
          cleanStr.contains('/data/user/') ||
          cleanStr.contains('/storage/emulated/') ||
          cleanStr.contains('file://') ||
          cleanStr.contains('.jpg') ||
          cleanStr.contains('.png') ||
          cleanStr.contains('.jpeg') ||
          cleanStr.contains('cache/')) {
        return false;
      }

      // Simply try to decode it - if it works, it's valid base64
      final decoded = base64Decode(cleanStr);

      // Just check if it's not empty
      return decoded.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Helper method to validate image format by checking magic bytes
  bool _isValidImageFormat(List<int> bytes) {
    if (bytes.length < 3) return false;

    // Check for JPEG signature (FF D8 FF)
    if (bytes[0] == 0xFF && bytes[1] == 0xD8 && bytes[2] == 0xFF) {
      return true;
    }

    // Check for PNG signature (89 50 4E 47)
    if (bytes.length >= 4 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47) {
      return true;
    }

    // Check for GIF signature (47 49 46)
    if (bytes.length >= 3 &&
        bytes[0] == 0x47 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46) {
      return true;
    }

    // Check for WebP signature (52 49 46 46)
    if (bytes.length >= 4 &&
        bytes[0] == 0x52 &&
        bytes[1] == 0x49 &&
        bytes[2] == 0x46 &&
        bytes[3] == 0x46) {
      return true;
    }

    // If none of the above match, but it's a reasonable size, assume it's valid
    // This is a fallback for cases where the image format checking is too strict
    return bytes.length > 1000;
  }
}
