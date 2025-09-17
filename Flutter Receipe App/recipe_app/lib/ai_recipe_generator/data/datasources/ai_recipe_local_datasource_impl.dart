import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/ai_meal.dart';
import 'ai_recipe_local_datasource.dart';

class AIRecipeLocalDataSourceImpl implements AIRecipeLocalDataSource {
  static const String _recipesKey = 'ai_recipes';
  final SharedPreferences sharedPreferences;

  AIRecipeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveAIRecipe(AIMeal meal) async {
    try {
      final recipes = await getSavedAIRecipes();

      // Kiểm tra xem recipe đã tồn tại chưa
      final existingIndex = recipes.indexWhere((r) => r.id == meal.id);

      if (existingIndex >= 0) {
        // Cập nhật recipe hiện có
        recipes[existingIndex] = meal;
      } else {
        // Thêm recipe mới
        recipes.add(meal);
      }

      final recipesJson = recipes.map((recipe) => recipe.toJson()).toList();
      await sharedPreferences.setString(_recipesKey, json.encode(recipesJson));
    } catch (e) {
      throw Exception('Không thể lưu công thức: ${e.toString()}');
    }
  }

  @override
  Future<List<AIMeal>> getSavedAIRecipes() async {
    try {
      final recipesString = sharedPreferences.getString(_recipesKey);
      if (recipesString == null) return [];

      final List<dynamic> recipesJson = json.decode(recipesString);
      return recipesJson
          .map((json) => AIMeal.fromJson(json as Map<String, dynamic>))
          .toList()
        ..sort((a, b) =>
            b.createdAt.compareTo(a.createdAt)); // Sắp xếp mới nhất trước
    } catch (e) {
      throw Exception('Không thể tải danh sách công thức: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteAIRecipe(String recipeId) async {
    try {
      final recipes = await getSavedAIRecipes();
      recipes.removeWhere((recipe) => recipe.id == recipeId);

      final recipesJson = recipes.map((recipe) => recipe.toJson()).toList();
      await sharedPreferences.setString(_recipesKey, json.encode(recipesJson));
    } catch (e) {
      throw Exception('Không thể xóa công thức: ${e.toString()}');
    }
  }

  @override
  Future<AIMeal> updateAIRecipe(AIMeal meal) async {
    try {
      await saveAIRecipe(meal); // saveAIRecipe đã handle update logic
      return meal;
    } catch (e) {
      throw Exception('Không thể cập nhật công thức: ${e.toString()}');
    }
  }

  @override
  Future<List<AIMeal>> searchAIRecipes(String query) async {
    try {
      final recipes = await getSavedAIRecipes();
      final lowercaseQuery = query.toLowerCase();

      return recipes.where((recipe) {
        return recipe.title.toLowerCase().contains(lowercaseQuery) ||
            recipe.description.toLowerCase().contains(lowercaseQuery) ||
            recipe.cuisine.toLowerCase().contains(lowercaseQuery) ||
            recipe.ingredients.any((ingredient) =>
                ingredient.toLowerCase().contains(lowercaseQuery)) ||
            recipe.tags
                .any((tag) => tag.toLowerCase().contains(lowercaseQuery));
      }).toList();
    } catch (e) {
      throw Exception('Không thể tìm kiếm công thức: ${e.toString()}');
    }
  }

  @override
  Future<AIMeal?> getAIRecipeById(String recipeId) async {
    try {
      final recipes = await getSavedAIRecipes();
      return recipes.where((recipe) => recipe.id == recipeId).firstOrNull;
    } catch (e) {
      throw Exception('Không thể tìm công thức: ${e.toString()}');
    }
  }

  @override
  Future<void> clearAllAIRecipes() async {
    try {
      await sharedPreferences.remove(_recipesKey);
    } catch (e) {
      throw Exception('Không thể xóa tất cả công thức: ${e.toString()}');
    }
  }
}

// Extension để hỗ trợ firstOrNull (nếu chưa có sẵn)
extension FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    if (iterator.moveNext()) {
      return iterator.current;
    }
    return null;
  }
}
