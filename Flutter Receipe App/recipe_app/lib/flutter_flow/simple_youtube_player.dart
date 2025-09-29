import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SimpleYouTubePlayer extends StatefulWidget {
  const SimpleYouTubePlayer({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.autoPlay = false,
  });

  final String url;
  final double? width;
  final double? height;
  final bool autoPlay;

  @override
  State<SimpleYouTubePlayer> createState() => _SimpleYouTubePlayerState();
}

class _SimpleYouTubePlayerState extends State<SimpleYouTubePlayer> {
  late WebViewController _controller;
  String? _videoId;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    _videoId = _extractVideoId(widget.url);
    if (_videoId == null) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      return;
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print('[DEBUG] Simple YouTube Player: Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('[DEBUG] Simple YouTube Player: Page finished loading: $url');
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            print('[ERROR] Simple YouTube Player: ${error.description}');
            setState(() {
              _hasError = true;
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(_buildEmbedUrl()));
  }

  String _buildEmbedUrl() {
    final autoplayParam = widget.autoPlay ? '1' : '0';
    return 'https://www.youtube.com/embed/$_videoId?'
        'autoplay=$autoplayParam&'
        'controls=1&'
        'modestbranding=1&'
        'rel=0&'
        'showinfo=0&'
        'fs=1&'
        'playsinline=1&'
        'enablejsapi=0'; // Tắt JS API để tránh lỗi setSize
  }

  String? _extractVideoId(String url) {
    print('[DEBUG] Simple YouTube Player: Extracting video ID from: $url');
    
    // Handle direct video ID format
    if (!url.contains("http")) {
      final videoIdMatch = RegExp(r'^([_\-a-zA-Z0-9]{11}).*$').firstMatch(url);
      if (videoIdMatch != null) {
        final videoId = videoIdMatch.group(1);
        print('[DEBUG] Simple YouTube Player: Extracted video ID: $videoId');
        return videoId;
      }
      if (url.length == 11) {
        print('[DEBUG] Simple YouTube Player: Using direct video ID: $url');
        return url;
      }
    }
    
    // Handle YouTube URLs
    final regexPatterns = [
      RegExp(r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ];
    
    for (final regex in regexPatterns) {
      final match = regex.firstMatch(url.trim());
      if (match != null && match.groupCount >= 1) {
        final videoId = match.group(1);
        print('[DEBUG] Simple YouTube Player: Extracted video ID: $videoId');
        return videoId;
      }
    }
    
    print('[ERROR] Simple YouTube Player: Could not extract video ID from: $url');
    return null;
  }

  double get width => widget.width ?? MediaQuery.of(context).size.width;
  double get height => widget.height ?? (width * 9 / 16); // 16:9 aspect ratio

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.white, size: 48),
              SizedBox(height: 16),
              Text(
                'Failed to load video',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              Container(
                color: Colors.black87,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.red),
                      SizedBox(height: 16),
                      Text(
                        'Loading video...',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
