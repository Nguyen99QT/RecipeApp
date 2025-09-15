import 'package:flutter_bloc/flutter_bloc.dart';
import 'meal_state.dart';
import '../../../pages/home_pages/ai_recipe_search/input_mode.dart';

// Additional states specific to this cubit
class MealLoaded extends MealState {
  final List<String> meals;

  const MealLoaded({
    required this.meals,
  });

  @override
  List<Object?> get props => [meals];
}

// BLoC for managing AI recipe generation state
class MealCubit extends Cubit<MealState> {
  MealCubit() : super(const MealInitial());

  // Update settings
  void updatePeople(int people) {
    // Implementation for updating people count
  }

  void updateCookingTime(int minutes) {
    // Implementation for updating cooking time
  }

  void updateIngredientsText(String? text) {
    // Implementation for updating ingredients text
  }

  void updateInputMode(InputMode mode) {
    // Implementation for updating input mode
  }

  // AI meal generation
  Future<void> generateMeals() async {
    emit(const MealLoading());

    try {
      // Mock implementation
      await Future.delayed(const Duration(seconds: 2));
      final meals = [
        'AI Generated Recipe 1: Delicious meal based on your ingredients',
        'AI Generated Recipe 2: Alternative cooking method',
        'AI Generated Recipe 3: Creative variation'
      ];

      emit(MealLoaded(meals: meals));
    } catch (e) {
      emit(MealError(
        message: 'Failed to generate recipes: ${e.toString()}',
      ));
    }
  }

  // Reset to initial state
  void reset() {
    emit(const MealInitial());
  }
}
