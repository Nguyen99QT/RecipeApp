import 'package:flutter/material.dart';
import 'ai_recipe_integration.dart';

/// Test page để kiểm tra AI Recipe Generator module
class TestAIRecipeGeneratorPage extends StatelessWidget {
  final String? geminiApiKey;

  const TestAIRecipeGeneratorPage({
    super.key,
    this.geminiApiKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Test AI Recipe Generator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFFFF8C00),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8C00), Color(0xFFFFB74D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: const Column(
                  children: [
                    Icon(
                      Icons.science,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'AI Recipe Generator Test',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Test các chức năng của module AI Recipe Generator',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Gemini API Key Status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.key, color: Color(0xFFFF8C00)),
                        SizedBox(width: 8),
                        Text(
                          'Gemini API Key Status',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: geminiApiKey != null && geminiApiKey!.isNotEmpty
                            ? Colors.orange.withOpacity(0.1)
                            : Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              geminiApiKey != null && geminiApiKey!.isNotEmpty
                                  ? Colors.orange
                                  : Colors.orange,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            geminiApiKey != null && geminiApiKey!.isNotEmpty
                                ? Icons.check_circle
                                : Icons.warning,
                            color:
                                geminiApiKey != null && geminiApiKey!.isNotEmpty
                                    ? Colors.orange
                                    : Colors.orange,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              geminiApiKey != null && geminiApiKey!.isNotEmpty
                                  ? 'API Key được cung cấp'
                                  : 'No API Key - AI features will be limited',
                              style: TextStyle(
                                color: geminiApiKey != null &&
                                        geminiApiKey!.isNotEmpty
                                    ? Colors.orange[700]
                                    : Colors.orange[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Test Actions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.play_arrow, color: Color(0xFFFF8C00)),
                        SizedBox(width: 8),
                        Text(
                          'Test Actions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Test Generate Recipe
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _testGenerateRecipe(context),
                        icon: const Icon(Icons.auto_awesome),
                        label: const Text('Test AI Recipe Generator'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8C00),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Test Saved Recipes
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _testSavedRecipes(context),
                        icon: const Icon(Icons.bookmark),
                        label: const Text('Test Danh Sách Đã Lưu'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFFF8C00),
                          side: const BorderSide(color: Color(0xFFFF8C00)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Integration Examples
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.integration_instructions,
                            color: Color(0xFFFF8C00)),
                        SizedBox(width: 8),
                        Text(
                          'Integration Examples',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Home Card Example:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AIRecipeIntegration.buildHomeCard(context,
                        geminiApiKey: geminiApiKey),
                    const SizedBox(height: 20),
                    const Text(
                      'Menu Items Example:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: AIRecipeIntegration.buildMenuItems(
                          context,
                          geminiApiKey: geminiApiKey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Feature Status
            _buildFeatureStatus(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureStatus() {
    final features = [
      {
        'name': 'AI Recipe Generation',
        'status': true,
        'description': 'Generate recipe from image'
      },
      {
        'name': 'Local Storage',
        'status': true,
        'description': 'Local recipe storage'
      },
      {
        'name': 'Search & Filter',
        'status': true,
        'description': 'Search and filter recipes'
      },
      {
        'name': 'Share Recipes',
        'status': true,
        'description': 'Share recipes'
      },
      {
        'name': 'Multi-image Support',
        'status': true,
        'description': 'Hỗ trợ nhiều hình ảnh'
      },
      {
        'name': 'Recipe Preferences',
        'status': true,
        'description': 'Tùy chỉnh sở thích'
      },
      {
        'name': 'Vietnamese UI',
        'status': true,
        'description': 'English interface'
      },
      {
        'name': 'Clean Architecture',
        'status': true,
        'description': 'Kiến trúc sạch với BLoC'
      },
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.checklist, color: Color(0xFFFF8C00)),
                SizedBox(width: 8),
                Text(
                  'Feature Status',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...features
                .map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            feature['status'] as bool
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: feature['status'] as bool
                                ? Colors.orange
                                : Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  feature['name'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  feature['description'] as String,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                ,
          ],
        ),
      ),
    );
  }

  void _testGenerateRecipe(BuildContext context) {
    // Navigate to AI Recipe Generator
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TestAIRecipeWrapper(
          geminiApiKey: geminiApiKey,
          testType: 'generate',
        ),
      ),
    );
  }

  void _testSavedRecipes(BuildContext context) {
    // Navigate to Saved AI Recipes
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TestAIRecipeWrapper(
          geminiApiKey: geminiApiKey,
          testType: 'saved',
        ),
      ),
    );
  }
}

/// Wrapper để test AI Recipe Generator pages
class TestAIRecipeWrapper extends StatelessWidget {
  final String? geminiApiKey;
  final String testType;

  const TestAIRecipeWrapper({
    super.key,
    this.geminiApiKey,
    required this.testType,
  });

  @override
  Widget build(BuildContext context) {
    switch (testType) {
      case 'generate':
        return MaterialApp(
          title: 'Test AI Recipe Generator',
          theme: ThemeData(
            primarySwatch: Colors.orange,
            fontFamily: 'SF Pro Display',
          ),
          home: Scaffold(
            body: const Center(
              child: Text('AI Recipe Generator Test'),
            ),
            floatingActionButton: AIRecipeIntegration.buildFloatingActionButton(
              context,
              geminiApiKey: geminiApiKey,
            ),
          ),
        );
      case 'saved':
        // Sử dụng navigation để mở saved recipes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AIRecipeIntegration.buildAppBarAction(context,
              geminiApiKey: geminiApiKey);
        });
        return const Scaffold(
          body: Center(
            child: Text('Navigating to Saved Recipes...'),
          ),
        );
      default:
        return const Scaffold(
          body: Center(
            child: Text('Unknown test type'),
          ),
        );
    }
  }
}
