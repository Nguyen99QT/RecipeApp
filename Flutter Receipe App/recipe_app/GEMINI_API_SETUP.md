# 🔑 Gemini AI API Setup Guide

## Vấn đề hiện tại
API key hiện tại không hợp lệ hoặc chưa được enable Generative Language API, khiến tính năng AI Recipe Generation bị "loading indefinitely".

## ✅ Giải pháp: Tạo API key mới từ Google AI Studio

### Bước 1: Truy cập Google AI Studio
1. Mở trình duyệt và truy cập: https://ai.google.dev/
2. Đăng nhập với Google account của bạn

### Bước 2: Tạo API Key
1. Nhấp vào nút **"Get API key"** hoặc **"Create API key"**
2. Chọn **"Create API key in new project"** hoặc chọn project có sẵn
3. Copy API key được tạo (dạng: `AIzaSy...`)

### Bước 3: Cập nhật API key trong code
Thay thế API key trong file sau:

**File:** `lib/ai_recipe_generator/ai_recipe_generator_main.dart`
**Dòng 56:** 
```dart
defaultValue: 'YOUR_NEW_API_KEY_HERE'),
```

### Bước 4: Test lại tính năng
1. Chạy lại app: `flutter run`
2. Truy cập tính năng AI Recipe Generation
3. Upload ảnh nguyên liệu và test tạo công thức

## 🔧 Cách cập nhật nhanh

### Option 1: Cập nhật trực tiếp trong code
```dart
// Trong file lib/ai_recipe_generator/ai_recipe_generator_main.dart
apiKey: geminiApiKey ??
    const String.fromEnvironment('GEMINI_API_KEY',
        defaultValue: 'YOUR_VALID_GEMINI_API_KEY'), // ← Thay đổi ở đây
```

### Option 2: Sử dụng Environment Variable
1. Tạo file `.env` trong root project:
```
GEMINI_API_KEY=YOUR_VALID_GEMINI_API_KEY
```

2. Thêm vào `pubspec.yaml`:
```yaml
dependencies:
  flutter_dotenv: ^5.1.0
```

3. Load dotenv trong `main.dart`:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}
```

## 🚨 Lưu ý bảo mật
- **KHÔNG** commit API key lên Git repository
- Thêm `.env` vào `.gitignore`
- Sử dụng environment variables trong production

## 📋 Checklist
- [ ] Tạo API key từ Google AI Studio (ai.google.dev)
- [ ] Cập nhật API key trong code
- [ ] Test AI Recipe Generation
- [ ] Verify tính năng hoạt động bình thường

## 🔗 Links hữu ích
- [Google AI Studio](https://ai.google.dev/)
- [Gemini API Documentation](https://ai.google.dev/docs)
- [API Key Best Practices](https://cloud.google.com/docs/authentication/api-keys)

---
**Trạng thái:** ❌ Cần cập nhật API key mới
**Priority:** 🔥 High - Tính năng chính không hoạt động