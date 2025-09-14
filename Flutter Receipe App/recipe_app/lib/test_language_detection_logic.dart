import 'package:flutter/material.dart';

class LanguageDetectionTester {
  /// Test the new language detection logic
  static void testLanguageDetection() {
    print('\n🧪 Testing Language Detection Logic...\n');

    // Test cases
    final testCases = [
      // Vietnamese inputs - should use Vietnamese
      {
        'input': 'nấu phở bò',
        'expected': 'Vietnamese',
        'description': 'Clear Vietnamese text'
      },
      {
        'input': 'làm bánh mì thịt nướng',
        'expected': 'Vietnamese',
        'description': 'Vietnamese with diacritics'
      },
      {
        'input': 'tôi muốn nấu cơm',
        'expected': 'Vietnamese',
        'description': 'Vietnamese sentence'
      },

      // English inputs - should use English
      {
        'input': 'make chicken pasta',
        'expected': 'English',
        'description': 'Clear English text'
      },
      {
        'input': 'cook beef steak recipe',
        'expected': 'English',
        'description': 'English cooking terms'
      },
      {
        'input': 'prepare vegetable salad',
        'expected': 'English',
        'description': 'English preparation'
      },

      // Mixed or unclear inputs - should default to Vietnamese
      {
        'input': '',
        'expected': 'Vietnamese',
        'description': 'Empty input (image only)'
      },
      {
        'input': '123 abc',
        'expected': 'Vietnamese',
        'description': 'Numbers and letters only'
      },
      {
        'input': 'hello xin chào',
        'expected': 'Vietnamese',
        'description': 'Mixed English-Vietnamese'
      },

      // Edge cases
      {
        'input': 'pizza',
        'expected': 'Vietnamese',
        'description': 'Single word - not enough English context'
      },
      {
        'input': 'make bánh mì',
        'expected': 'Vietnamese',
        'description': 'English verb + Vietnamese noun'
      },
    ];

    for (var testCase in testCases) {
      final input = testCase['input'] as String;
      final expected = testCase['expected'] as String;
      final description = testCase['description'] as String;

      final result = _detectLanguage(input);
      final resultStr = result ? 'Vietnamese' : 'English';
      final status = resultStr == expected ? '✅ PASS' : '❌ FAIL';

      print('$status "$input" → $resultStr (Expected: $expected)');
      print('   📝 $description\n');
    }
  }

  /// Simulate the language detection logic
  static bool _detectLanguage(String promptText) {
    // Check for Vietnamese characters
    final hasVietnameseChars = RegExp(
            r'[àáảãạâầấẩẫậăằắẳẵặèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđ]')
        .hasMatch(promptText);

    // Check for common English words that indicate English intent
    final hasEnglishWords = promptText.isNotEmpty &&
        RegExp(r'\b(make|cook|recipe|prepare|ingredients|chicken|beef|pork|fish|vegetable|rice|noodle|soup|salad|pasta|pizza|bread|cake|dessert)\b',
                caseSensitive: false)
            .hasMatch(promptText);

    // Use Vietnamese by default, English only if explicitly English and no Vietnamese chars
    final useVietnamese =
        promptText.isEmpty || hasVietnameseChars || !hasEnglishWords;

    return useVietnamese;
  }
}
