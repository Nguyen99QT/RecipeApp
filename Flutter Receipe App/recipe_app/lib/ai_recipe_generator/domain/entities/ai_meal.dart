class AIMeal {
  final String id;
  final String title;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String cuisine;
  final int preparationTime;
  final int cookingTime;
  final int servings;
  final String difficulty;
  final List<String> tags;
  final String? imageUrl;
  final double? estimatedCalories;
  final DateTime createdAt;

  const AIMeal({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.cuisine,
    required this.preparationTime,
    required this.cookingTime,
    required this.servings,
    required this.difficulty,
    required this.tags,
    this.imageUrl,
    this.estimatedCalories,
    required this.createdAt,
  });

  AIMeal copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? ingredients,
    List<String>? instructions,
    String? cuisine,
    int? preparationTime,
    int? cookingTime,
    int? servings,
    String? difficulty,
    List<String>? tags,
    String? imageUrl,
    double? estimatedCalories,
    DateTime? createdAt,
  }) {
    return AIMeal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      cuisine: cuisine ?? this.cuisine,
      preparationTime: preparationTime ?? this.preparationTime,
      cookingTime: cookingTime ?? this.cookingTime,
      servings: servings ?? this.servings,
      difficulty: difficulty ?? this.difficulty,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      estimatedCalories: estimatedCalories ?? this.estimatedCalories,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'instructions': instructions,
      'cuisine': cuisine,
      'preparationTime': preparationTime,
      'cookingTime': cookingTime,
      'servings': servings,
      'difficulty': difficulty,
      'tags': tags,
      'imageUrl': imageUrl,
      'estimatedCalories': estimatedCalories,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory AIMeal.fromJson(Map<String, dynamic> json) {
    return AIMeal(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      instructions: List<String>.from(json['instructions'] ?? []),
      cuisine: json['cuisine'] ?? '',
      preparationTime: json['preparationTime'] ?? 0,
      cookingTime: json['cookingTime'] ?? 0,
      servings: json['servings'] ?? 1,
      difficulty: json['difficulty'] ?? 'Dễ',
      tags: List<String>.from(json['tags'] ?? []),
      imageUrl: json['imageUrl'],
      estimatedCalories: json['estimatedCalories']?.toDouble(),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AIMeal && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AIMeal(id: $id, title: $title, cuisine: $cuisine)';
  }
}
