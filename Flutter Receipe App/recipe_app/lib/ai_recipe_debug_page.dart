import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ai_recipe_generator/ai_recipe_generator_main.dart';
import 'ai_recipe_test_debug.dart';

/// Debug page để test AI Recipe Generator module
class AIRecipeDebugPage extends StatelessWidget {
  const AIRecipeDebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Recipe Generator Debug',
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
            // Header
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8C00), Color(0xFFFFB347)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: const Column(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'AI Recipe Generator',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Create cooking recipes from images with AI',
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

            const SizedBox(height: 32),

            // Gemini API Key Status
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getApiKeyStatus() == 'Configured'
                    ? Colors.orange.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: _getApiKeyStatus() == 'Configured'
                        ? Colors.orange
                        : Colors.orange),
              ),
              child: Row(
                children: [
                  Icon(
                    _getApiKeyStatus() == 'Configured'
                        ? Icons.check_circle
                        : Icons.info,
                    color: _getApiKeyStatus() == 'Configured'
                        ? Colors.orange
                        : Colors.orange,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _getApiKeyStatus() == 'Configured'
                          ? 'Gemini API Key is configured. Ready to use AI!'
                          : 'Need Gemini API Key to use AI features. Please configure in .env file',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Test Buttons
            SizedBox(
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () => _openAIRecipeGenerator(context),
                icon: const Icon(Icons.auto_awesome),
                label: const Text(
                  'Create AI Recipe',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8C00),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () => _openSavedRecipes(context),
                icon: const Icon(Icons.bookmark),
                label: const Text(
                  'View Saved Recipes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFFF8C00),
                  side: const BorderSide(color: Color(0xFFFF8C00), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () => _openTestDebug(context),
                icon: const Icon(Icons.bug_report),
                label: const Text(
                  'Test Base64 Debug',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange,
                  side: const BorderSide(color: Colors.orange, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Features List
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Available Features:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...[
                      '✅ Create recipes from multiple images',
                      '✅ Customizable food preferences',
                      '✅ Local recipe storage',
                      '✅ Search and filter recipes',
                      '✅ Share recipes',
                      '✅ Vietnamese interface',
                      '✅ Clean Architecture with BLoC',
                      '⚠️ Gemini AI (requires API Key)',
                    ].map((feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            feature,
                            style: TextStyle(
                              fontSize: 14,
                              color: feature.startsWith('⚠️')
                                  ? Colors.orange[700]
                                  : Colors.grey[700],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getApiKeyStatus() {
    final apiKey = dotenv.env['PALM_API_KEY'];
    if (apiKey != null &&
        apiKey.isNotEmpty &&
        apiKey != 'your_actual_gemini_api_key_here') {
      return 'Configured';
    }
    return 'Not configured';
  }

  void _openAIRecipeGenerator(BuildContext context) {
    final apiKey = dotenv.env['PALM_API_KEY'];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AIRecipeGeneratorEntry(geminiApiKey: apiKey),
      ),
    );
  }

  void _openSavedRecipes(BuildContext context) {
    final apiKey = dotenv.env['PALM_API_KEY'];
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SavedAIRecipesEntry(geminiApiKey: apiKey),
      ),
    );
  }

  void _openTestDebug(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AIRecipeTestDebugPage(),
      ),
    );
  }
}
