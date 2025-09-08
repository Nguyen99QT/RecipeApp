import 'ai_meal.dart';

enum AIGenerationStatus {
  idle,
  loading,
  success,
  error,
}

class AIGenerationResult {
  final AIGenerationStatus status;
  final AIMeal? meal;
  final String? errorMessage;
  final double? progress;

  const AIGenerationResult({
    required this.status,
    this.meal,
    this.errorMessage,
    this.progress,
  });

  const AIGenerationResult.idle() : this(status: AIGenerationStatus.idle);

  const AIGenerationResult.loading({double? progress})
      : this(status: AIGenerationStatus.loading, progress: progress);

  const AIGenerationResult.success(AIMeal meal)
      : this(status: AIGenerationStatus.success, meal: meal);

  const AIGenerationResult.error(String message)
      : this(status: AIGenerationStatus.error, errorMessage: message);

  AIGenerationResult copyWith({
    AIGenerationStatus? status,
    AIMeal? meal,
    String? errorMessage,
    double? progress,
  }) {
    return AIGenerationResult(
      status: status ?? this.status,
      meal: meal ?? this.meal,
      errorMessage: errorMessage ?? this.errorMessage,
      progress: progress ?? this.progress,
    );
  }

  bool get isIdle => status == AIGenerationStatus.idle;
  bool get isLoading => status == AIGenerationStatus.loading;
  bool get isSuccess => status == AIGenerationStatus.success;
  bool get isError => status == AIGenerationStatus.error;

  @override
  String toString() {
    return 'AIGenerationResult(status: $status, meal: ${meal?.title}, error: $errorMessage)';
  }
}
