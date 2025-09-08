class AIRecipeRequest {
  final List<String> imageUrls;
  final String? userPrompt;
  final String? dietaryRestrictions;
  final String? preferredCuisine;
  final int? targetServings;
  final String? difficultyLevel;
  final int? maxPrepTime;
  final List<String>? availableIngredients;
  final List<String>? allergies;

  const AIRecipeRequest({
    required this.imageUrls,
    this.userPrompt,
    this.dietaryRestrictions,
    this.preferredCuisine,
    this.targetServings,
    this.difficultyLevel,
    this.maxPrepTime,
    this.availableIngredients,
    this.allergies,
  });

  AIRecipeRequest copyWith({
    List<String>? imageUrls,
    String? userPrompt,
    String? dietaryRestrictions,
    String? preferredCuisine,
    int? targetServings,
    String? difficultyLevel,
    int? maxPrepTime,
    List<String>? availableIngredients,
    List<String>? allergies,
  }) {
    return AIRecipeRequest(
      imageUrls: imageUrls ?? this.imageUrls,
      userPrompt: userPrompt ?? this.userPrompt,
      dietaryRestrictions: dietaryRestrictions ?? this.dietaryRestrictions,
      preferredCuisine: preferredCuisine ?? this.preferredCuisine,
      targetServings: targetServings ?? this.targetServings,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      maxPrepTime: maxPrepTime ?? this.maxPrepTime,
      availableIngredients: availableIngredients ?? this.availableIngredients,
      allergies: allergies ?? this.allergies,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrls': imageUrls,
      'userPrompt': userPrompt,
      'dietaryRestrictions': dietaryRestrictions,
      'preferredCuisine': preferredCuisine,
      'targetServings': targetServings,
      'difficultyLevel': difficultyLevel,
      'maxPrepTime': maxPrepTime,
      'availableIngredients': availableIngredients,
      'allergies': allergies,
    };
  }

  factory AIRecipeRequest.fromJson(Map<String, dynamic> json) {
    return AIRecipeRequest(
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      userPrompt: json['userPrompt'],
      dietaryRestrictions: json['dietaryRestrictions'],
      preferredCuisine: json['preferredCuisine'],
      targetServings: json['targetServings'],
      difficultyLevel: json['difficultyLevel'],
      maxPrepTime: json['maxPrepTime'],
      availableIngredients: json['availableIngredients'] != null
          ? List<String>.from(json['availableIngredients'])
          : null,
      allergies: json['allergies'] != null
          ? List<String>.from(json['allergies'])
          : null,
    );
  }

  @override
  String toString() {
    return 'AIRecipeRequest(imageUrls: ${imageUrls.length} images, userPrompt: $userPrompt)';
  }
}
