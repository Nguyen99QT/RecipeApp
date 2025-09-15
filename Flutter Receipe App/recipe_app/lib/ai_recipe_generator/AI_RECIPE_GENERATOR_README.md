# AI Recipe Generator Module

## Tổng quan
Module **AI Recipe Generator** là một tính năng tích hợp vào ứng dụng RecipeApp, cho phép người dùng tạo ra các công thức nấu ăn từ hình ảnh nguyên liệu bằng trí tuệ nhân tạo (Gemini AI).

## ✨ Tính năng chính

### 🤖 Tạo công thức AI
- Phân tích nhiều hình ảnh nguyên liệu cùng lúc
- Tạo công thức nấu ăn chi tiết bằng tiếng Việt
- Tùy chỉnh sở thích: ẩm thực, độ khó, thời gian, dị ứng
- Hỗ trợ các yêu cầu đặc biệt (chay, ít đường, không gluten...)

### 💾 Lưu trữ và quản lý
- Lưu công thức AI vào thiết bị
- Tìm kiếm và lọc công thức đã lưu
- Cập nhật và xóa công thức
- Xuất công thức dưới dạng text

### 📱 Giao diện người dùng
- Thiết kế Material Design 3
- Giao diện tiếng Việt
- Responsive và thân thiện với người dùng
- Hỗ trợ dark/light theme

### 🔄 Chia sẻ
- Chia sẻ công thức qua các ứng dụng khác
- Xuất định dạng text dễ đọc
- Copy thông tin công thức

## 🏗️ Kiến trúc

Module được xây dựng theo **Clean Architecture** với **BLoC Pattern**:

```
ai_recipe_generator/
├── domain/              # Business Logic Layer
│   ├── entities/        # Data models
│   ├── repositories/    # Abstract repositories
│   └── usecases/        # Business use cases
├── data/                # Data Layer
│   ├── datasources/     # Data sources (local/remote)
│   └── repositories/    # Repository implementations
└── presentation/        # Presentation Layer
    ├── pages/           # UI screens
    ├── widgets/         # Reusable widgets
    └── blocs/           # State management
```

## 🚀 Cách sử dụng

### 1. Tích hợp vào ứng dụng

```dart
import 'ai_recipe_generator/ai_recipe_generator_main.dart';

// Trong main app
AIRecipeGeneratorNavigation.openGenerator(
  context,
  geminiApiKey: 'YOUR_GEMINI_API_KEY',
);
```

### 2. Truy cập qua Debug Page
- Chạy ứng dụng
- Tại HomePage, nhấn FloatingActionButton (icon ⭐)
- Chọn "Tạo Công Thức AI" hoặc "Xem Công Thức Đã Lưu"

## 🔧 Cài đặt

### Dependencies đã được thêm:
- flutter_bloc: ^8.1.6
- equatable: ^2.0.5
- shared_preferences: ^2.3.2
- http: ^1.2.2
- image_picker: ^1.1.2
- share_plus: ^7.2.2

### API Key (tùy chọn)
Để sử dụng tính năng AI thực tế, cần Gemini API Key:
1. Truy cập [Google AI Studio](https://makersuite.google.com/)
2. Tạo API Key
3. Thêm vào file `ai_recipe_debug_page.dart` hoặc `ai_recipe_generator_main.dart`

## 📱 Cách test

### 1. Chạy ứng dụng
```bash
cd "c:\RecipeAPPAI2\Flutter Receipe App\recipe_app"
flutter run
```

### 2. Truy cập tính năng
- Tại HomePage → nhấn FloatingActionButton (⭐)
- Chọn "Tạo Công Thức AI"

### 3. Test flow
1. **Chọn hình ảnh**: Camera hoặc Gallery
2. **Điền preferences**: Sở thích ăn uống
3. **Tạo công thức**: Nhấn "Tạo Công Thức AI"
4. **Xem kết quả**: Công thức được tạo (mock data nếu không có API key)
5. **Lưu công thức**: Nhấn "Lưu Công Thức"
6. **Xem đã lưu**: Truy cập "Công Thức AI Đã Lưu"

## 🎯 Tính năng đã hoàn thành

- ✅ **Clean Architecture**: Domain/Data/Presentation layers
- ✅ **BLoC State Management**: AIRecipeBloc với events/states
- ✅ **Multi-image picker**: Chọn/chụp nhiều ảnh
- ✅ **Recipe preferences**: Tùy chỉnh sở thích chi tiết
- ✅ **Local storage**: SharedPreferences cho lưu trữ
- ✅ **Search & filter**: Tìm kiếm công thức đã lưu
- ✅ **Share functionality**: Chia sẻ công thức
- ✅ **Vietnamese UI**: Giao diện tiếng Việt hoàn chỉnh
- ✅ **Error handling**: Xử lý lỗi và validation
- ✅ **Debug integration**: Tích hợp vào main app

## 🔮 Tính năng sẽ cải thiện với API Key

- 🔄 **Gemini AI Integration**: Tạo công thức thực từ AI
- 🔄 **Recipe improvement**: Cải thiện công thức với feedback
- 🔄 **Smart preferences**: AI hiểu ngữ cảnh tốt hơn

## 📂 Cấu trúc files chính

```
lib/
├── ai_recipe_generator/           # Module chính
│   ├── domain/                    # Business logic
│   ├── data/                      # Data layer
│   ├── presentation/              # UI layer
│   └── ai_recipe_generator_main.dart # Entry point
├── ai_recipe_debug_page.dart      # Debug page
└── flutter_flow/nav/nav.dart      # Router (đã update)
```

## 🐛 Troubleshooting

### Nếu gặp lỗi compile:
```bash
flutter clean
flutter pub get
```

### Nếu không hiển thị FloatingActionButton:
- Kiểm tra file `home_page_widget.dart`
- Đảm bảo import đúng

### Nếu không navigate được:
- Kiểm tra route 'AIRecipeDebug' trong `nav.dart`
- Đảm bảo import `ai_recipe_debug_page.dart`

---

**🎉 Module AI Recipe Generator đã sẵn sàng để test!**

Hãy chạy ứng dụng và nhấn FloatingActionButton ⭐ tại HomePage để bắt đầu trải nghiệm tính năng tạo công thức AI.
