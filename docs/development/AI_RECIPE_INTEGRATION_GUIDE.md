# AI Recipe Integration - User Guide

## Tổng quan
Tính năng AI Recipe cho phép người dùng tạo công thức nấu ăn bằng trí tuệ nhân tạo thông qua hình ảnh hoặc mô tả văn bản, sau đó lưu trữ và quản lý các công thức này.

## Cấu trúc tính năng

### 1. Flutter Mobile App
**File:** `lib/pages/ai_recipe_search_simple_widget.dart`

**Chức năng:**
- Giao diện tìm kiếm AI Recipe
- Upload hình ảnh hoặc nhập text mô tả
- Hiển thị kết quả AI (hiện tại dùng mock data)
- Lưu công thức vào danh sách yêu thích
- Điều hướng về trang chủ

**Cách sử dụng:**
1. Mở app Flutter
2. Điều hướng đến AI Recipe Search
3. Chọn hình ảnh từ gallery hoặc nhập text
4. Nhấn "Generate Recipe" để tạo công thức
5. Nhấn "Save to Favorites" để lưu công thức

### 2. Backend API

**Files:**
- `controllers/aiRecipeController.js` - Logic xử lý API
- `model/aiRecipeModel.js` - Schema database
- `routes/apiRoutes.js` - API endpoints

**API Endpoints:**
```
POST /saveAiRecipe - Lưu AI recipe mới
POST /getUserAiRecipes - Lấy danh sách AI recipes của user
POST /updateAiRecipe - Cập nhật AI recipe
POST /deleteAiRecipe - Xóa AI recipe
```

**Cách test API:**
```bash
cd "Recipe App Admin Panel Source Code/Script"
node test_ai_recipe_api.js
```

### 3. Admin Panel

**Files:**
- `controllers/aiRecipeAdminController.js` - Logic admin
- `views/admin/aiRecipes.ejs` - Trang danh sách
- `views/admin/aiRecipeDetail.ejs` - Trang chi tiết
- `routes/adminRoutes.js` - Admin routes

**Admin URLs:**
```
/ai-recipes - Xem tất cả AI recipes
/ai-recipe-detail?id=RECIPE_ID - Xem chi tiết recipe
/delete-ai-recipe?id=RECIPE_ID - Xóa recipe
/ai-recipe-stats - Thống kê (API endpoint)
```

## Cài đặt và chạy

### 1. Cài đặt dependencies cho Flutter:
```bash
cd "Flutter Receipe App/recipe_app"
flutter pub get
```

### 2. Cài đặt dependencies cho Backend:
```bash
cd "Recipe App Admin Panel Source Code/Script"
npm install axios  # Nếu chưa có
```

### 3. Chạy backend server:
```bash
cd "Recipe App Admin Panel Source Code/Script"
npm start
```

### 4. Chạy Flutter app:
```bash
cd "Flutter Receipe App/recipe_app"
flutter run
```

## Database Schema

**Collection:** `airecipes`

```javascript
{
  _id: ObjectId,
  userId: ObjectId,           // Reference đến user
  recipeName: String,         // Tên công thức
  recipeContent: String,      // Nội dung công thức
  ingredients: [String],      // Danh sách nguyên liệu
  cookingTime: Number,        // Thời gian nấu (phút)
  servingSize: Number,        // Số phần ăn
  difficultyLevel: String,    // Độ khó: Easy/Medium/Hard
  tags: [String],            // Tags mô tả
  imageUrl: String,          // URL hình ảnh (tùy chọn)
  source: String,            // Nguồn: "AI_GENERATED"
  createdAt: Date,
  updatedAt: Date
}
```

## Tích hợp AI thực tế

Hiện tại đang sử dụng mock data. Để tích hợp AI thực tế:

### 1. Google Gemini AI:
```dart
// Trong ai_recipe_search_simple_widget.dart
import 'package:google_generative_ai/google_generative_ai.dart';

final model = GenerativeModel(
  model: 'gemini-pro',
  apiKey: 'YOUR_API_KEY'
);

final response = await model.generateContent([
  Content.text('Generate a recipe based on: $prompt')
]);
```

### 2. OpenAI GPT:
```javascript
// Trong aiRecipeController.js
const OpenAI = require('openai');
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY
});

const response = await openai.chat.completions.create({
  model: "gpt-3.5-turbo",
  messages: [
    {
      role: "user", 
      content: `Generate a recipe based on: ${prompt}`
    }
  ]
});
```

## Testing

### 1. Test API với Postman:
- Import collection từ file test_ai_recipe_api.js
- Cập nhật auth token
- Test các endpoints

### 2. Test Flutter app:
```bash
cd "Flutter Receipe App/recipe_app"
flutter test
```

### 3. Test Admin Panel:
- Đăng nhập admin panel
- Truy cập /ai-recipes
- Kiểm tra CRUD operations

## Troubleshooting

### Lỗi thường gặp:

1. **"Module not found"**:
   ```bash
   flutter pub get
   ```

2. **"API connection failed"**:
   - Kiểm tra server đang chạy
   - Kiểm tra URL trong Flutter app

3. **"Authentication failed"**:
   - Cập nhật token trong test file
   - Kiểm tra middleware auth

4. **"Database connection error"**:
   - Kiểm tra MongoDB connection
   - Kiểm tra database name

## Roadmap

### Phase 1 (Đã hoàn thành):
- ✅ Flutter UI widget
- ✅ Backend API structure
- ✅ Admin panel interface
- ✅ Database schema

### Phase 2 (Tiếp theo):
- 🔲 Tích hợp AI thực tế (Gemini/OpenAI)
- 🔲 Image recognition cho AI recipe
- 🔲 Export recipe thành PDF
- 🔲 Social sharing features

### Phase 3 (Tương lai):
- 🔲 Recipe rating system
- 🔲 AI nutrition analysis
- 🔲 Voice input support
- 🔲 Recipe recommendations

## Support

Nếu gặp vấn đề:
1. Kiểm tra console logs
2. Xem file test_ai_recipe_api.js
3. Kiểm tra database connections
4. Đảm bảo tất cả dependencies đã được cài đặt

---

**Lưu ý:** Đây là phiên bản tích hợp cơ bản với mock data. Để sử dụng AI thực tế, cần cấu hình API keys và implement AI service integration.
