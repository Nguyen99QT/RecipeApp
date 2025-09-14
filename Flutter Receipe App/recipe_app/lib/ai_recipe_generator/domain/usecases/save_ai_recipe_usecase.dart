import '../entities/ai_meal.dart';
import '../repositories/ai_recipe_repository.dart';

class SaveAIRecipeUseCase {
  final AIRecipeRepository repository;

  SaveAIRecipeUseCase(this.repository);

  Future<void> call(AIMeal meal) async {
    if (meal.title.isEmpty) {
      throw ArgumentError('Tên công thức không được để trống');
    }

    if (meal.ingredients.isEmpty) {
      throw ArgumentError('Danh sách nguyên liệu không được để trống');
    }

    if (meal.instructions.isEmpty) {
      throw ArgumentError('Cooking instructions cannot be empty');
    }

    try {
      await repository.saveAIRecipe(meal);
    } catch (e) {
      throw Exception('Không thể lưu công thức: ${e.toString()}');
    }
  }
}
