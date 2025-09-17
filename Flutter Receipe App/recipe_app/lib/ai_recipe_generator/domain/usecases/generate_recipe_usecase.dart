import '../entities/ai_meal.dart';
import '../entities/ai_recipe_request.dart';
import '../repositories/ai_recipe_repository.dart';

class GenerateRecipeUseCase {
  final AIRecipeRepository repository;

  GenerateRecipeUseCase(this.repository);

  Future<AIMeal> call(AIRecipeRequest request) async {
    // Validate input
    if (request.imageUrls.isEmpty) {
      throw ArgumentError('Need at least one image to generate recipe');
    }

    // Validate image URLs
    for (final url in request.imageUrls) {
      if (url.isEmpty) {
        throw ArgumentError('URL hình ảnh không hợp lệ');
      }
    }

    try {
      return await repository.generateRecipeFromImages(request);
    } catch (e) {
      throw Exception('Không thể tạo công thức: ${e.toString()}');
    }
  }
}
