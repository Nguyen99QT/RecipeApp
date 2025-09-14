void main() {
  // Test the buildImageUrl function with different cases

  print('Testing buildImageUrl function:');

  // Test case 1: Relative path
  String relativeImage = 'recipe_image.jpg';
  String fullUrl1 = buildImageUrl(relativeImage);
  print('1. Relative path: $relativeImage -> $fullUrl1');

  // Test case 2: HTTP URL
  String httpUrl = 'http://example.com/image.jpg';
  String fullUrl2 = buildImageUrl(httpUrl);
  print('2. HTTP URL: $httpUrl -> $fullUrl2');

  // Test case 3: HTTPS URL
  String httpsUrl = 'https://via.placeholder.com/400x300?text=AI+Cooking';
  String fullUrl3 = buildImageUrl(httpsUrl);
  print('3. HTTPS URL: $httpsUrl -> $fullUrl3');

  // Test case 4: Empty string
  String emptyImage = '';
  String fullUrl4 = buildImageUrl(emptyImage);
  print('4. Empty string: "$emptyImage" -> "$fullUrl4"');
}

// Helper function to build proper image URL
String buildImageUrl(String imagePath) {
  if (imagePath.isEmpty) {
    return '';
  }

  // If the image path is already a complete URL (starts with http or https)
  if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
    return imagePath;
  }

  // Otherwise, prepend the base image URL
  return 'http://10.0.2.2:8190/uploads/images/$imagePath';
}
