import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  print('🚀 Starting simple AI API test...');
  
  const String API_KEY = 'AIzaSyCy6tZdHl5JViz4u--naRLfapeJqTjSAnY';
  const String BASE_URL = 'https://generativelanguage.googleapis.com/v1beta';
  
  try {
    // Test 1: Basic connectivity
    print('🌐 Testing basic internet connectivity...');
    final basicResponse = await http.get(Uri.parse('https://www.google.com')).timeout(Duration(seconds: 5));
    print('🌐 Google connectivity: ${basicResponse.statusCode}');
    
    // Test 2: API key validation
    print('🔑 Testing API key...');
    final keyResponse = await http.get(
      Uri.parse('$BASE_URL/models?key=$API_KEY'),
      headers: {'Content-Type': 'application/json'},
    ).timeout(Duration(seconds: 15));
    
    print('🔑 API key test: ${keyResponse.statusCode}');
    if (keyResponse.statusCode == 200) {
      print('✅ API key is valid');
    } else {
      print('❌ API key issue: ${keyResponse.body}');
    }
    
    // Test 3: Simple generation
    print('📡 Testing simple generation...');
    final payload = {
      'contents': [
        {
          'parts': [
            {'text': 'Hello, just say "API working" as response'}
          ]
        }
      ],
      'generationConfig': {
        'temperature': 0.1,
        'maxOutputTokens': 20,
      }
    };
    
    final genResponse = await http.post(
      Uri.parse('$BASE_URL/models/gemini-1.5-flash:generateContent?key=$API_KEY'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(payload),
    ).timeout(Duration(seconds: 20));
    
    print('📡 Generation test: ${genResponse.statusCode}');
    if (genResponse.statusCode == 200) {
      final data = json.decode(genResponse.body);
      if (data['candidates'] != null && data['candidates'].isNotEmpty) {
        final text = data['candidates'][0]['content']['parts'][0]['text'];
        print('✅ Generation SUCCESS: $text');
      } else {
        print('❌ Empty response: ${genResponse.body}');
      }
    } else {
      print('❌ Generation FAILED: ${genResponse.body}');
    }
    
  } catch (e) {
    print('❌ ERROR: $e');
  }
  
  print('🏁 Test completed');
}