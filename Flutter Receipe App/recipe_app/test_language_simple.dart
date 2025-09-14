// Simple test for language detection logic
void main() {
  print('Testing Language Detection Logic');
  print('====================================');

  // Test cases
  List<Map<String, dynamic>> testCases = [
    {
      'input': 'Tôi muốn nấu món phở',
      'expected': 'Vietnamese',
      'description': 'Vietnamese text with diacritics'
    },
    {
      'input': 'bánh mì thịt nướng',
      'expected': 'Vietnamese',
      'description': 'Vietnamese food names'
    },
    {
      'input': 'I want to cook pasta',
      'expected': 'English',
      'description': 'Clear English intent'
    },
    {
      'input': 'recipe for chicken',
      'expected': 'English',
      'description': 'English cooking terms'
    },
    {
      'input': '',
      'expected': 'English',
      'description': 'Empty input - default to English'
    },
    {
      'input': 'chicken com tam',
      'expected': 'Vietnamese',
      'description': 'Mixed but contains Vietnamese food term'
    },
    {
      'input': 'how to make pizza',
      'expected': 'English',
      'description': 'English cooking instruction'
    },
    {
      'input': 'nấu cơm',
      'expected': 'Vietnamese',
      'description': 'Simple Vietnamese cooking term'
    },
  ];

  // Enhanced language detection logic (same as in datasource files)
  bool detectLanguageIsVietnamese(String text) {
    if (text.isEmpty) return false; // Default to English for empty input

    // Vietnamese character pattern
    final vietnamesePattern = RegExp(
        r'[àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđĐ]');

    // Strong English cooking keywords that should force English
    final englishKeywords = [
      'recipe',
      'cook',
      'how to make',
      'ingredients',
      'prepare',
      'bake',
      'fry',
      'grill',
      'roast'
    ];

    String lowerText = text.toLowerCase();

    // If contains English keywords, prefer English
    for (String keyword in englishKeywords) {
      if (lowerText.contains(keyword.toLowerCase())) {
        return false;
      }
    }

    // If contains Vietnamese characters, definitely Vietnamese
    if (vietnamesePattern.hasMatch(text)) {
      return true;
    }

    // Vietnamese food terms (even without diacritics)
    final vietnameseFoodTerms = [
      'pho',
      'banh',
      'com',
      'bun',
      'nem',
      'cha',
      'thit',
      'ga',
      'bo',
      'tom',
      'ca'
    ];
    for (String term in vietnameseFoodTerms) {
      if (lowerText.contains(term)) {
        return true;
      }
    }

    // Default to English (updated logic)
    return false;
  }

  // Run tests
  int passed = 0;
  int total = testCases.length;

  for (var testCase in testCases) {
    String input = testCase['input'];
    String expected = testCase['expected'];
    String description = testCase['description'];

    bool isVietnamese = detectLanguageIsVietnamese(input);
    String detected = isVietnamese ? 'Vietnamese' : 'English';

    bool testPassed = detected == expected;
    if (testPassed) passed++;

    String status = testPassed ? '✅ PASS' : '❌ FAIL';
    print('$status: $description');
    print('   Input: "$input"');
    print('   Expected: $expected, Got: $detected');
    print('');
  }

  print('Test Results: $passed/$total tests passed');
  if (passed == total) {
    print(
        '🎉 All tests passed! Language detection logic is working correctly.');
  } else {
    print('⚠️  Some tests failed. Logic may need adjustment.');
  }
}
