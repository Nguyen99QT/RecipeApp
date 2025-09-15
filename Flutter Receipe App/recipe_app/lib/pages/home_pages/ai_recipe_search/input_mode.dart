// Input modes for AI recipe generation
enum InputMode {
  none,
  text,
  image,
  multipleImages,
  multiImages // Alias for multipleImages
}

// Extension methods for InputMode
extension InputModeExtension on InputMode {
  String get displayName {
    switch (this) {
      case InputMode.none:
        return 'No Input';
      case InputMode.text:
        return 'Text Input';
      case InputMode.image:
        return 'Single Image';
      case InputMode.multipleImages:
      case InputMode.multiImages:
        return 'Multiple Images';
    }
  }

  String get description {
    switch (this) {
      case InputMode.none:
        return 'No input selected';
      case InputMode.text:
        return 'Enter ingredients as text';
      case InputMode.image:
        return 'Upload a single image';
      case InputMode.multipleImages:
      case InputMode.multiImages:
        return 'Upload multiple images';
    }
  }
}
