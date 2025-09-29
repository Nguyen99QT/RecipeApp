import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_youtube_player.dart';

class YouTubeTestScreen extends StatelessWidget {
  const YouTubeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Video Test'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'YouTube Video Player Test',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            
            Text(
              'Test 1: Direct Video ID',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            FlutterFlowYoutubePlayer(
              url: 'zvlct2ZXhj8&t=275s',
              autoPlay: false,
              showControls: true,
              showFullScreen: true,
            ),
            
            SizedBox(height: 24),
            
            Text(
              'Test 2: Full YouTube URL',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            FlutterFlowYoutubePlayer(
              url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
              autoPlay: false,
              showControls: true,
              showFullScreen: true,
            ),
            
            SizedBox(height: 24),
            
            Text(
              'Test 3: Short YouTube URL',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            FlutterFlowYoutubePlayer(
              url: 'https://youtu.be/dQw4w9WgXcQ',
              autoPlay: false,
              showControls: true,
              showFullScreen: true,
            ),
            
            SizedBox(height: 24),
            
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '✅ Success Indicators:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('• Videos load and display properly'),
                  Text('• Play controls are visible'),
                  Text('• Videos play when tapped'),
                  Text('• No OpenGL ES API errors'),
                  Text('• Fullscreen works (if enabled)'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
