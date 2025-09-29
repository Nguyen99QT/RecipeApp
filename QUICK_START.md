# Recipe App - Quick Setup Guide

## What You Need

### Download & Install These First:
1. **Node.js** - Download from: https://nodejs.org/ (choose LTS version)
2. **MongoDB** - Download from: https://www.mongodb.com/try/download/community
3. **Android Studio** - Download from: https://developer.android.com/studio
4. **Flutter SDK** - Download from: https://docs.flutter.dev/get-started/install

## Step-by-Step Setup

### 🚀 Quick Start (5 Minutes)

#### Step 1: Start Database
- **Windows**: MongoDB starts automatically after installation
- **Mac/Linux**: Open terminal and run: `sudo systemctl start mongod`

#### Step 2: Start Admin Panel
1. Open Command Prompt/Terminal
2. Navigate to project folder:
   ```
   cd "Recipe App Admin Panel Source Code/Script"
   ```
3. Install dependencies (first time only):
   ```
   npm install
   ```
4. Start the admin panel:
   ```
   npm start
   ```
5. Open browser and go to: **http://localhost:3000**

#### Step 3: Start Mobile App
1. Open new Command Prompt/Terminal
2. Navigate to Flutter app:
   ```
   cd "Flutter Receipe App/recipe_app"
   ```
3. Install dependencies (first time only):
   ```
   flutter pub get
   ```
4. Start Android emulator from Android Studio
5. Run the app:
   ```
   flutter run
   ```

### ✅ Verification
- Admin panel should open in browser at http://localhost:3000
- Mobile app should appear on Android emulator
- Both should connect and work together

## Easy Startup Scripts

### For Windows - Create these .bat files:

**start_admin.bat**
```batch
@echo off
cd "Recipe App Admin Panel Source Code\Script"
npm start
pause
```

**start_app.bat**
```batch
@echo off
cd "Flutter Receipe App\recipe_app"
flutter run
pause
```

### For Mac/Linux - Create these .sh files:

**start_admin.sh**
```bash
#!/bin/bash
cd "Recipe App Admin Panel Source Code/Script"
npm start
```

**start_app.sh**
```bash
#!/bin/bash
cd "Flutter Receipe App/recipe_app"
flutter run
```

## Common Issues & Solutions

### ❌ "Command not found"
**Problem**: Node, npm, or flutter commands not recognized
**Solution**: Restart computer after installing Node.js and Flutter

### ❌ "Port 3000 already in use"
**Problem**: Admin panel won't start
**Solution**: Close any running admin panel and try again

### ❌ "No devices found"
**Problem**: Flutter can't find emulator
**Solution**: Start Android emulator from Android Studio first

### ❌ Database connection error
**Problem**: Admin panel can't connect to database
**Solution**: Make sure MongoDB is running

## Quick Commands Reference

```bash
# Check if everything is installed correctly
node --version
npm --version
flutter --version
flutter doctor

# Start MongoDB (if not auto-started)
mongod

# Install project dependencies
npm install        # In admin panel folder
flutter pub get    # In Flutter app folder

# Start applications
npm start          # Start admin panel
flutter run        # Start mobile app

# Restart if needed
npm restart        # Restart admin panel
flutter clean      # Clean Flutter cache
flutter pub get    # Reinstall Flutter dependencies
```

## What Each Component Does

### 🖥️ Admin Panel (http://localhost:3000)
- Manage recipes and ingredients
- User management
- Content management
- Analytics and reports

### 📱 Mobile App
- User registration and login
- Browse and search recipes
- Favorites and meal planning
- AI recipe suggestions

### 🗄️ Database (MongoDB)
- Stores all app data
- User accounts and preferences
- Recipe information
- App content

## Getting Help

### If something doesn't work:
1. **Check the terminal/command prompt for error messages**
2. **Make sure all services are running:**
   - MongoDB database
   - Admin panel (npm start)
   - Android emulator

3. **Common fixes:**
   ```bash
   # Restart everything
   # Stop admin panel (Ctrl+C)
   # Stop Flutter app (Ctrl+C)
   
   # Clean and restart
   flutter clean
   flutter pub get
   npm restart
   ```

### Still need help?
- Check the detailed `INSTALLATION_GUIDE.md` for advanced troubleshooting
- Look at console output for specific error messages
- Ensure all software requirements are installed correctly

---

**💡 Tip**: Keep both terminal windows open while using the app - one for admin panel, one for mobile app. This helps you see any error messages.
