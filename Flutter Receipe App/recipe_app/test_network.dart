import 'package:http/http.dart' as http;

void main() async {
  print('Testing network connectivity...');
  
  // Test different IP addresses
  List<String> testUrls = [
    'http://10.0.2.2:3000/uploads/images/1758028610766_chaoluon1.png',
    'http://127.0.0.1:3000/uploads/images/1758028610766_chaoluon1.png',
    'http://localhost:3000/uploads/images/1758028610766_chaoluon1.png',
    'http://192.168.101.34:3000/uploads/images/1758028610766_chaoluon1.png',
  ];
  
  for (String url in testUrls) {
    try {
      print('\\nTesting: $url');
      final response = await http.head(Uri.parse(url)).timeout(Duration(seconds: 5));
      print('Status: ${response.statusCode}');
      print('Content-Length: ${response.headers['content-length']}');
      print('Content-Type: ${response.headers['content-type']}');
    } catch (e) {
      print('Error: $e');
    }
  }
}
