import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../../domain/entities/ai_recipe_request.dart';
import '../blocs/ai_recipe_bloc.dart';
import '../widgets/image_picker_widget.dart';
import '../widgets/recipe_preferences_widget.dart';
import 'ai_recipe_result_page.dart';
import '../../ai_recipe_generator_main.dart';

class AIRecipeGeneratorPage extends StatefulWidget {
  const AIRecipeGeneratorPage({super.key});

  @override
  State<AIRecipeGeneratorPage> createState() => _AIRecipeGeneratorPageState();
}

class _AIRecipeGeneratorPageState extends State<AIRecipeGeneratorPage> {
  @override
  Widget build(BuildContext context) {
    // Check if we already have AIRecipeBloc in context
    try {
      final bloc = context.read<AIRecipeBloc>();
      if (!bloc.isClosed) {
        // If we have it and it's not closed, use the original page
        return const _AIRecipeGeneratorPageContent();
      } else {
        print('⚠️ Found closed BLoC, creating new provider wrapper');
        return const AIRecipeGeneratorEntry();
      }
    } catch (e) {
      // If we don't have it, wrap with provider
      print('🔄 No AIRecipeBloc found, creating provider wrapper');
      return const AIRecipeGeneratorEntry();
    }
  }
}

class _AIRecipeGeneratorPageContent extends StatefulWidget {
  const _AIRecipeGeneratorPageContent();

  @override
  State<_AIRecipeGeneratorPageContent> createState() =>
      _AIRecipeGeneratorPageContentState();
}

class _AIRecipeGeneratorPageContentState
    extends State<_AIRecipeGeneratorPageContent> {
  final List<File> _selectedImages = [];
  final TextEditingController _promptController = TextEditingController();
  final TextEditingController _dietaryController = TextEditingController();
  final TextEditingController _cuisineController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();

  int _targetServings = 4;
  String _difficulty = 'Dễ';
  int _maxPrepTime = 60;

  @override
  void dispose() {
    _promptController.dispose();
    _dietaryController.dispose();
    _cuisineController.dispose();
    _allergiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tạo Công Thức AI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: BlocListener<AIRecipeBloc, AIRecipeState>(
        listener: (context, state) {
          if (state is AIRecipeGenerated) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AIRecipeResultPage(meal: state.meal),
              ),
            );
          } else if (state is AIRecipeError) {
            // Hiển thị dialog lỗi chi tiết thay vì chỉ SnackBar
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Row(
                  children: [
                    Icon(Icons.error, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Lỗi AI Generator'),
                  ],
                ),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Chi tiết lỗi:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(state.message),
                      const SizedBox(height: 16),
                      const Text(
                        'Vui lòng kiểm tra:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text('• Kết nối internet'),
                      const Text('• API key đã được cấu hình'),
                      const Text('• Hình ảnh được chọn hợp lệ'),
                      const Text('• Thử lại sau vài phút'),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Đóng'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigate to debug page
                      Navigator.of(context).pushNamed('/ai_recipe_debug');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                    ),
                    child: const Text('Kiểm tra API',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          }
        },
        child: BlocBuilder<AIRecipeBloc, AIRecipeState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildWelcomeCard(),
                  const SizedBox(height: 20),
                  _buildImageSection(),
                  const SizedBox(height: 20),
                  // Debug button for testing without images
                  if (_selectedImages.isEmpty) ...[
                    SizedBox(
                      height: 40,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          print('🧪 Debug: Testing with mock image');
                          setState(() {
                            // Add a mock image file for testing
                            _selectedImages.add(File('/mock/image.jpg'));
                          });
                        },
                        icon: const Icon(Icons.bug_report),
                        label: const Text('Debug: Add Mock Image'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey[600],
                          side: BorderSide(color: Colors.grey[400]!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  _buildPreferencesSection(),
                  const SizedBox(height: 30),
                  _buildGenerateButton(state),
                  if (state is AIRecipeGenerating) ...[
                    const SizedBox(height: 20),
                    _buildLoadingWidget(),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFF1F8E9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(
              Icons.auto_awesome,
              size: 48,
              color: Color(0xFF4CAF50),
            ),
            const SizedBox(height: 12),
            const Text(
              'Tạo Công Thức Với AI',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Chụp ảnh nguyên liệu và để AI tạo công thức nấu ăn phù hợp cho bạn!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.photo_camera, color: Color(0xFF4CAF50)),
                SizedBox(width: 8),
                Text(
                  'Hình Ảnh Nguyên Liệu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ImagePickerWidget(
              selectedImages: _selectedImages,
              onImagesChanged: (images) {
                print('📸 Images changed: ${images.length} images selected');
                setState(() {
                  _selectedImages.clear();
                  _selectedImages.addAll(images);
                  print(
                      '📸 Updated _selectedImages: ${_selectedImages.length} images');
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.tune, color: Color(0xFF4CAF50)),
                SizedBox(width: 8),
                Text(
                  'Tùy Chọn Chi Tiết',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            RecipePreferencesWidget(
              promptController: _promptController,
              dietaryController: _dietaryController,
              cuisineController: _cuisineController,
              allergiesController: _allergiesController,
              targetServings: _targetServings,
              difficulty: _difficulty,
              maxPrepTime: _maxPrepTime,
              onServingsChanged: (value) =>
                  setState(() => _targetServings = value),
              onDifficultyChanged: (value) =>
                  setState(() => _difficulty = value),
              onPrepTimeChanged: (value) =>
                  setState(() => _maxPrepTime = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenerateButton(AIRecipeState state) {
    final isLoading = state is AIRecipeGenerating;
    final canGenerate = _selectedImages.isNotEmpty && !isLoading;

    print(
        '🔘 Button state: canGenerate=$canGenerate, isLoading=$isLoading, imagesCount=${_selectedImages.length}');

    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: canGenerate
            ? () {
                print('🔄 Button pressed, calling _generateRecipe');
                _generateRecipe();
              }
            : () {
                print(
                    '⚠️ Button pressed but disabled - canGenerate=$canGenerate');
                if (_selectedImages.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng chọn ít nhất một hình ảnh trước'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          disabledBackgroundColor: Colors.grey[300],
        ),
        child: isLoading
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text('Đang Tạo Công Thức...'),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.auto_awesome),
                  SizedBox(width: 8),
                  Text(
                    'Tạo Công Thức AI',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const LinearProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
            ),
            const SizedBox(height: 16),
            Text(
              'AI đang phân tích hình ảnh và tạo công thức...',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _generateRecipe() async {
    print('🔄 _generateRecipe: Starting...');

    // Validation cơ bản
    if (_selectedImages.isEmpty) {
      print('❌ No images selected');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn ít nhất một hình ảnh'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    print('📷 Processing ${_selectedImages.length} selected images');

    // Validation hình ảnh
    bool hasInvalidImages = false;
    List<String> validImagePaths = [];

    for (File imageFile in _selectedImages) {
      try {
        // Kiểm tra file tồn tại
        if (!await imageFile.exists()) {
          hasInvalidImages = true;
          continue;
        }

        // Kiểm tra kích thước file (max 10MB)
        final fileSize = await imageFile.length();
        if (fileSize > 10 * 1024 * 1024) {
          hasInvalidImages = true;
          continue;
        }

        // Kiểm tra định dạng file
        final extension = imageFile.path.toLowerCase();
        if (!extension.endsWith('.jpg') &&
            !extension.endsWith('.jpeg') &&
            !extension.endsWith('.png')) {
          hasInvalidImages = true;
          continue;
        }

        validImagePaths.add(imageFile.path);
      } catch (e) {
        hasInvalidImages = true;
      }
    }

    if (validImagePaths.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.warning, color: Colors.orange),
              SizedBox(width: 8),
              Text('Lỗi Hình Ảnh'),
            ],
          ),
          content: const Text('Không có hình ảnh hợp lệ để xử lý.\n\n'
              'Vui lòng kiểm tra:\n'
              '• File tồn tại và không bị hỏng\n'
              '• Định dạng: JPG, JPEG, PNG\n'
              '• Kích thước < 10MB\n'
              '• Chọn lại hình ảnh khác'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
      return;
    }

    if (hasInvalidImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Một số hình ảnh không hợp lệ đã bị bỏ qua. '
              'Sử dụng ${validImagePaths.length} hình ảnh hợp lệ.'),
          backgroundColor: Colors.orange,
        ),
      );
    }

    final request = AIRecipeRequest(
      imageUrls: validImagePaths,
      userPrompt: _promptController.text.trim().isNotEmpty
          ? _promptController.text.trim()
          : null,
      dietaryRestrictions: _dietaryController.text.trim().isNotEmpty
          ? _dietaryController.text.trim()
          : null,
      preferredCuisine: _cuisineController.text.trim().isNotEmpty
          ? _cuisineController.text.trim()
          : null,
      allergies: _allergiesController.text.trim().isNotEmpty
          ? _allergiesController.text
              .trim()
              .split(',')
              .map((e) => e.trim())
              .toList()
          : null,
      targetServings: _targetServings,
      difficultyLevel: _difficulty,
      maxPrepTime: _maxPrepTime,
    );

    // Check if widget is still mounted and BLoC is available
    if (mounted) {
      try {
        final bloc = context.read<AIRecipeBloc>();
        if (!bloc.isClosed) {
          print('✅ BLoC is available, adding event');
          bloc.add(GenerateRecipeEvent(request));
        } else {
          print('⚠️ BLoC is closed, attempting to get new instance');
          // Try to get a new BLoC instance from DI
          try {
            final newBloc = AIRecipeGeneratorDI.instance.aiRecipeBloc;
            if (!newBloc.isClosed) {
              print('✅ Got new BLoC instance, adding event');
              newBloc.add(GenerateRecipeEvent(request));

              // Listen to the new BLoC for results
              newBloc.stream.listen((state) {
                if (mounted) {
                  if (state is AIRecipeGenerated) {
                    print('✅ Recipe generated, navigating to result');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider<AIRecipeBloc>.value(
                          value: newBloc,
                          child: AIRecipeResultPage(meal: state.meal),
                        ),
                      ),
                    );
                  } else if (state is AIRecipeError) {
                    print('❌ Recipe generation error: ${state.message}');
                    _showErrorMessage('Lỗi tạo công thức: ${state.message}');
                  }
                }
              });
            } else {
              print('❌ New BLoC is also closed');
              _showErrorMessage(
                  'Lỗi: Không thể kết nối đến AI service. Vui lòng thử lại.');
            }
          } catch (e) {
            print('❌ Error getting new BLoC: $e');
            _showErrorMessage(
                'Lỗi: Không thể khởi tạo AI service. Vui lòng restart app.');
          }
        }
      } catch (e) {
        print('❌ Error accessing BLoC: $e');
        _showErrorMessage(
            'Lỗi: Không tìm thấy AI service. Vui lòng restart app.');
      }
    } else {
      print('⚠️ Widget not mounted, skipping event');
    }
  }

  void _showErrorMessage(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }
}
