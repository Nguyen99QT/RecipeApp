
void main() {
  // Test Vietnamese language detection
  print('=== Testing Vietnamese Language Detection ===');

  // Test Vietnamese text
  const vietnameseText = 'Tôi muốn nấu món phở bò';
  final vietnameseRegex = RegExp(
      r'[àáảãạâầấẩẫậăằắẳẵặèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđ]');
  final isVietnamese1 = vietnameseRegex.hasMatch(vietnameseText);
  print('Vietnamese text: "$vietnameseText" -> $isVietnamese1');

  // Test English text
  const englishText = 'I want to cook beef soup';
  final isVietnamese2 = vietnameseRegex.hasMatch(englishText);
  print('English text: "$englishText" -> $isVietnamese2');

  // Test mixed text
  const mixedText = 'I want phở bò';
  final isVietnamese3 = vietnameseRegex.hasMatch(mixedText);
  print('Mixed text: "$mixedText" -> $isVietnamese3');

  // Test empty text
  const emptyText = '';
  final isVietnamese4 = vietnameseRegex.hasMatch(emptyText);
  print('Empty text: "$emptyText" -> $isVietnamese4');

  print('\n=== Expected Results ===');
  print('Vietnamese text -> true (should use Vietnamese prompts)');
  print('English text -> false (should use English prompts)');
  print('Mixed text -> true (should use Vietnamese prompts)');
  print('Empty text -> false (should use English prompts - default)');

  print('\n=== Language Detection Logic Summary ===');
  print('✅ User input contains Vietnamese chars -> Vietnamese output');
  print('✅ User input is English only -> English output');
  print('✅ User input is empty (image only) -> English output (default)');
}
