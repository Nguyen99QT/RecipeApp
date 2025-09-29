# Recipe App - Installation & Setup Guide

## System Requirements

### Hardware Requirements
- **Minimum:**
  - RAM: 8 GB
  - Storage: 20 GB free space
  - Processor: Intel i5 or AMD equivalent
  - Internet connection

- **Recommended:**
  - RAM: 16 GB or higher
  - Storage: 50 GB free space
  - Processor: Intel i7 or AMD Ryzen 7
  - High-speed internet connection

### Software Requirements

#### For Admin Panel (Backend)
- **Node.js**: Version 16.x or higher
- **MongoDB**: Version 4.4 or higher
- **Git**: Latest version
- **Code Editor**: VS Code (recommended) or any preferred editor

#### For Mobile App (Flutter)
- **Flutter SDK**: Version 3.0 or higher
- **Dart SDK**: (included with Flutter)
- **Android Studio**: Latest version (for Android development)
- **Android SDK**: API level 21 or higher
- **Java JDK**: Version 11 or higher

#### Operating System Support
- **Windows**: 10 or 11
- **macOS**: 10.14 or higher
- **Linux**: Ubuntu 18.04 or equivalent

## Pre-Installation Setup

### 1. Install Node.js
1. Download Node.js from [https://nodejs.org/](https://nodejs.org/)
2. Choose LTS version (Long Term Support)
3. Run installer and follow setup wizard
4. Verify installation:
   ```bash
   node --version
   npm --version
   ```

### 2. Install MongoDB
1. Download MongoDB Community Server from [https://www.mongodb.com/try/download/community](https://www.mongodb.com/try/download/community)
2. Run installer and follow setup wizard
3. Start MongoDB service:
   - **Windows**: MongoDB starts automatically as a service
   - **macOS/Linux**: 
     ```bash
     sudo systemctl start mongod
     ```
4. Verify installation:
   ```bash
   mongo --version
   ```

### 3. Install Flutter
1. Download Flutter SDK from [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)
2. Extract to desired location (e.g., `C:\flutter` on Windows)
3. Add Flutter to system PATH:
   - **Windows**: Add `C:\flutter\bin` to PATH environment variable
   - **macOS/Linux**: Add to `.bashrc` or `.zshrc`:
     ```bash
     export PATH="$PATH:/path/to/flutter/bin"
     ```
4. Run Flutter doctor:
   ```bash
   flutter doctor
   ```
5. Install any missing dependencies as suggested

### 4. Install Android Studio
1. Download from [https://developer.android.com/studio](https://developer.android.com/studio)
2. Install with default settings
3. Install Android SDK and create virtual device
4. Accept Android licenses:
   ```bash
   flutter doctor --android-licenses
   ```

## Installation Steps

### Step 1: Clone Repository
```bash
git clone [YOUR_REPOSITORY_URL]
cd Recipe
```

### Step 2: Setup Admin Panel (Backend)

#### 2.1 Navigate to Admin Panel Directory
```bash
cd "Recipe App Admin Panel Source Code/Script"
```

#### 2.2 Install Dependencies
```bash
npm install
```

#### 2.3 Configure Environment
1. Create `.env` file in the Script directory:
   ```env
   # Database Configuration
   MONGODB_URI=mongodb://localhost:27017/food-recipe
   
   # Server Configuration
   PORT=3000
   NODE_ENV=development
   
   # JWT Configuration
   JWT_SECRET=your_jwt_secret_key_here
   JWT_EXPIRE=7d
   
   # Email Configuration (Optional)
   EMAIL_HOST=smtp.gmail.com
   EMAIL_PORT=587
   EMAIL_USER=your_email@gmail.com
   EMAIL_PASS=your_app_password
   
   # Other Configurations
   UPLOAD_PATH=./uploads
   ```

#### 2.4 Setup Database
1. Start MongoDB service
2. Import sample data (if available):
   ```bash
   # If you have database dump files in Database folder
   cd ../Database
   mongoimport --db food-recipe --collection users --file food-recipe.logins.json
   mongoimport --db food-recipe --collection recipes --file food-recipe.recipes.json
   mongoimport --db food-recipe --collection categories --file food-recipe.categories.json
   # Continue for other collections...
   ```

#### 2.5 Start Admin Panel
```bash
cd "../Recipe App Admin Panel Source Code/Script"
npm start
```

The admin panel will be available at: `http://localhost:3000`

### Step 3: Setup Mobile App (Flutter)

#### 3.1 Navigate to Flutter Directory
```bash
cd "../../Flutter Receipe App/recipe_app"
```

#### 3.2 Install Flutter Dependencies
```bash
flutter pub get
```

#### 3.3 Configure App Settings
1. Update API base URL in `lib/backend/api_requests/api_calls.dart`:
   ```dart
   static String getBaseUrl({String? token}) {
     return 'http://YOUR_SERVER_IP:3000/api'; // Replace with your server IP
   }
   ```

#### 3.4 Setup Android Emulator
1. Open Android Studio
2. Open AVD Manager (Tools > AVD Manager)
3. Create new virtual device or use existing one
4. Start the emulator

#### 3.5 Run Flutter App
```bash
# For Android emulator
flutter run

# For specific device
flutter devices  # List available devices
flutter run -d [device_id]
```

## Quick Start Scripts

### For Windows Users

Create `start_admin_panel.bat`:
```batch
@echo off
echo Starting Recipe App Admin Panel...
cd "Recipe App Admin Panel Source Code\Script"
npm start
pause
```

Create `start_flutter_app.bat`:
```batch
@echo off
echo Starting Recipe App Flutter...
cd "Flutter Receipe App\recipe_app"
flutter run
pause
```

### For macOS/Linux Users

Create `start_admin_panel.sh`:
```bash
#!/bin/bash
echo "Starting Recipe App Admin Panel..."
cd "Recipe App Admin Panel Source Code/Script"
npm start
```

Create `start_flutter_app.sh`:
```bash
#!/bin/bash
echo "Starting Recipe App Flutter..."
cd "Flutter Receipe App/recipe_app"
flutter run
```

Make scripts executable:
```bash
chmod +x start_admin_panel.sh
chmod +x start_flutter_app.sh
```

## Testing the Setup

### 1. Test Admin Panel
1. Open browser and go to `http://localhost:3000`
2. You should see the admin login page
3. Try creating an admin account or use default credentials (if available)

### 2. Test Mobile App
1. App should launch on emulator/device
2. Test basic navigation and API connectivity
3. Try user registration and login features

## Troubleshooting

### Common Issues

#### MongoDB Connection Issues
```bash
# Check if MongoDB is running
mongo --eval 'db.runCommand("ping")'

# Start MongoDB service
# Windows: 
net start MongoDB
# macOS/Linux:
sudo systemctl start mongod
```

#### Flutter Build Issues
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

#### Port Already in Use
```bash
# Find process using port 3000
netstat -ano | findstr :3000  # Windows
lsof -i :3000                 # macOS/Linux

# Kill process and restart
```

#### Node.js Module Issues
```bash
# Clear npm cache and reinstall
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

### Getting Help
- Check console logs for detailed error messages
- Verify all dependencies are properly installed
- Ensure all services (MongoDB, Node.js) are running
- Check network connectivity for API calls

## Production Deployment Notes

### For Production Environment:
1. Use proper MongoDB hosting (MongoDB Atlas recommended)
2. Configure proper environment variables
3. Use HTTPS for admin panel
4. Configure proper API endpoints in Flutter app
5. Build signed APK for Android distribution
6. Set up proper backup and monitoring

### Security Considerations:
1. Change default JWT secret
2. Use strong passwords
3. Enable MongoDB authentication
4. Configure firewall rules
5. Regular security updates

## Directory Structure
```
Recipe/
├── Recipe App Admin Panel Source Code/
│   ├── Database/           # Sample database files
│   └── Script/            # Node.js backend code
├── Flutter Receipe App/
│   └── recipe_app/        # Flutter mobile app
├── docs/                  # Documentation
└── scripts/              # Utility scripts
```

## Support & Maintenance

### Regular Maintenance:
- Update Node.js dependencies: `npm update`
- Update Flutter: `flutter upgrade`
- MongoDB maintenance and backups
- Security patches and updates

### For Technical Support:
- Check logs in admin panel console
- Use Flutter doctor for Flutter issues
- MongoDB logs for database issues
- Network connectivity tests for API issues

---

**Note**: This guide assumes a development environment setup. For production deployment, additional security and performance configurations are required.
