import '../../domain/entities/ai_meal.dart';

abstract class AIRecipeLocalDataSource {
  /// Lưu công thức AI vào local storage
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

  /// Xóa tất cả công thức AI đã lưu
  Future<void> clearAllAIRecipes();
}
