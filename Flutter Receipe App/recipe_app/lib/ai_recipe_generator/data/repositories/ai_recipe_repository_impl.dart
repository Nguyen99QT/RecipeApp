import '../../domain/entities/ai_meal.dart';
import '../../domain/entities/ai_recipe_request.dart';
import '../../domain/repositories/ai_recipe_repository.dart';
import '../datasources/ai_recipe_remote_datasource.dart';
import '../datasources/ai_recipe_local_datasource.dart';

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
