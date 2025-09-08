import '../entities/ai_meal.dart';
import '../entities/ai_recipe_request.dart';

abstract class AIRecipeRepository {
  /// Tạo công thức từ ảnh sử dụng AI
  Future<AIMeal> generateRecipeFromImages(AIRecipeRequest request);

  /// Lưu công thức AI đã tạo
  Future<void> saveAIRecipe(AIMeal meal);

  /// Lấy danh sách công thức AI đã lưu
  Future<List<AIMeal>> getSavedAIRecipes();

  /// Xóa công thức AI
  Future<void> deleteAIRecipe(String recipeId);

  /// Cập nhật công thức AI
  Future<AIMeal> updateAIRecipe(AIMeal meal);

  /// Tìm kiếm công thức AI theo từ khóa
  Future<List<AIMeal>> searchAIRecipes(String query);

  /// Lấy chi tiết công thức AI theo ID
  Future<AIMeal?> getAIRecipeById(String recipeId);

  /// Xuất công thức AI thành định dạng khác (PDF, share)
  Future<String> exportAIRecipe(AIMeal meal, {String format = 'text'});

  /// Đánh giá và cải thiện công thức AI
  Future<AIMeal> improveRecipe(AIMeal meal, String feedback);
}
