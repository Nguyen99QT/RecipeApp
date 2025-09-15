import '../../domain/entities/ai_meal.dart';
import '../../domain/entities/ai_recipe_request.dart';

abstract class AIRecipeRemoteDataSource {
  /// Gọi API AI để tạo công thức từ ảnh
  Future<AIMeal> generateRecipeFromImages(AIRecipeRequest request);

  /// Cải thiện công thức bằng AI
  Future<AIMeal> improveRecipe(AIMeal meal, String feedback);
}
