import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TestYouTubePlayer extends StatefulWidget {
  const TestYouTubePlayer({Key? key}) : super(key: key);

  @override
  State<TestYouTubePlayer> createState() => _TestYouTubePlayerState();
}

class _TestYouTubePlayerState extends State<TestYouTubePlayer> {
  YoutubePlayerController? _controller;
  
  @override
  void initState() {
    super.initState();
    print('[TEST] Initializing test YouTube player');
    _initializePlayer();
  }
  
  void _initializePlayer() {
    try {
      print('[TEST] Creating controller');
      _controller = YoutubePlayerController.fromVideoId(
        videoId: 'dQw4w9WgXcQ', // Rick Roll video for testing
        autoPlay: false,
        params: const YoutubePlayerParams(
          showControls: true,
          enableJavaScript: true,
          playsInline: true,
          interfaceLanguage: 'vi',
        ),
      );
      print('[TEST] Controller created: ${_controller != null}');
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('[TEST ERROR] Failed to create controller: $e');
    }
  }
  
  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('[TEST] Build called - controller: ${_controller != null}');
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test YouTube Player'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Testing YouTube Player',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _controller == null
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(color: Colors.red),
                            SizedBox(height: 10),
                            Text('Loading YouTube Player...'),
                          ],
                        ),
                      )
                    : YoutubePlayer(
                        controller: _controller!,
                        aspectRatio: 16 / 9,
                      ),
              ),
              const SizedBox(height: 20),
              Text(
                'Controller status: ${_controller != null ? "Created" : "Not created"}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
