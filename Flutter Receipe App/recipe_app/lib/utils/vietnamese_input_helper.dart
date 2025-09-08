import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Helper class để cải thiện input experience cho tiếng Việt
class VietnameseInputHelper {
  /// Text input formatter để hỗ trợ tiếng Việt tốt hơn
  static List<TextInputFormatter> get vietnameseFormatters => [
        // Cho phép Unicode characters (tiếng Việt)
        FilteringTextInputFormatter.allow(RegExp(r'[\u0000-\uFFFF]')),
      ];

  /// Input decoration mặc định cho tiếng Việt
  static InputDecoration vietnameseInputDecoration({
    required String labelText,
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color focusColor = const Color(0xFF4CAF50),
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: focusColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
    );
  }

  /// Text input properties tối ưu cho tiếng Việt
  static Map<String, dynamic> get vietnameseTextProperties => {
        'textCapitalization': TextCapitalization.sentences,
        'keyboardType': TextInputType.text,
        'textInputAction': TextInputAction.next,
      };

  /// Search input properties
  static Map<String, dynamic> get searchTextProperties => {
        'textCapitalization': TextCapitalization.sentences,
        'keyboardType': TextInputType.text,
        'textInputAction': TextInputAction.search,
      };

  /// Multiline input properties
  static Map<String, dynamic> get multilineTextProperties => {
        'textCapitalization': TextCapitalization.sentences,
        'keyboardType': TextInputType.multiline,
        'textInputAction': TextInputAction.newline,
      };
}
