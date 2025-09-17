import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../../pages/home_pages/ai_recipe_search/meal_settings_parameters.dart';
import '../../../pages/home_pages/ai_recipe_search/input_mode.dart';

// Base state class
abstract class MealState extends Equatable {
  const MealState();

  @override
  List<Object?> get props => [];
}

// Initial state
class MealInitial extends MealState {
  const MealInitial();
}

// Loading state
class MealLoading extends MealState {
  const MealLoading();
}

// Settings state
class MealSettingsState extends MealState {
  final MealSettingsParameters parameters;

  const MealSettingsState({
    required this.parameters,
  });

  // Constructor with individual parameters for backward compatibility
  MealSettingsState.withValues({
    required int people,
    required int maxTimeCooking,
    String? intoleranceOrLimits,
    XFile? picture,
    List<XFile>? pictures,
    String? ingredientsText,
    required InputMode inputMode,
  }) : parameters = MealSettingsParameters(
          people: people,
          maxTimeCooking: maxTimeCooking,
          intoleranceOrLimits: intoleranceOrLimits,
          picture: picture,
          pictures: pictures,
          ingredientsText: ingredientsText,
          inputMode: inputMode,
        );

  // Getters for backward compatibility
  int get people => parameters.people;
  int get maxTimeCooking => parameters.maxTimeCooking;
  String? get intoleranceOrLimits => parameters.intoleranceOrLimits;
  XFile? get picture => parameters.picture;
  List<XFile>? get pictures => parameters.pictures;
  String? get ingredientsText => parameters.ingredientsText;
  InputMode get inputMode => parameters.inputMode;

  bool get hasValidInput => parameters.hasValidInput;

  // Convert to MealSettingsParameters for the repository
  MealSettingsParameters toParameters() => parameters;

  @override
  List<Object?> get props => [parameters];

  MealSettingsState copyWith({
    int? people,
    int? maxTimeCooking,
    String? intoleranceOrLimits,
    XFile? picture,
    List<XFile>? pictures,
    String? ingredientsText,
    InputMode? inputMode,
  }) {
    return MealSettingsState(
      parameters: parameters.copyWith(
        people: people,
        maxTimeCooking: maxTimeCooking,
        intoleranceOrLimits: intoleranceOrLimits,
        picture: picture,
        pictures: pictures,
        ingredientsText: ingredientsText,
        inputMode: inputMode,
      ),
    );
  }
}

// Success state
class MealSuccess extends MealState {
  final String recipeData;

  const MealSuccess({required this.recipeData});

  @override
  List<Object?> get props => [recipeData];
}

// Error state
class MealError extends MealState {
  final String message;

  const MealError({required this.message});

  @override
  List<Object?> get props => [message];
}
