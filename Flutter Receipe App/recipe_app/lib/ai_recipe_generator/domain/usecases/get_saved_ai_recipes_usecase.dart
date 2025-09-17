import '../entities/ai_meal.dart';
import '../repositories/ai_recipe_repository.dart';

class GetSavedAIRecipesUseCase {
  final AIRecipeRepository repository;

  GetSavedAIRecipesUseCase(this.repository);

  Future<List<AIMeal>> call() async {
    try {
      return await repository.getSavedAIRecipes();
    } catch (e) {
      throw Exception('Không thể tải danh sách công thức: ${e.toString()}');
    }
  }
}
