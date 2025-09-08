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
        backgroundColor: const Color(0xFF4CAF50),
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
                    colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
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
                      'Tạo công thức nấu ăn từ hình ảnh với AI',
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
                color: _getApiKeyStatus() == 'Đã cấu hình'
                    ? Colors.green.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: _getApiKeyStatus() == 'Đã cấu hình'
                        ? Colors.green
                        : Colors.orange),
              ),
              child: Row(
                children: [
                  Icon(
                    _getApiKeyStatus() == 'Đã cấu hình'
                        ? Icons.check_circle
                        : Icons.info,
                    color: _getApiKeyStatus() == 'Đã cấu hình'
                        ? Colors.green
                        : Colors.orange,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _getApiKeyStatus() == 'Đã cấu hình'
                          ? 'Gemini API Key đã được cấu hình. Sẵn sàng sử dụng AI!'
                          : 'Cần Gemini API Key để sử dụng tính năng AI. Hãy cấu hình trong file .env',
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
                  'Tạo Công Thức AI',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
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
                  'Xem Công Thức Đã Lưu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF4CAF50),
                  side: const BorderSide(color: Color(0xFF4CAF50), width: 2),
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
                      'Tính năng có sẵn:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...[
                      '✅ Tạo công thức từ nhiều hình ảnh',
                      '✅ Tùy chọn sở thích ăn uống',
                      '✅ Lưu trữ công thức cục bộ',
                      '✅ Tìm kiếm và lọc công thức',
                      '✅ Chia sẻ công thức',
                      '✅ Giao diện tiếng Việt',
                      '✅ Clean Architecture với BLoC',
                      '⚠️ Gemini AI (cần API Key)',
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
      return 'Đã cấu hình';
    }
    return 'Chưa cấu hình';
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
