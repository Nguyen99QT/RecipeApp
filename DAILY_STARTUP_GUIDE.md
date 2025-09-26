# Daily Startup Guide - Recipe App

## Before You Start
Make sure you have completed the initial setup from `QUICK_START.md`

## Every Day Startup (Simple 3 Steps)

### Step 1: Start Database 📊
**Most computers**: MongoDB starts automatically
**If needed**: 
- Windows: Press Win+R, type `services.msc`, find "MongoDB" and start it
- Mac/Linux: Open terminal and run `sudo systemctl start mongod`

### Step 2: Start Admin Panel 🖥️
1. Open Command Prompt/Terminal
2. Go to admin folder:
   ```bash
   cd "Recipe App Admin Panel Source Code/Script"
   ```
3. Start admin panel:
   ```bash
   npm start
   ```
4. Open browser: http://localhost:3000

### Step 3: Start Mobile App 📱
1. Open new Command Prompt/Terminal  
2. Go to app folder:
   ```bash
   cd "Flutter Receipe App/recipe_app"
   ```
3. Start Android emulator (from Android Studio)
4. Start the app:
   ```bash
   flutter run
   ```

## Using Batch Files (Windows) - Even Easier! 🚀

### Create these files once:

**start_admin.bat**
```batch
@echo off
echo Starting Admin Panel...
cd /d "C:\path\to\your\Recipe App Admin Panel Source Code\Script"
npm start
pause
```

**start_app.bat** 
```batch
@echo off
echo Starting Mobile App...
cd /d "C:\path\to\your\Flutter Receipe App\recipe_app"
flutter run
pause
```

### Then just double-click these files to start!

## Quick Status Check ✅

### Is everything working?
- ✅ Admin panel opens at http://localhost:3000
- ✅ Mobile app appears on emulator
- ✅ No error messages in terminals
- ✅ You can login to admin panel
- ✅ Mobile app connects to admin panel

## If Something Goes Wrong ❌

### Common fixes:
1. **Close everything and restart**:
   - Press Ctrl+C in both terminals
   - Close terminals
   - Start again from Step 1

2. **Clear cache**:
   ```bash
   flutter clean
   flutter pub get
   ```

3. **Restart computer** (fixes 90% of issues)

## Daily Workflow 💼

### For Developers:
1. Start admin panel first
2. Start mobile app
3. Both will connect automatically
4. Make changes in code
5. Hot reload: Press 'r' in Flutter terminal

### For Testing:
1. Start both applications
2. Test admin panel features in browser
3. Test mobile app features in emulator
4. Check data sync between both

## Shutting Down 🔄

### To stop applications:
1. Press **Ctrl+C** in admin panel terminal
2. Press **Ctrl+C** in Flutter app terminal
3. Close Android emulator
4. MongoDB can keep running (it's OK)

### Complete shutdown:
- Stop MongoDB service if needed
- Close all terminal windows
- Close Android Studio/emulator

## Performance Tips 💡

### For faster startup:
- Keep MongoDB running all the time
- Don't close Android emulator between sessions
- Use SSD storage if possible
- Close unnecessary programs

### Memory saving:
- Close browser tabs you don't need
- Don't run multiple emulators
- Restart apps if they become slow

## Backup Reminder 💾

### Before making changes:
- Admin panel data is in MongoDB
- Code changes should be in version control
- Regular backups recommended

---

**Quick Reference**:
- Admin Panel: http://localhost:3000
- Start Admin: `npm start` (in Script folder)
- Start App: `flutter run` (in recipe_app folder)
- Stop: Press Ctrl+C
- Restart: Close and start again