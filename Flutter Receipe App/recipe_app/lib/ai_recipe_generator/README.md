# AI Recipe Generator Module

Module AI Recipe Generator là một tính năng độc lập được tích hợp vào ứng dụng Recipe App, cho phép người dùng tạo công thức nấu ăn từ hình ảnh nguyên liệu bằng AI Gemini.

## 🌟 Tính Năng Chính

### ✨ AI Recipe Generation
- **Tạo công thức từ hình ảnh**: Chụp ảnh hoặc chọn từ thư viện để AI phân tích và tạo công thức
- **Hỗ trợ nhiều hình ảnh**: Có thể tải lên tối đa 5 hình ảnh cùng lúc
- **Tùy chỉnh sở thích**: Thiết lập yêu cầu đặc biệt, hạn chế ăn kiêng, ẩm thực ưa thích
- **AI thông minh**: Sử dụng Google Gemini 1.5 Flash cho kết quả chính xác

### 📱 Quản Lý Công Thức
- **Lưu trữ cục bộ**: Lưu công thức AI vào thiết bị
- **Tìm kiếm thông minh**: Tìm kiếm theo tên, mô tả, nguyên liệu, tags
- **Chia sẻ dễ dàng**: Xuất và chia sẻ công thức dưới dạng text
- **Giao diện thân thiện**: UI được thiết kế đẹp mắt với tiếng Việt

### 🏗️ Kiến Trúc
- **Clean Architecture**: Tách biệt Domain, Data, Presentation layers
- **BLoC Pattern**: Quản lý state hiệu quả với flutter_bloc
- **Dependency Injection**: Dễ dàng test và maintain
- **Modular Design**: Có thể tích hợp vào bất kỳ Flutter app nào

## 📁 Cấu Trúc Thư Mục

```
lib/ai_recipe_generator/
├── domain/                          # Business Logic Layer
│   ├── entities/                    # Data Models
│   │   ├── ai_meal.dart            # Model công thức AI
│   │   ├── ai_recipe_request.dart  # Model yêu cầu tạo công thức
│   │   └── ai_generation_result.dart # Model kết quả AI
│   ├── repositories/               # Abstract Repositories
│   │   └── ai_recipe_repository.dart
│   └── usecases/                   # Business Use Cases
│       ├── generate_recipe_usecase.dart
│       ├── save_ai_recipe_usecase.dart
│       └── get_saved_ai_recipes_usecase.dart
│
├── data/                           # Data Access Layer
│   ├── datasources/               # Data Sources
│   │   ├── ai_recipe_remote_datasource.dart     # API Interface
│   │   ├── ai_recipe_remote_datasource_impl.dart # Gemini API
│   │   ├── ai_recipe_local_datasource.dart      # Local Interface
│   │   └── ai_recipe_local_datasource_impl.dart # SharedPreferences
│   └── repositories/              # Repository Implementations
│       └── ai_recipe_repository_impl.dart
│
├── presentation/                   # UI Layer
│   ├── blocs/                     # State Management
│   │   └── ai_recipe_bloc.dart    # BLoC for AI Recipe
│   ├── pages/                     # Screens
│   │   ├── ai_recipe_generator_page.dart    # Trang tạo công thức
│   │   ├── ai_recipe_result_page.dart       # Trang kết quả
│   │   └── saved_ai_recipes_page.dart       # Trang danh sách đã lưu
│   └── widgets/                   # Reusable Widgets
│       ├── image_picker_widget.dart         # Widget chọn ảnh
│       └── recipe_preferences_widget.dart   # Widget tùy chỉnh
│
└── ai_recipe_generator_main.dart   # Entry Point & DI Container
```

## 🚀 Cách Sử Dụng

### 1. Cài Đặt Dependencies

Thêm vào `pubspec.yaml`:

```yaml
dependencies:
  flutter_bloc: ^8.1.3
  shared_preferences: ^2.3.2
  http: ^1.2.2
  image_picker: ^1.1.2
  share_plus: ^7.2.2
  equatable: ^2.0.5
```

### 2. Setup Gemini API Key

```dart
// Thêm vào .env file
GEMINI_API_KEY=your_gemini_api_key_here

// Hoặc pass trực tiếp khi khởi tạo
const geminiApiKey = 'your_api_key';
```

### 3. Tích Hợp Vào App

#### 3.1 Import module:
```dart
import 'ai_recipe_generator/ai_recipe_generator_main.dart';
import 'ai_recipe_integration.dart';
```

#### 3.2 Thêm vào Navigation:
```dart
// Sử dụng navigation helper
AIRecipeGeneratorNavigation.openGenerator(context, geminiApiKey: geminiApiKey);
AIRecipeGeneratorNavigation.openSavedRecipes(context, geminiApiKey: geminiApiKey);
```

#### 3.3 Tích hợp UI Components:

**Home Card:**
```dart
AIRecipeIntegration.buildHomeCard(context, geminiApiKey: geminiApiKey)
```

**Menu Items:**
```dart
...AIRecipeIntegration.buildMenuItems(context, geminiApiKey: geminiApiKey)
```

**Floating Action Button:**
```dart
floatingActionButton: AIRecipeIntegration.buildFloatingActionButton(context, geminiApiKey: geminiApiKey)
```

**Drawer Item:**
```dart
AIRecipeIntegration.buildDrawerItem(context, geminiApiKey: geminiApiKey)
```

### 4. Standalone Usage

```dart
import 'package:flutter/material.dart';
import 'ai_recipe_generator/ai_recipe_generator_main.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AIRecipeGeneratorEntry(
        geminiApiKey: 'your_api_key',
      ),
    );
  }
}
```

## 🧪 Testing

Sử dụng `TestAIRecipeGeneratorPage` để test module:

```dart
import 'test_ai_recipe_generator.dart';

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TestAIRecipeGeneratorPage(
      geminiApiKey: 'your_api_key',
    ),
  ),
);
```

## 🔧 Customization

### Thay Đổi AI Provider

Implement `AIRecipeRemoteDataSource`:

```dart
class CustomAIDataSource implements AIRecipeRemoteDataSource {
  @override
  Future<AIMeal> generateRecipeFromImages(AIRecipeRequest request) {
    // Custom AI implementation
  }
}
```

### Thay Đổi Local Storage

Implement `AIRecipeLocalDataSource`:

```dart
class CustomLocalDataSource implements AIRecipeLocalDataSource {
  @override
  Future<void> saveAIRecipe(AIMeal meal) {
    // Custom storage implementation
  }
}
```

### Custom UI Theme

Override colors trong integration:

```dart
// Thay đổi primary color
const Color primaryColor = Color(0xFF4CAF50);
```

## 📋 API Reference

### Core Classes

#### `AIMeal`
```dart
class AIMeal {
  final String id;
  final String title;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String cuisine;
  final int preparationTime;
  final int cookingTime;
  final int servings;
  final String difficulty;
  final List<String> tags;
  final String? imageUrl;
  final double? estimatedCalories;
  final DateTime createdAt;
}
```

#### `AIRecipeRequest`
```dart
class AIRecipeRequest {
  final List<String> imageUrls;
  final String? userPrompt;
  final String? dietaryRestrictions;
  final String? preferredCuisine;
  final int? targetServings;
  final String? difficultyLevel;
  final int? maxPrepTime;
  final List<String>? availableIngredients;
  final List<String>? allergies;
}
```

### Navigation Methods

```dart
// Mở trang tạo công thức
AIRecipeGeneratorNavigation.openGenerator(context, geminiApiKey: apiKey);

// Mở trang danh sách đã lưu
AIRecipeGeneratorNavigation.openSavedRecipes(context, geminiApiKey: apiKey);
```

### BLoC Events

```dart
// Tạo công thức mới
context.read<AIRecipeBloc>().add(GenerateRecipeEvent(request));

// Lưu công thức
context.read<AIRecipeBloc>().add(SaveRecipeEvent(meal));

// Tải danh sách đã lưu
context.read<AIRecipeBloc>().add(LoadSavedRecipesEvent());
```

## 🛡️ Error Handling

Module xử lý các lỗi phổ biến:

- **Không có API Key**: Hiển thị thông báo cần setup
- **Không có hình ảnh**: Yêu cầu chọn ít nhất 1 ảnh
- **Lỗi mạng**: Retry hoặc thông báo lỗi kết nối
- **Lỗi AI**: Thông báo lỗi từ Gemini API
- **Storage lỗi**: Thông báo không thể lưu/tải dữ liệu

## 📱 Screenshots

### Trang Tạo Công Thức
- Giao diện chọn ảnh
- Form tùy chỉnh sở thích
- Loading AI generation

### Trang Kết Quả
- Hiển thị công thức đẹp mắt
- Thông tin chi tiết
- Actions: Lưu, Chia sẻ

### Trang Danh Sách Đã Lưu
- Grid view công thức
- Tìm kiếm và filter
- Quick access

## 🤝 Contributing

1. Fork repository
2. Tạo feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

## 📄 License

Module này được phát triển như một phần của Recipe App và tuân theo license của project chính.

## ⚠️ Notes

- **Gemini API Key**: Cần đăng ký Google AI Studio để có API key
- **Image Processing**: Hình ảnh được convert sang base64 để gửi API
- **Storage**: Dữ liệu được lưu local, không sync cloud
- **Vietnamese UI**: Toàn bộ giao diện bằng tiếng Việt
- **Performance**: Optimized cho mobile devices

## 🔗 Dependencies

- `flutter_bloc: ^8.1.3` - State management
- `shared_preferences: ^2.3.2` - Local storage
- `http: ^1.2.2` - HTTP client
- `image_picker: ^1.1.2` - Image selection
- `share_plus: ^7.2.2` - Share functionality
- `equatable: ^2.0.5` - Value comparison

## 📞 Support

Nếu có vấn đề hoặc câu hỏi về module AI Recipe Generator, vui lòng tạo issue trong repository.
