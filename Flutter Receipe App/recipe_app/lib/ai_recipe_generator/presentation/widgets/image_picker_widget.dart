import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerWidget extends StatefulWidget {
  final List<File> selectedImages;
  final Function(List<File>) onImagesChanged;
  final int maxImages;

  const ImagePickerWidget({
    super.key,
    required this.selectedImages,
    required this.onImagesChanged,
    this.maxImages = 5,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.selectedImages.isNotEmpty) ...[
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.selectedImages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          widget.selectedImages[index],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: widget.selectedImages.length < widget.maxImages
                    ? () => _pickImage(ImageSource.camera)
                    : null,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take Photo'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFFF8C00),
                  side: const BorderSide(color: Color(0xFFFF8C00)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: widget.selectedImages.length < widget.maxImages
                    ? () => _pickImage(ImageSource.gallery)
                    : null,
                icon: const Icon(Icons.photo_library),
                label: const Text('Gallery'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFFF8C00),
                  side: const BorderSide(color: Color(0xFFFF8C00)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Selected ${widget.selectedImages.length}/${widget.maxImages} images',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        if (widget.selectedImages.isEmpty)
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
                style: BorderStyle.solid,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose ingredient images\nto create recipe',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.gallery) {
        // Cho phép chọn từng ảnh một từ gallery (vì pickMultipleImages có thể không hỗ trợ)
        final XFile? image = await _picker.pickImage(
          source: source,
          maxWidth: 1800,
          maxHeight: 1800,
          imageQuality: 85,
        );

        if (image != null) {
          final File imageFile = File(image.path);
          final List<File> updatedImages = List.from(widget.selectedImages);

          if (updatedImages.length < widget.maxImages) {
            updatedImages.add(imageFile);
            widget.onImagesChanged(updatedImages);
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tối đa ${widget.maxImages} hình ảnh'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          }
        }
      } else {
        // Chụp ảnh từ camera
        final XFile? image = await _picker.pickImage(
          source: source,
          maxWidth: 1800,
          maxHeight: 1800,
          imageQuality: 85,
        );

        if (image != null) {
          final File imageFile = File(image.path);
          final List<File> updatedImages = List.from(widget.selectedImages);

          if (updatedImages.length < widget.maxImages) {
            updatedImages.add(imageFile);
            widget.onImagesChanged(updatedImages);
          } else {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tối đa ${widget.maxImages} hình ảnh'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi khi chọn ảnh: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _removeImage(int index) {
    final List<File> updatedImages = List.from(widget.selectedImages)
      ..removeAt(index);
    widget.onImagesChanged(updatedImages);
  }
}
