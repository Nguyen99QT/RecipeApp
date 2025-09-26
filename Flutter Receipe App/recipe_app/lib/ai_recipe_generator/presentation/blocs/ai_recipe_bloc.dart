import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/entities/ai_meal.dart';
import '../../domain/entities/ai_recipe_request.dart';
import '../../domain/usecases/generate_recipe_usecase.dart';
import '../../domain/usecases/save_ai_recipe_usecase.dart';
import '../../domain/usecases/get_saved_ai_recipes_usecase.dart';
import '../../domain/usecases/get_all_saved_ai_recipes_usecase.dart';
import '../../domain/usecases/get_user_saved_ai_recipes_usecase.dart';
import '/flutter_flow/flutter_flow_util.dart';

// Events
abstract class AIRecipeEvent extends Equatable {
  const AIRecipeEvent();

  @override
  List<Object?> get props => [];
}

class GenerateRecipeEvent extends AIRecipeEvent {
  final AIRecipeRequest request;

  const GenerateRecipeEvent(this.request);

  @override
  List<Object?> get props => [request];
}

class SaveRecipeEvent extends AIRecipeEvent {
  final AIMeal meal;

  const SaveRecipeEvent(this.meal);

  @override
  List<Object?> get props => [meal];
}

class LoadSavedRecipesEvent extends AIRecipeEvent {
  const LoadSavedRecipesEvent();
}

class DeleteRecipeEvent extends AIRecipeEvent {
  final String recipeId;

  const DeleteRecipeEvent(this.recipeId);

  @override
  List<Object?> get props => [recipeId];
}

class ResetStateEvent extends AIRecipeEvent {
  const ResetStateEvent();
}

// States
abstract class AIRecipeState extends Equatable {
  const AIRecipeState();

  @override
  List<Object?> get props => [];
}

class AIRecipeInitial extends AIRecipeState {
  const AIRecipeInitial();
}

class AIRecipeGenerating extends AIRecipeState {
  final double? progress;

  const AIRecipeGenerating({this.progress});

  @override
  List<Object?> get props => [progress];
}

class AIRecipeGenerated extends AIRecipeState {
  final AIMeal meal;

  const AIRecipeGenerated(this.meal);

  @override
  List<Object?> get props => [meal];
}

class AIRecipeError extends AIRecipeState {
  final String message;

  const AIRecipeError(this.message);

  @override
  List<Object?> get props => [message];
}

class AIRecipeSaved extends AIRecipeState {
  final AIMeal meal;

  const AIRecipeSaved(this.meal);

  @override
  List<Object?> get props => [meal];
}

class SavedRecipesLoaded extends AIRecipeState {
  final List<AIMeal> recipes;

  const SavedRecipesLoaded(this.recipes);

  @override
  List<Object?> get props => [recipes];
}

class AIRecipeLoading extends AIRecipeState {
  const AIRecipeLoading();
}

// BLoC
class AIRecipeBloc extends Bloc<AIRecipeEvent, AIRecipeState> {
  final GenerateRecipeUseCase generateRecipeUseCase;
  final SaveAIRecipeUseCase saveAIRecipeUseCase;
  final GetSavedAIRecipesUseCase getSavedAIRecipesUseCase;
  final GetAllSavedAIRecipesUseCase getAllSavedAIRecipesUseCase;
  final GetUserSavedAIRecipesUseCase getUserSavedAIRecipesUseCase;

  AIRecipeBloc({
    required this.generateRecipeUseCase,
    required this.saveAIRecipeUseCase,
    required this.getSavedAIRecipesUseCase,
    required this.getAllSavedAIRecipesUseCase,
    required this.getUserSavedAIRecipesUseCase,
  }) : super(const AIRecipeInitial()) {
    print('🏗️ AIRecipeBloc: Constructor called');
    on<GenerateRecipeEvent>(_onGenerateRecipe);
    on<SaveRecipeEvent>(_onSaveRecipe);
    on<LoadSavedRecipesEvent>(_onLoadSavedRecipes);
    on<DeleteRecipeEvent>(_onDeleteRecipe);
    on<ResetStateEvent>(_onResetState);
    print('✅ AIRecipeBloc: Event handlers registered');
  }

  Future<void> _onGenerateRecipe(
    GenerateRecipeEvent event,
    Emitter<AIRecipeState> emit,
  ) async {
    try {
      print('🤖 AIRecipeBloc: Starting recipe generation');
      print('📝 Request: ${event.request.imageUrls.length} images');

      emit(const AIRecipeGenerating());

      final meal = await generateRecipeUseCase(event.request);

      print('✅ AIRecipeBloc: Recipe generated successfully');
      emit(AIRecipeGenerated(meal));
    } catch (e) {
      print('❌ AIRecipeBloc: Error generating recipe: $e');
      emit(AIRecipeError(e.toString()));
    }
  }

  Future<void> _onSaveRecipe(
    SaveRecipeEvent event,
    Emitter<AIRecipeState> emit,
  ) async {
    try {
      emit(const AIRecipeLoading());

      await saveAIRecipeUseCase(event.meal);

      // Auto-sync to backend after successful local save
      await _syncToBackend(event.meal);

      emit(AIRecipeSaved(event.meal));
    } catch (e) {
      emit(AIRecipeError(e.toString()));
    }
  }

  Future<void> _onLoadSavedRecipes(
    LoadSavedRecipesEvent event,
    Emitter<AIRecipeState> emit,
  ) async {
    try {
      emit(const AIRecipeLoading());

      // Use getUserSavedAIRecipesUseCase để chỉ lấy recipes của user đang đăng nhập
      final recipes = await getUserSavedAIRecipesUseCase();

      emit(SavedRecipesLoaded(recipes));
    } catch (e) {
      emit(AIRecipeError(e.toString()));
    }
  }

  Future<void> _onDeleteRecipe(
    DeleteRecipeEvent event,
    Emitter<AIRecipeState> emit,
  ) async {
    try {
      // Implement delete logic if needed
      // For now, just reload the saved recipes
      add(const LoadSavedRecipesEvent());
    } catch (e) {
      emit(AIRecipeError(e.toString()));
    }
  }

  Future<void> _onResetState(
    ResetStateEvent event,
    Emitter<AIRecipeState> emit,
  ) async {
    emit(const AIRecipeInitial());
  }

  // Helper method to sync recipe to backend
  Future<void> _syncToBackend(AIMeal meal) async {
    try {
      // Get real user info from app state
      final appState = FFAppState();
      final String realUserId = appState.userId.isNotEmpty ? appState.userId : 'test_user_flutter';
      final dynamic userDetail = appState.userDetail;
      final String realUserEmail = userDetail != null && userDetail['email'] != null 
          ? userDetail['email'].toString() 
          : 'test@example.com';
      
      // Create sync payload with real user data
      final Map<String, dynamic> payload = {
        'title': meal.title,
        'description': meal.description,
        'instructions': meal.instructions,
        'ingredients': meal.ingredients,
        'userId': realUserId,
        'userEmail': realUserEmail,
        'preparationTime': meal.preparationTime.toString(),
        'cookingTime': meal.cookingTime.toString(),
        'cuisine': meal.cuisine,
        'tags': meal.tags,
        'difficulty': meal.difficulty,
        'servings': meal.servings.toString(),
        'estimatedCalories': meal.estimatedCalories?.toString() ?? '',
        'imageUrl': meal.imageUrl ?? '',
        'createdAt': DateTime.now().toIso8601String(),
      };

      print('🔄 Syncing AI recipe to backend with user: $realUserId');
      print('📝 Payload data: ${json.encode(payload)}');
      
      // Send to backend API
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/saved-ai-recipes'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      print('📊 Response status: ${response.statusCode}');
      print('📥 Response body: ${response.body}');

      if (response.statusCode == 201) {
        print('✅ Recipe synced successfully to backend');
      } else {
        print('❌ Failed to sync recipe: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('❌ Error syncing recipe to backend: $e');
    }
  }
}
