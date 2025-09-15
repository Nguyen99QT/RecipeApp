import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// Data layer imports
import 'data/datasources/ai_recipe_remote_datasource.dart';
import 'data/datasources/ai_recipe_simple_datasource_impl.dart';
import 'data/datasources/ai_recipe_local_datasource.dart';
import 'data/datasources/ai_recipe_local_datasource_impl.dart';
import 'data/repositories/ai_recipe_repository_impl.dart';

// Domain layer imports
import 'domain/repositories/ai_recipe_repository.dart';
import 'domain/usecases/generate_recipe_usecase.dart';
import 'domain/usecases/save_ai_recipe_usecase.dart';
import 'domain/usecases/get_saved_ai_recipes_usecase.dart';

// Presentation layer imports
import 'presentation/blocs/ai_recipe_bloc.dart';
import 'presentation/pages/ai_recipe_generator_page.dart';
import 'presentation/pages/saved_ai_recipes_page.dart';

/// Dependency Injection Container cho AI Recipe Generator module
class AIRecipeGeneratorDI {
  static AIRecipeGeneratorDI? _instance;
  static AIRecipeGeneratorDI get instance =>
      _instance ??= AIRecipeGeneratorDI._internal();

  AIRecipeGeneratorDI._internal();

  // Dependencies
  SharedPreferences? _sharedPreferences;
  http.Client? _httpClient;
  AIRecipeRemoteDataSource? _remoteDataSource;
  AIRecipeLocalDataSource? _localDataSource;
  AIRecipeRepository? _repository;

  // Use cases
  GenerateRecipeUseCase? _generateRecipeUseCase;
  SaveAIRecipeUseCase? _saveAIRecipeUseCase;
  GetSavedAIRecipesUseCase? _getSavedAIRecipesUseCase;

  // BLoC
  AIRecipeBloc? _aiRecipeBloc;

  /// Initialize all dependencies
  Future<void> init({String? geminiApiKey}) async {
    // Core dependencies
    _sharedPreferences ??= await SharedPreferences.getInstance();
    _httpClient ??= http.Client();

    // Data sources
    _remoteDataSource ??= AIRecipeSimpleDataSourceImpl(
      apiKey: geminiApiKey ??
          const String.fromEnvironment('GEMINI_API_KEY',
              defaultValue: 'AIzaSyAnx6FKl4dkPpACvIjWQ2L9D8Vt7UBmNks'),
      httpClient: _httpClient!,
    );

    _localDataSource ??= AIRecipeLocalDataSourceImpl(
      sharedPreferences: _sharedPreferences!,
    );

    // Repository
    _repository ??= AIRecipeRepositoryImpl(
      remoteDataSource: _remoteDataSource!,
      localDataSource: _localDataSource!,
    );

    // Use cases
    _generateRecipeUseCase ??= GenerateRecipeUseCase(_repository!);
    _saveAIRecipeUseCase ??= SaveAIRecipeUseCase(_repository!);
    _getSavedAIRecipesUseCase ??= GetSavedAIRecipesUseCase(_repository!);

    // BLoC will be created when needed in getter
    print('✅ AIRecipeGeneratorDI initialized successfully');
  }

  /// Get AIRecipeBloc instance (create new if needed)
  AIRecipeBloc get aiRecipeBloc {
    if (_aiRecipeBloc == null || _aiRecipeBloc!.isClosed) {
      print('🔄 Creating new AIRecipeBloc instance');
      _aiRecipeBloc = AIRecipeBloc(
        generateRecipeUseCase: _generateRecipeUseCase!,
        saveAIRecipeUseCase: _saveAIRecipeUseCase!,
        getSavedAIRecipesUseCase: _getSavedAIRecipesUseCase!,
      );
    }
    return _aiRecipeBloc!;
  }

  /// Clean up resources
  void dispose() {
    _aiRecipeBloc?.close();
    _httpClient?.close();
    _aiRecipeBloc = null;
  }
}

/// Widget wrapper để cung cấp BLoC cho AI Recipe Generator
class AIRecipeGeneratorProvider extends StatelessWidget {
  final Widget child;
  final String? geminiApiKey;

  const AIRecipeGeneratorProvider({
    super.key,
    required this.child,
    this.geminiApiKey,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initDependencies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8C00)),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Lỗi khởi tạo AI Recipe Generator',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${snapshot.error}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        return BlocProvider<AIRecipeBloc>(
          create: (context) => AIRecipeGeneratorDI.instance.aiRecipeBloc,
          child: child,
        );
      },
    );
  }

  Future<void> _initDependencies() async {
    await AIRecipeGeneratorDI.instance.init(geminiApiKey: geminiApiKey);
  }
}

/// Entry point cho AI Recipe Generator page
class AIRecipeGeneratorEntry extends StatelessWidget {
  final String? geminiApiKey;

  const AIRecipeGeneratorEntry({
    super.key,
    this.geminiApiKey,
  });

  @override
  Widget build(BuildContext context) {
    return AIRecipeGeneratorProvider(
      geminiApiKey: geminiApiKey,
      child: const AIRecipeGeneratorPage(),
    );
  }
}

/// Entry point cho Saved AI Recipes page
class SavedAIRecipesEntry extends StatelessWidget {
  final String? geminiApiKey;

  const SavedAIRecipesEntry({
    super.key,
    this.geminiApiKey,
  });

  @override
  Widget build(BuildContext context) {
    return AIRecipeGeneratorProvider(
      geminiApiKey: geminiApiKey,
      child: const SavedAIRecipesPage(),
    );
  }
}

/// Utility class để điều hướng đến AI Recipe Generator
class AIRecipeGeneratorNavigation {
  /// Mở trang tạo công thức AI
  static Future<void> openGenerator(BuildContext context,
      {String? geminiApiKey}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            AIRecipeGeneratorEntry(geminiApiKey: geminiApiKey),
      ),
    );
  }

  /// Mở trang danh sách công thức AI đã lưu
  static Future<void> openSavedRecipes(BuildContext context,
      {String? geminiApiKey}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SavedAIRecipesEntry(geminiApiKey: geminiApiKey),
      ),
    );
  }

  /// Widget button để tạo công thức AI (có thể dùng trong menu)
  static Widget buildGeneratorButton(BuildContext context,
      {String? geminiApiKey}) {
    return ElevatedButton.icon(
      onPressed: () => openGenerator(context, geminiApiKey: geminiApiKey),
      icon: const Icon(Icons.auto_awesome),
      label: const Text('Generate AI Recipe'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF8C00),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  /// Widget button để xem công thức AI đã lưu (có thể dùng trong menu)
  static Widget buildSavedRecipesButton(BuildContext context,
      {String? geminiApiKey}) {
    return OutlinedButton.icon(
      onPressed: () => openSavedRecipes(context, geminiApiKey: geminiApiKey),
      icon: const Icon(Icons.bookmark),
      label: const Text('Công Thức AI Đã Lưu'),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFFF8C00),
        side: const BorderSide(color: Color(0xFFFF8C00)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
