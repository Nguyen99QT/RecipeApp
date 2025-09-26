import '../entities/ai_meal.dart';
import '../repositories/ai_recipe_repository.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GetUserSavedAIRecipesUseCase {
  final AIRecipeRepository repository;

  GetUserSavedAIRecipesUseCase(this.repository);

  Future<List<AIMeal>> call() async {
    try {
      // Get current user ID from app state
      final appState = FFAppState();
      final String userId = appState.userId;
      
      if (userId.isEmpty) {
        throw Exception('User not logged in');
      }
      
      // Only get recipes from backend for the current user
      return await repository.getSavedAIRecipesFromBackend(userId);
    } catch (e) {
      throw Exception('Unable to load your recipe list: ${e.toString()}');
    }
  }
}