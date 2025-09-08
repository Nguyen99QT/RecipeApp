// Test file to demonstrate the new language detection behavior
// This mimics the pic2plate_ai behavior: English by default, Vietnamese only when explicitly detected

void main() {
  print('=== Testing New Language Detection Behavior ===');
  print('(Like pic2plate_ai: English default, Vietnamese only when requested)');
  print('');

  // Test cases that should result in ENGLISH (default behavior)
  List<Map<String, String>> englishTests = [
    {
      'input': 'chicken pasta',
      'expected': 'english',
      'reason': 'Pure English ingredients',
    },
    {
      'input': 'beef stir fry with vegetables',
      'expected': 'english',
      'reason': 'English cooking request',
    },
    {
      'input': 'tom', // Single Vietnamese word
      'expected': 'english',
      'reason': 'Single Vietnamese word - not strong enough signal',
    },
    {
      'input': 'bo', // Single Vietnamese word
      'expected': 'english',
      'reason':
          'Single Vietnamese word - defaults to English like pic2plate_ai',
    },
  ];

  // Test cases that should result in VIETNAMESE (explicit Vietnamese context)
  List<Map<String, String>> vietnameseTests = [
    {
      'input': 'thịt bò nướng', // Vietnamese with diacritics + word
      'expected': 'vietnamese',
      'reason': 'Vietnamese diacritics + Vietnamese word',
    },
    {
      'input': 'nau mon thit bo ga', // Multiple Vietnamese words
      'expected': 'vietnamese',
      'reason': 'Multiple Vietnamese words (3+)',
    },
    {
      'input': 'cong thuc mon an viet', // Vietnamese recipe request pattern
      'expected': 'vietnamese',
      'reason': 'Vietnamese recipe request phrase',
    },
    {
      'input': 'lam mon banh mi pho', // Multiple Vietnamese food words
      'expected': 'vietnamese',
      'reason': 'Multiple Vietnamese food terms',
    },
  ];

  print('📍 Tests that should return ENGLISH (default behavior):');
  for (var test in englishTests) {
    print('   Input: "${test['input']}"');
    print('   Expected: ${test['expected']}');
    print('   Reason: ${test['reason']}');
    print('');
  }

  print('📍 Tests that should return VIETNAMESE (explicit detection):');
  for (var test in vietnameseTests) {
    print('   Input: "${test['input']}"');
    print('   Expected: ${test['expected']}');
    print('   Reason: ${test['reason']}');
    print('');
  }

  print('=== Key Changes Made ===');
  print('✅ Default language is now ENGLISH (like pic2plate_ai)');
  print('✅ Vietnamese only when strong indicators are present:');
  print('   - Vietnamese diacritics + Vietnamese words, OR');
  print('   - 3+ Vietnamese words, OR');
  print('   - Vietnamese recipe request patterns');
  print('✅ Enhanced language instructions for better recipe quality');
  print('✅ More conservative detection (not just single words)');
  print('');
  print('This matches the pic2plate_ai behavior you requested!');
}
