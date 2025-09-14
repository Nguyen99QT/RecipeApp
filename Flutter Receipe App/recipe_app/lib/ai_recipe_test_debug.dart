import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AIRecipeTestDebugPage extends StatefulWidget {
  const AIRecipeTestDebugPage({super.key});

  @override
  State<AIRecipeTestDebugPage> createState() => _AIRecipeTestDebugPageState();
}

class _AIRecipeTestDebugPageState extends State<AIRecipeTestDebugPage> {
  String _debugInfo = '';
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Recipe Debug Test'),
        backgroundColor: const Color(0xFFFF8C00),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _testImagePicking,
              child: const Text('Test Image Picking & Base64'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _debugInfo.isEmpty
                        ? 'Chọn hình ảnh để test...'
                        : _debugInfo,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _testImagePicking() async {
    setState(() {
      _debugInfo = 'Bắt đầu test...\n';
    });

    try {
      // Pick image
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        setState(() {
          _debugInfo += 'Không có hình ảnh được chọn.\n';
        });
        return;
      }

      setState(() {
        _debugInfo += 'Hình ảnh được chọn: ${image.path}\n';
        _debugInfo += 'Tên file: ${image.name}\n';
      });

      // Test file reading
      final file = File(image.path);
      final exists = await file.exists();
      setState(() {
        _debugInfo += 'File tồn tại: $exists\n';
      });

      if (exists) {
        final bytes = await file.readAsBytes();
        setState(() {
          _debugInfo += 'Kích thước file: ${bytes.length} bytes\n';
        });

        // Test base64 conversion
        final base64Data = base64Encode(bytes);
        setState(() {
          _debugInfo += 'Base64 length: ${base64Data.length} characters\n';
          _debugInfo +=
              'Base64 preview (first 100 chars): ${base64Data.substring(0, base64Data.length > 100 ? 100 : base64Data.length)}\n';
        });

        // Test validation
        final isValid = _testBase64Validation(base64Data);
        setState(() {
          _debugInfo += 'Base64 validation passed: $isValid\n';
        });

        // Test specific checks
        setState(() {
          _debugInfo += '\n=== VALIDATION DETAILS ===\n';
          _debugInfo += 'Contains backslash: ${base64Data.contains('\\')}\n';
          _debugInfo += 'Contains C:: ${base64Data.contains('C:')}\n';
          _debugInfo += 'Contains D:: ${base64Data.contains('D:')}\n';
          _debugInfo += 'Contains .jpg: ${base64Data.contains('.jpg')}\n';
          _debugInfo += 'Contains .png: ${base64Data.contains('.png')}\n';
          _debugInfo += 'Length > 1000: ${base64Data.length > 1000}\n';
          _debugInfo += 'Starts with /: ${base64Data.startsWith('/')}\n';
          _debugInfo += 'Contains file://: ${base64Data.contains('file://')}\n';
        });

        // Test regex
        final base64Regex = RegExp(r'^[A-Za-z0-9+/]*={0,2}$');
        final regexMatch = base64Regex.hasMatch(base64Data);
        setState(() {
          _debugInfo += 'Regex match: $regexMatch\n';
        });

        if (!regexMatch) {
          // Find invalid characters
          final invalidChars = <String>[];
          for (int i = 0; i < base64Data.length; i++) {
            final char = base64Data[i];
            if (!base64Regex.hasMatch(char) &&
                char != '=' &&
                char != '+' &&
                char != '/') {
              if (!invalidChars.contains(char)) {
                invalidChars.add(char);
              }
            }
          }
          setState(() {
            _debugInfo +=
                'Invalid characters found: ${invalidChars.join(', ')}\n';
          });
        }

        setState(() {
          _debugInfo += '\n✅ Test hoàn thành!\n';
        });
      }
    } catch (e, stackTrace) {
      setState(() {
        _debugInfo += '\n❌ ERROR: $e\n';
        _debugInfo += 'Stack trace:\n$stackTrace\n';
      });
    }
  }

  bool _testBase64Validation(String str) {
    try {
      // Remove whitespace and check length
      final cleanStr = str.replaceAll(RegExp(r'\s+'), '');
      if (cleanStr.isEmpty || cleanStr.length % 4 != 0) {
        return false;
      }

      // Base64 string should be reasonably long for an image (at least 1000 chars)
      if (cleanStr.length < 1000) {
        return false;
      }

      // Should not contain obvious file path indicators
      if (cleanStr.contains('C:\\') ||
          cleanStr.contains('D:\\') ||
          cleanStr.contains('/data/user/') ||
          cleanStr.contains('/storage/emulated/') ||
          cleanStr.contains('file://') ||
          cleanStr.contains('.jpg') ||
          cleanStr.contains('.png') ||
          cleanStr.contains('.jpeg') ||
          cleanStr.contains('cache/') ||
          RegExp(r'^/[a-zA-Z]+/[a-zA-Z]+').hasMatch(cleanStr)) {
        return false;
      }

      // Check if string contains only valid base64 characters
      final base64Regex = RegExp(r'^[A-Za-z0-9+/]*={0,2}$');
      if (!base64Regex.hasMatch(cleanStr)) {
        return false;
      }

      // Try to decode it
      final decoded = base64Decode(cleanStr);

      // Additional check: decoded bytes should be reasonable size for an image
      if (decoded.length < 1000) {
        return false;
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
