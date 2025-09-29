import 'dart:convert';
import 'package:http/http.dart' as http;

/// Simple test for AI API connectivity
class AIDebugTest {
  static const String API_KEY = 'AIzaSyA0er_CFpuAvZZx0-iVhiqwKOqAcC_sq6U';
  static const String BASE_URL = 'https://generativelanguage.googleapis.com/v1beta';
  
  static Future<void> testAPIConnectivity() async {
    print('🔍 Testing AI API connectivity...');
    
    try {
      // Test simple text-only request first
      final payload = {
        'contents': [
          {
            'parts': [
              {'text': 'Hello, can you respond with "API working"?'}
            ]
          }
        ],
        'generationConfig': {
          'temperature': 0.1,
          'maxOutputTokens': 50,
        }
      };
      
      print('📡 Sending test request...');
      final client = http.Client();
      
      final response = await client.post(
        Uri.parse('$BASE_URL/models/gemini-flash-latest:generateContent?key=$API_KEY'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      ).timeout(Duration(seconds: 20));
      
      print('📡 Response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('📡 Response structure: ${data.keys.toList()}');
        
        if (data['candidates'] != null && data['candidates'].isNotEmpty) {
          final text = data['candidates'][0]['content']['parts'][0]['text'];
          print('✅ API Test SUCCESS: $text');
        } else {
          print('❌ API returned empty response');
          print('📡 Full response: ${response.body}');
        }
      } else {
        print('❌ API Test FAILED: ${response.statusCode}');
        print('❌ Error: ${response.body}');
        
        // Handle specific error codes
        if (response.statusCode == 400) {
          print('💡 Bad request - check API parameters');
        } else if (response.statusCode == 401) {
          print('💡 Unauthorized - check API key');
        } else if (response.statusCode == 403) {
          print('💡 Forbidden - API key lacks permissions');
        } else if (response.statusCode == 429) {
          print('💡 Rate limited - too many requests');
        } else if (response.statusCode >= 500) {
          print('💡 Server error - try again later');
        }
      }
      
      client.close();
      
    } catch (e) {
      print('❌ NETWORK ERROR: $e');
      
      if (e.toString().contains('TimeoutException')) {
        print('⏰ Request timed out - network may be slow');
        print('💡 Try checking emulator network settings');
      } else if (e.toString().contains('SocketException')) {
        print('🔌 Network socket error - no connectivity');
      } else if (e.toString().contains('HandshakeException')) {
        print('🔐 SSL/TLS handshake failed');
      } else {
        print('🔧 Unexpected error type');
      }
    }
  }
  
  static Future<void> testAPIKey() async {
    print('🔑 Testing API Key validity...');
    
    try {
      final client = http.Client();
      
      // Test with basic connectivity first
      print('🌐 Testing basic connectivity...');
      final basicResponse = await client.get(
        Uri.parse('https://www.google.com'),
      ).timeout(Duration(seconds: 5));
      
      print('🌐 Basic connectivity: ${basicResponse.statusCode}');
      
      if (basicResponse.statusCode != 200) {
        print('❌ No internet connection available');
        client.close();
        return;
      }
      
      // Test with API endpoint
      print('🔑 Testing Gemini API endpoint...');
      final response = await client.get(
        Uri.parse('$BASE_URL/models?key=$API_KEY'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(Duration(seconds: 15));
      
      print('🔑 Key test status: ${response.statusCode}');
      print('🔑 Response body: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}...');
      
      if (response.statusCode == 200) {
        print('✅ API Key is VALID');
      } else if (response.statusCode == 401) {
        print('❌ API Key is INVALID');
      } else if (response.statusCode == 403) {
        print('❌ API Key has no permission');
      } else {
        print('❌ Unknown error: ${response.statusCode}');
      }
      
      client.close();
      
    } catch (e) {
      print('❌ Key test error: $e');
      if (e.toString().contains('TimeoutException')) {
        print('⏰ Network timeout - check internet connection');
      } else if (e.toString().contains('SocketException')) {
        print('🔌 Network connection failed');
      }
    }
  }
}
