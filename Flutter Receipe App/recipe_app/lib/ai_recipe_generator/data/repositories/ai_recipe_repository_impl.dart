import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/ai_meal.dart';
import '../../domain/entities/ai_recipe_request.dart';
import '../../domain/repositories/ai_recipe_repository.dart';
import '../datasources/ai_recipe_remote_datasource.dart';
import '../datasources/ai_recipe_local_datasource.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AIRecipeRepositoryImpl implements AIRecipeRepository {
  final AIRecipeRemoteDataSource remoteDataSource;
  final AIRecipeLocalDataSource localDataSource;

  AIRecipeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AIMeal> generateRecipeFromImages(AIRecipeRequest request) async {
    try {
      return await remoteDataSource.generateRecipeFromImages(request);
    } catch (e) {
      throw Exception('Không thể tạo công thức từ AI: ${e.toString()}');
    }
  }

  @override
  Future<void> saveAIRecipe(AIMeal meal) async {
    try {
      await localDataSource.saveAIRecipe(meal);
    } catch (e) {
      throw Exception('Không thể lưu công thức: ${e.toString()}');
    }
  }

  @override
  Future<List<AIMeal>> getSavedAIRecipes() async {
    try {
      return await localDataSource.getSavedAIRecipes();
    } catch (e) {
      throw Exception('Không thể tải danh sách công thức: ${e.toString()}');
    }
  }

  @override
  Future<List<AIMeal>> getSavedAIRecipesFromBackend(String userId) async {
    try {
      print('🔍 Loading recipes from backend for userId: $userId');
      
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/flutter-saved-ai-recipes'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId}),
      );

      print('📊 Backend response status: ${response.statusCode}');
      print('📥 Backend response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true) {
          final List<dynamic> recipesJson = data['savedAiRecipes'] ?? [];
          print('📋 Found ${recipesJson.length} recipes for user $userId');
          return recipesJson.map((json) => _convertBackendToAIMeal(json)).toList();
        }
      }
      
      return [];
    } catch (e) {
      print('❌ Error loading recipes from backend: $e');
      return [];
    }
  }

  // Helper method to convert backend format to AIMeal
  AIMeal _convertBackendToAIMeal(Map<String, dynamic> json) {
    return AIMeal(
      id: json['id'] ?? json['_id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      cuisine: json['cuisine'] ?? '',
      preparationTime: json['preparationTime'] ?? 30,
      cookingTime: json['cookingTime'] ?? 30,
      servings: json['servings'] ?? 4,
      difficulty: json['difficulty'] ?? 'Medium',
      tags: List<String>.from(json['tags'] ?? []),
      imageUrl: json['imageUrl'],
      estimatedCalories: json['estimatedCalories']?.toDouble(),
      createdAt: json['recipeCreatedAt'] != null 
          ? DateTime.parse(json['recipeCreatedAt'])
          : (json['createdAt'] != null 
              ? DateTime.parse(json['createdAt'])
              : DateTime.now()),
    );
  }

  @override
  Future<List<AIMeal>> getAllSavedAIRecipes() async {
    try {
      // Get current user ID
      final appState = FFAppState();
      final String userId = appState.userId;
      
      print('👤 Current userId from app state: "$userId"');
      print('🔍 Loading all saved AI recipes for user: $userId');

      // Get local recipes
      final localRecipes = await localDataSource.getSavedAIRecipes();
      print('📱 Found ${localRecipes.length} local recipes');
      
      // Get backend recipes
      List<AIMeal> backendRecipes = [];
      if (userId.isNotEmpty) {
        backendRecipes = await getSavedAIRecipesFromBackend(userId);
        print('🌐 Found ${backendRecipes.length} backend recipes');
      } else {
        print('⚠️ UserId is empty, skipping backend request');
      }

      // Merge and deduplicate recipes by ID
      final Map<String, AIMeal> mergedRecipes = {};
      
      // Add local recipes first
      for (final recipe in localRecipes) {
        mergedRecipes[recipe.id] = recipe;
      }
      
      // Add backend recipes (will overwrite local if same ID)
      for (final recipe in backendRecipes) {
        mergedRecipes[recipe.id] = recipe;
      }
      
      // Return sorted by creation date (newest first)
      final allRecipes = mergedRecipes.values.toList();
      allRecipes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      print('✅ Total merged recipes: ${allRecipes.length}');
      return allRecipes;
    } catch (e) {
      // If backend fails, just return local recipes
      print('❌ Error merging recipes: $e');
      return await localDataSource.getSavedAIRecipes();
    }
  }

  @override
  Future<void> deleteAIRecipe(String recipeId) async {
    try {
      await localDataSource.deleteAIRecipe(recipeId);
    } catch (e) {
      throw Exception('Không thể xóa công thức: ${e.toString()}');
    }
  }

  @override
  Future<AIMeal> updateAIRecipe(AIMeal meal) async {
    try {
      return await localDataSource.updateAIRecipe(meal);
    } catch (e) {
      throw Exception('Không thể cập nhật công thức: ${e.toString()}');
    }
  }

  @override
  Future<List<AIMeal>> searchAIRecipes(String query) async {
    try {
      return await localDataSource.searchAIRecipes(query);
    } catch (e) {
      throw Exception('Không thể tìm kiếm công thức: ${e.toString()}');
    }
  }

  @override
  Future<AIMeal?> getAIRecipeById(String recipeId) async {
    try {
      return await localDataSource.getAIRecipeById(recipeId);
    } catch (e) {
      throw Exception('Không thể tìm công thức: ${e.toString()}');
    }
  }

  @override
  Future<String> exportAIRecipe(AIMeal meal, {String format = 'text'}) async {
    try {
      switch (format.toLowerCase()) {
        case 'json':
          return meal.toJson().toString();
        case 'text':
        default:
          return '''
CÔNG THỨC: ${meal.title}

MÔ TẢ:
${meal.description}

NGUYÊN LIỆU (${meal.servings} người ăn):
${meal.ingredients.map((ingredient) => '• $ingredient').join('\n')}

HƯỚNG DẪN NẤU:
${meal.instructions.asMap().entries.map((entry) => '${entry.key + 1}. ${entry.value}').join('\n')}

THÔNG TIN THÊM:
• Ẩm thực: ${meal.cuisine}
• Thời gian chuẩn bị: ${meal.preparationTime} phút
• Thời gian nấu: ${meal.cookingTime} phút
• Độ khó: ${meal.difficulty}
• Calories ước tính: ${meal.estimatedCalories ?? 'Chưa xác định'}
• Tags: ${meal.tags.join(', ')}

Được tạo bởi AI vào: ${meal.createdAt.day}/${meal.createdAt.month}/${meal.createdAt.year}
''';
      }
    } catch (e) {
      throw Exception('Không thể xuất công thức: ${e.toString()}');
    }
  }

  @override
  Future<AIMeal> improveRecipe(AIMeal meal, String feedback) async {
    try {
      final improvedMeal = await remoteDataSource.improveRecipe(meal, feedback);

      // Giữ nguyên ID và thời gian tạo gốc, chỉ cập nhật thông tin cải thiện
      final updatedMeal = improvedMeal.copyWith(
        id: meal.id,
        createdAt: meal.createdAt,
      );

      // Tự động lưu bản cải thiện
      await localDataSource.saveAIRecipe(updatedMeal);

      return updatedMeal;
    } catch (e) {
      throw Exception('Không thể cải thiện công thức: ${e.toString()}');
    }
  }
}
