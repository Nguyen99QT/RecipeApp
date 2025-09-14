import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../../domain/entities/ai_recipe_request.dart';
import '../blocs/ai_recipe_bloc.dart';
import '../widgets/image_picker_widget.dart';
import '../widgets/recipe_preferences_widget.dart';
import 'ai_recipe_result_page.dart';
import '../../ai_recipe_generator_main.dart';

class AIRecipeGeneratorPage extends StatefulWidget {
  const AIRecipeGeneratorPage({super.key});

  @override
  State<AIRecipeGeneratorPage> createState() => _AIRecipeGeneratorPageState();
}

class _AIRecipeGeneratorPageState extends State<AIRecipeGeneratorPage> {
  @override
  Widget build(BuildContext context) {
    // Check if we already have AIRecipeBloc in context
    try {
      final bloc = context.read<AIRecipeBloc>();
      if (!bloc.isClosed) {
        // If we have it and it's not closed, use the original page
        return const _AIRecipeGeneratorPageContent();
      } else {
        print('⚠️ Found closed BLoC, creating new provider wrapper');
        return const AIRecipeGeneratorEntry();
      }
    } catch (e) {
      // If we don't have it, wrap with provider
      print('🔄 No AIRecipeBloc found, creating provider wrapper');
      return const AIRecipeGeneratorEntry();
    }
  }
}

class _AIRecipeGeneratorPageContent extends StatefulWidget {
  const _AIRecipeGeneratorPageContent();

  @override
  State<_AIRecipeGeneratorPageContent> createState() =>
      _AIRecipeGeneratorPageContentState();
}

class _AIRecipeGeneratorPageContentState
    extends State<_AIRecipeGeneratorPageContent> {
  final List<File> _selectedImages = [];
  final TextEditingController _promptController = TextEditingController();
  final TextEditingController _dietaryController = TextEditingController();
  final TextEditingController _cuisineController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();

  int _targetServings = 4;
  String _difficulty = 'Easy';
  int _maxPrepTime = 60;

  @override
  void dispose() {
    _promptController.dispose();
    _dietaryController.dispose();
    _cuisineController.dispose();
    _allergiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI RECIPE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF8C00),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: BlocListener<AIRecipeBloc, AIRecipeState>(
        listener: (context, state) {
          if (state is AIRecipeGenerated) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AIRecipeResultPage(meal: state.meal),
              ),
            );
          } else if (state is AIRecipeError) {
            // Show detailed error dialog instead of just SnackBar
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Row(
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(width: 8),
                    Text('AI Generator Error'),
                  ],
                ),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.photo_camera, color: Color(0xFFFF8C00)),
                          SizedBox(width: 8),
                          Text(
                            'Ingredient Images',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Text('• API key has been configured'),
                      const Text('• Images are selected and valid'),
                      const Text('• Please try again in a few minutes'),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigate to debug page
                      Navigator.of(context).pushNamed('/ai_recipe_debug');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8C00),
                    ),
                    child: const Text('Test API',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }
        },
        child: BlocBuilder<AIRecipeBloc, AIRecipeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildWelcomeCard(),
                  const SizedBox(height: 20),
                  _buildImageSection(),
                  const SizedBox(height: 20),
                  // Debug button for testing without images
                  if (_selectedImages.isEmpty) ...[
                    // ...removed debug/test feature...
                  ],
                  _buildPreferencesSection(),
                  const SizedBox(height: 30),
                  _buildGenerateButton(state),
                  if (state is AIRecipeGenerating) ...[
                    const SizedBox(height: 20),
                    _buildLoadingWidget(),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFFFF3E0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(
              Icons.auto_awesome,
              size: 48,
              color: Color(0xFFFF8C00),
            ),
            const SizedBox(height: 12),
            const Text(
              'AI Recipe Generator',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Take photos of ingredients and let AI create the perfect recipe for you!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.photo_camera, color: Color(0xFFFF8C00)),
                SizedBox(width: 8),
                Text(
                  'Ingredient Images',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ImagePickerWidget(
              selectedImages: _selectedImages,
              onImagesChanged: (images) {
                print('📸 Images changed: ${images.length} images selected');
                setState(() {
                  _selectedImages.clear();
                  _selectedImages.addAll(images);
                  print(
                      '📸 Updated _selectedImages: ${_selectedImages.length} images');
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.tune, color: Color(0xFFFF8C00)),
                SizedBox(width: 8),
                Text(
                  'Cooking Preferences',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            RecipePreferencesWidget(
              promptController: _promptController,
              dietaryController: _dietaryController,
              cuisineController: _cuisineController,
              allergiesController: _allergiesController,
              targetServings: _targetServings,
              difficulty: _difficulty,
              maxPrepTime: _maxPrepTime,
              onServingsChanged: (value) =>
                  setState(() => _targetServings = value),
              onDifficultyChanged: (value) =>
                  setState(() => _difficulty = value),
              onPrepTimeChanged: (value) =>
                  setState(() => _maxPrepTime = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerateButton(AIRecipeState state) {
    final isLoading = state is AIRecipeGenerating;
    final canGenerate = _selectedImages.isNotEmpty && !isLoading;

    print(
        '🔘 Button state: canGenerate=$canGenerate, isLoading=$isLoading, imagesCount=${_selectedImages.length}');

    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: canGenerate
            ? () {
                print('🔄 Button pressed, calling _generateRecipe');
                _generateRecipe();
              }
            : () {
                print(
                    '⚠️ Button pressed but disabled - canGenerate=$canGenerate');
                if (_selectedImages.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select at least one image first'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF8C00),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          disabledBackgroundColor: Colors.grey[300],
        ),
        child: isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text('Creating Recipe...'),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome),
                  SizedBox(width: 8),
                  Text(
                    'Generate AI Recipe',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const LinearProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF8C00)),
            ),
            const SizedBox(height: 16),
            Text(
              'AI is analyzing the image and generating the recipe...',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _generateRecipe() async {
    print('🔄 _generateRecipe: Starting...');

    // Validation cơ bản
    if (_selectedImages.isEmpty) {
      print('❌ No images selected');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one image'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    print('📷 Processing ${_selectedImages.length} selected images');

    // Validation hình ảnh
    bool hasInvalidImages = false;
    List<String> validImagePaths = [];

    for (File imageFile in _selectedImages) {
      try {
        // Kiểm tra file tồn tại
        if (!await imageFile.exists()) {
          hasInvalidImages = true;
          continue;
        }

        // Kiểm tra kích thước file (max 10MB)
        final fileSize = await imageFile.length();
        if (fileSize > 10 * 1024 * 1024) {
          hasInvalidImages = true;
          continue;
        }

        // Kiểm tra định dạng file
        final extension = imageFile.path.toLowerCase();
        if (!extension.endsWith('.jpg') &&
            !extension.endsWith('.jpeg') &&
            !extension.endsWith('.png')) {
          hasInvalidImages = true;
          continue;
        }

        validImagePaths.add(imageFile.path);
      } catch (e) {
        hasInvalidImages = true;
      }
    }

    if (validImagePaths.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 8),
              Text('Image Error'),
            ],
          ),
          content: const Text('No valid images to process.\n\n'
              'Please check:\n'
              '• File exists and is not corrupted\n'
              '• Format: JPG, JPEG, PNG\n'
              '• Size < 10MB\n'
              '• Select different images'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      );
      return;
    }

    if (hasInvalidImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Some invalid images were skipped. '
              'Using ${validImagePaths.length} valid images.'),
          backgroundColor: Colors.orange,
        ),
      );
    }

    final request = AIRecipeRequest(
      imageUrls: validImagePaths,
      userPrompt: _promptController.text.trim().isNotEmpty
          ? _promptController.text.trim()
          : null,
      dietaryRestrictions: _dietaryController.text.trim().isNotEmpty
          ? _dietaryController.text.trim()
          : null,
      preferredCuisine: _cuisineController.text.trim().isNotEmpty
          ? _cuisineController.text.trim()
          : null,
      allergies: _allergiesController.text.trim().isNotEmpty
          ? _allergiesController.text
              .trim()
              .split(',')
              .map((e) => e.trim())
              .toList()
          : null,
      targetServings: _targetServings,
      difficultyLevel: _difficulty,
      maxPrepTime: _maxPrepTime,
    );

    // Check if widget is still mounted and BLoC is available
    if (mounted) {
      try {
        final bloc = context.read<AIRecipeBloc>();
        if (!bloc.isClosed) {
          print('✅ BLoC is available, adding event');
          bloc.add(GenerateRecipeEvent(request));
        } else {
          print('⚠️ BLoC is closed, attempting to get new instance');
          // Try to get a new BLoC instance from DI
          try {
            final newBloc = AIRecipeGeneratorDI.instance.aiRecipeBloc;
            if (!newBloc.isClosed) {
              print('✅ Got new BLoC instance, adding event');
              newBloc.add(GenerateRecipeEvent(request));

              // Listen to the new BLoC for results
              newBloc.stream.listen((state) {
                if (mounted) {
                  if (state is AIRecipeGenerated) {
                    print('✅ Recipe generated, navigating to result');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<AIRecipeBloc>.value(
                          value: newBloc,
                          child: AIRecipeResultPage(meal: state.meal),
                        ),
                      ),
                    );
                  } else if (state is AIRecipeError) {
                    print('❌ Recipe generation error: ${state.message}');
                    _showErrorMessage(
                        'Recipe generation error: ${state.message}');
                  }
                }
              });
            } else {
              print('❌ New BLoC is also closed');
              _showErrorMessage(
                  'Error: Cannot connect to AI service. Please try again.');
            }
          } catch (e) {
            print('❌ Error getting new BLoC: $e');
            _showErrorMessage(
                'Error: Cannot initialize AI service. Please restart the app.');
          }
        }
      } catch (e) {
        print('❌ Error accessing BLoC: $e');
        _showErrorMessage(
            'Error: AI service not found. Please restart the app.');
      }
    } else {
      print('⚠️ Widget not mounted, skipping event');
    }
  }

  void _showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }
}
