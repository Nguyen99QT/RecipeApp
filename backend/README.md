# Recipe Admin Backend - Spring Boot

Admin panel backend cho Recipe App được xây dựng bằng Spring Boot.

## 🚀 Tính năng

- **REST API** cho quản lý users, recipes, categories
- **MongoDB** integration với Spring Data
- **JWT Authentication** cho bảo mật
- **File Upload** cho hình ảnh recipes
- **Email Service** cho gửi OTP
- **Admin Dashboard** APIs
- **User Management** với phân quyền
- **Statistics & Analytics**

## 📋 Yêu cầu

- Java 17+
- Maven 3.6+
- MongoDB 4.0+
- SMTP Server (Gmail)

## ⚙️ Cài đặt

### 1. Clone project
```bash
cd "c:\Aptech\7. PRJ4\Receipe\backend"
```

### 2. Cấu hình MongoDB
Đảm bảo MongoDB đang chạy trên `localhost:27017`

### 3. Cấu hình Email
Sửa file `src/main/resources/application.properties`:
```properties
spring.mail.username=your-email@gmail.com
spring.mail.password=your-app-password
```

### 4. Build và chạy
```bash
mvn clean install
mvn spring-boot:run
```

Hoặc chạy với IDE:
```bash
Run RecipeAdminApplication.java
```

## 🌐 API Endpoints

### Base URL: `http://localhost:8080/api`

### User Management
- `GET /users` - Danh sách users (có phân trang)
- `GET /users/{id}` - Chi tiết user
- `GET /users/search?q=keyword` - Tìm kiếm users
- `PUT /users/{id}/verify` - Xác minh user
- `DELETE /users/{id}` - Xóa user
- `GET /users/stats` - Thống kê users

### Authentication
- `POST /auth/login` - Đăng nhập admin
- `POST /auth/register` - Đăng ký admin (nếu cần)

### Recipes (sẽ được thêm)
- `GET /recipes` - Danh sách recipes
- `POST /recipes` - Tạo recipe mới
- `PUT /recipes/{id}` - Cập nhật recipe
- `DELETE /recipes/{id}` - Xóa recipe

## 📊 Ví dụ Response

### GET /users
```json
{
  "status": true,
  "data": [
    {
      "id": "user123",
      "firstname": "Nguyen",
      "lastname": "Van A",
      "email": "nguyenvana@gmail.com",
      "isVerified": true,
      "createdAt": "2025-08-24T10:30:00"
    }
  ],
  "currentPage": 0,
  "totalItems": 25,
  "totalPages": 3
}
```

### GET /users/stats
```json
{
  "status": true,
  "data": {
    "totalUsers": 150,
    "verifiedUsers": 120,
    "unverifiedUsers": 30,
    "verificationRate": 80.0
  }
}
```

## 🔧 Cấu hình

### application.properties chính
```properties
# Server
server.port=8080
server.servlet.context-path=/api

# MongoDB
spring.data.mongodb.database=food-recipe

# JWT
jwt.secret=mySecretKey123456789012345678901234567890
jwt.expiration=86400000

# CORS
cors.allowed-origins=http://localhost:3000
```

## 📁 Cấu trúc Project

```
backend/
├── src/main/java/com/recipe/admin/
│   ├── RecipeAdminApplication.java
│   ├── model/
│   │   ├── User.java
│   │   ├── Recipe.java
│   │   └── Category.java
│   ├── repository/
│   │   ├── UserRepository.java
│   │   └── RecipeRepository.java
│   ├── controller/
│   │   ├── UserController.java
│   │   └── RecipeController.java
│   ├── service/
│   │   ├── UserService.java
│   │   └── EmailService.java
│   └── config/
│       ├── SecurityConfig.java
│       └── CorsConfig.java
├── src/main/resources/
│   ├── application.properties
│   └── static/
└── pom.xml
```

## 🚀 Deployment

### Development
```bash
mvn spring-boot:run
```

### Production
```bash
mvn clean package
java -jar target/admin-backend-0.0.1-SNAPSHOT.jar
```

## 📞 Liên hệ

- API Documentation: `http://localhost:8080/api`
- Admin Panel sẽ kết nối tới backend này thay thế cho Node.js

## 🔄 Migration từ Node.js

Backend này được thiết kế để thay thế hoàn toàn Node.js admin panel hiện tại:

1. **Tương thích API**: Giữ nguyên structure response
2. **MongoDB**: Sử dụng cùng database
3. **Security**: JWT authentication tương tự
4. **Performance**: Tối ưu hóa với Spring Boot

Chuyển đổi dần dần từ Node.js sang Spring Boot để đảm bảo không gián đoạn service.
