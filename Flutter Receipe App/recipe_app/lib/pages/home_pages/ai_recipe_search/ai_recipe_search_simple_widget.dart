import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/utils/vietnamese_input_helper.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AiRecipeSearchWidget extends StatefulWidget {
  const AiRecipeSearchWidget({super.key});

  @override
  State<AiRecipeSearchWidget> createState() => _AiRecipeSearchWidgetState();
}

class _AiRecipeSearchWidgetState extends State<AiRecipeSearchWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // AI Recipe Search Properties
  List<XFile> _selectedImages = [];
  final TextEditingController _ingredientsController = TextEditingController();
  int _peopleCount = 2;
  int _cookingTime = 30;
  String? _dietaryRestrictions;
  bool _isLoading = false;
  List<String> _generatedRecipes = [];
  String _inputMode = 'none'; // 'none', 'text', 'images'

  @override
  void dispose() {
    _ingredientsController.dispose();
    super.dispose();
  }

  // Image picker methods
  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage(limit: 5);

    if (images.isNotEmpty) {
      setState(() {
        _selectedImages = images;
        _inputMode = 'images';
        _ingredientsController.clear();
      });
    }
  }

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _selectedImages = [image];
        _inputMode = 'images';
        _ingredientsController.clear();
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
      if (_selectedImages.isEmpty) {
        _inputMode = 'none';
      }
    });
  }

  void _clearAllImages() {
    setState(() {
      _selectedImages.clear();
      _inputMode = 'none';
    });
  }

  void _onTextChanged(String text) {
    setState(() {
      if (text.isNotEmpty) {
        _inputMode = 'text';
        _selectedImages.clear();
      } else {
        _inputMode = 'none';
      }
    });
  }

  // Mock AI Recipe Generation
  Future<void> _generateRecipes() async {
    if ((_selectedImages.isEmpty &&
        _ingredientsController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please add images or describe ingredients')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock recipes based on input
      String ingredients = _ingredientsController.text.isNotEmpty
          ? _ingredientsController.text
          : 'ingredients from uploaded images';

      List<String> mockRecipes = [
        '''Delicious Stir-Fry Recipe

Ingredients:
• ${ingredients.split(',').take(3).join('\n• ')}
• Soy sauce, Garlic, Ginger
• Vegetable oil

Instructions:
1. Heat oil in a large pan or wok
2. Add garlic and ginger, stir-fry for 30 seconds
3. Add main ingredients and cook for 5-7 minutes
4. Add soy sauce and seasonings
5. Serve hot over rice

Prep Time: 10 minutes | Cook Time: 15 minutes
Serves: $_peopleCount people | Difficulty: Easy''',
        '''Quick Soup Recipe

Ingredients:
• ${ingredients.split(',').take(2).join('\n• ')}
• Broth or stock, Onions
• Salt, pepper, and herbs

Instructions:
1. Sauté onions until translucent
2. Add main ingredients and cook for 5 minutes
3. Pour in broth and bring to boil
4. Simmer for 15-20 minutes
5. Season with salt, pepper, and herbs

Prep Time: 5 minutes | Cook Time: 25 minutes
Serves: $_peopleCount people | Difficulty: Easy''',
        '''Healthy Salad Bowl

Ingredients:
• ${ingredients.split(',').take(4).join('\n• ')}
• Mixed greens, Olive oil
• Lemon juice, Seasonings

Instructions:
1. Wash and prepare all fresh ingredients
2. Arrange ingredients in a bowl
3. Whisk olive oil with lemon juice
4. Drizzle dressing over salad
5. Toss gently and serve immediately

Prep Time: 15 minutes | Cook Time: 0 minutes
Serves: $_peopleCount people | Difficulty: Very Easy'''
      ];

      setState(() {
        _generatedRecipes = mockRecipes;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating recipes: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Save recipe to favorites (mock implementation)
  Future<void> _saveRecipeToFavorites(String recipeContent) async {
    try {
      // Extract recipe name from content (first line usually)
      String recipeName = recipeContent.split('\n').first.trim();

      // Mock save - in real implementation, call your API here
      await Future.delayed(const Duration(milliseconds: 500));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('\"$recipeName\" saved to favorites!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving recipe: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => context.safePop(),
          ),
          title: Text(
            'AI Recipe Search',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Inter Tight',
                  color: Colors.white,
                  fontSize: 22,
                ),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Introduction Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        FlutterFlowTheme.of(context).primary.withOpacity(0.1),
                        FlutterFlowTheme.of(context).secondary.withOpacity(0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 40,
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'AI-Powered Recipe Creator',
                        style: FlutterFlowTheme.of(context).headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Upload photos of your ingredients or describe them, and let AI create amazing recipes for you!',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Input Method Selection
                Text(
                  'Choose Your Input Method',
                  style: FlutterFlowTheme.of(context).titleMedium,
                ),
                const SizedBox(height: 12),

                // Image Input Section
                if (_inputMode != 'text') ...[
                  Row(
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: _pickImages,
                          text: 'Choose Photos',
                          icon: const Icon(Icons.photo_library),
                          options: FFButtonOptions(
                            height: 50,
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color: Colors.white,
                                ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: _takePicture,
                          text: 'Take Photo',
                          icon: const Icon(Icons.camera_alt),
                          options: FFButtonOptions(
                            height: 50,
                            color: FlutterFlowTheme.of(context).secondary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Inter Tight',
                                  color: Colors.white,
                                ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Selected Images Grid
                  if (_selectedImages.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Selected Images (${_selectedImages.length}/5)',
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                              if (_selectedImages.length > 1)
                                TextButton(
                                  onPressed: _clearAllImages,
                                  child: Text(
                                    'Clear All',
                                    style: TextStyle(
                                        color:
                                            FlutterFlowTheme.of(context).error),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children:
                                _selectedImages.asMap().entries.map((entry) {
                              final index = entry.key;
                              final image = entry.value;
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      File(image.path),
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () => _removeImage(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],

                // Text Input Section
                if (_inputMode != 'images') ...[
                  const SizedBox(height: 16),
                  Text(
                    'Or describe your ingredients:',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _ingredientsController,
                    onChanged: _onTextChanged,
                    inputFormatters: VietnameseInputHelper.vietnameseFormatters,
                    maxLines: 4,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText:
                          'VD: thịt gà, cà chua, hành tây, tỏi, dầu ô liu...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ),
                ],

                const SizedBox(height: 24),

                // Cooking Parameters
                Text(
                  'Cooking Preferences',
                  style: FlutterFlowTheme.of(context).titleMedium,
                ),
                const SizedBox(height: 12),

                // People Count
                Text('Number of People: $_peopleCount'),
                Slider(
                  value: _peopleCount.toDouble(),
                  min: 1,
                  max: 8,
                  divisions: 7,
                  label: '$_peopleCount people',
                  onChanged: (value) {
                    setState(() {
                      _peopleCount = value.round();
                    });
                  },
                ),

                // Cooking Time
                Text('Maximum Cooking Time: $_cookingTime minutes'),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [15, 30, 45, 60].map((time) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text('${time}m'),
                          selected: _cookingTime == time,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _cookingTime = time;
                              });
                            }
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 16),

                // Dietary Restrictions
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _dietaryRestrictions = value;
                    });
                  },
                  inputFormatters: VietnameseInputHelper.vietnameseFormatters,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: 'Dietary restrictions (Optional)',
                    hintText: 'VD: chay, không gluten, không có hạt...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Generate Button
                SizedBox(
                  width: double.infinity,
                  child: FFButtonWidget(
                    onPressed: (_inputMode != 'none' && !_isLoading)
                        ? _generateRecipes
                        : null,
                    text: _isLoading
                        ? 'Generating Recipes...'
                        : 'Generate Recipes with AI',
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.auto_awesome),
                    options: FFButtonOptions(
                      height: 56,
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Inter Tight',
                                color: Colors.white,
                              ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Generated Recipes
                if (_generatedRecipes.isNotEmpty) ...[
                  Text(
                    'Generated Recipes',
                    style: FlutterFlowTheme.of(context).titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ..._generatedRecipes.asMap().entries.map((entry) {
                    final index = entry.key;
                    final recipe = entry.value;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Recipe ${index + 1}',
                                  style:
                                      FlutterFlowTheme.of(context).titleMedium,
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () => _saveRecipeToFavorites(recipe),
                                text: 'Save',
                                icon:
                                    const Icon(Icons.favorite_border, size: 16),
                                options: FFButtonOptions(
                                  height: 32,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      12, 0, 12, 0),
                                  color: FlutterFlowTheme.of(context).accent1,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .override(
                                        fontFamily: 'Inter',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            recipe,
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
