import '../entities/ai_meal.dart';
import '../repositories/ai_recipe_repository.dart';

class GetAllSavedAIRecipesUseCase {
  final AIRecipeRepository repository;

  GetAllSavedAIRecipesUseCase(this.repository);

  Future<List<AIMeal>> call() async {
    try {
      return await repository.getAllSavedAIRecipes();
    } catch (e) {
      throw Exception('Unable to load recipe list: ${e.toString()}');
    }
  }
}