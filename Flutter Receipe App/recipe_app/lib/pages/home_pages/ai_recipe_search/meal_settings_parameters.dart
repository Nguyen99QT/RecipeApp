import 'package:image_picker/image_picker.dart';
import '../ai_recipe_search/input_mode.dart';

// Parameters class for meal settings
class MealSettingsParameters {
  final int people;
  final int maxTimeCooking;
  final String? intoleranceOrLimits;
  final XFile? picture;
  final List<XFile>? pictures;
  final String? ingredientsText;
  final InputMode inputMode;

  const MealSettingsParameters({
    required this.people,
    required this.maxTimeCooking,
    this.intoleranceOrLimits,
    this.picture,
    this.pictures,
    this.ingredientsText,
    required this.inputMode,
  });

  bool get hasValidInput {
    return (ingredientsText != null && ingredientsText!.trim().isNotEmpty) ||
        picture != null ||
        (pictures != null && pictures!.isNotEmpty);
  }

  MealSettingsParameters copyWith({
    int? people,
    int? maxTimeCooking,
    String? intoleranceOrLimits,
    XFile? picture,
    List<XFile>? pictures,
    String? ingredientsText,
    InputMode? inputMode,
  }) {
    return MealSettingsParameters(
      people: people ?? this.people,
      maxTimeCooking: maxTimeCooking ?? this.maxTimeCooking,
      intoleranceOrLimits: intoleranceOrLimits ?? this.intoleranceOrLimits,
      picture: picture ?? this.picture,
      pictures: pictures ?? this.pictures,
      ingredientsText: ingredientsText ?? this.ingredientsText,
      inputMode: inputMode ?? this.inputMode,
    );
  }
}
