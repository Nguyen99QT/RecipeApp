import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomYouTubePlayer extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;

  const CustomYouTubePlayer({
    Key? key,
    required this.url,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<CustomYouTubePlayer> createState() => _CustomYouTubePlayerState();
}

class _CustomYouTubePlayerState extends State<CustomYouTubePlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  bool _hasError = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> _initializePlayer() async {
    try {
      print('[DEBUG] Custom YouTube Player: Initializing with URL: ${widget.url}');
      
      // Extract video ID and convert to direct YouTube URL
      final videoId = _extractVideoId(widget.url);
      if (videoId == null) {
        throw Exception('Invalid YouTube URL');
      }

      // Try direct video streaming (this might not work due to YouTube restrictions)
      final directUrl = 'https://www.youtube.com/watch?v=$videoId';
      
      _videoController = VideoPlayerController.networkUrl(Uri.parse(directUrl));
      
      await _videoController!.initialize();
      
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: false,
        looping: false,
        showControls: true,
        allowMuting: true,
        allowFullScreen: true,
        errorBuilder: (context, errorMessage) {
          return _buildErrorWidget('Video không thể phát. Nhấn để mở YouTube.');
        },
      );

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
      
      print('[DEBUG] Custom YouTube Player: Initialized successfully');
    } catch (e) {
      print('[ERROR] Custom YouTube Player: Initialization failed: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = e.toString();
        });
      }
    }
  }

  String? _extractVideoId(String url) {
    try {
      // Handle various YouTube URL formats
      RegExp regExp = RegExp(
        r'(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})',
        caseSensitive: false,
      );
      
      Match? match = regExp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }
      
      // Also try simple extraction from the end
      if (url.contains('=')) {
        String videoId = url.split('=').last.split('&').first;
        if (videoId.length == 11) {
          return videoId;
        }
      }
      
      return null;
    } catch (e) {
      print('[ERROR] Video ID extraction failed: $e');
      return null;
    }
  }

  Widget _buildErrorWidget(String message) {
    return Container(
      width: widget.width,
      height: widget.height ?? (widget.width != null ? widget.width! * 9 / 16 : 200),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: InkWell(
        onTap: () => _launchYouTube(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.smart_display,
              size: 48,
              color: Colors.red,
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Mở YouTube',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchYouTube() async {
    try {
      final uri = Uri.parse(widget.url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('[ERROR] Failed to launch YouTube: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return _buildErrorWidget('Video không thể phát. Nhấn để mở YouTube.');
    }

    if (!_isInitialized) {
      return Container(
        width: widget.width,
        height: widget.height ?? (widget.width != null ? widget.width! * 9 / 16 : 200),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ),
      );
    }

    return Container(
      width: widget.width,
      height: widget.height ?? (widget.width != null ? widget.width! * 9 / 16 : 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Chewie(
          controller: _chewieController!,
        ),
      ),
    );
  }
}
