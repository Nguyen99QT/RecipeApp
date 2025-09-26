@echo off
echo ========================================
echo     Recipe App - Mobile Application
echo ========================================
echo.
echo Starting Flutter mobile app...
echo Please make sure Android emulator is running!
echo.

cd /d "%~dp0Flutter Receipe App\recipe_app"

if not exist pubspec.lock (
    echo Installing Flutter dependencies for the first time...
    flutter pub get
    echo.
)

echo Checking Flutter setup...
flutter doctor --android-licenses > nul 2>&1

echo.
echo Available devices:
flutter devices
echo.

echo Starting mobile app...
echo To stop the app, press Ctrl+C
echo ========================================
echo.

flutter run

echo.
echo Mobile app has stopped.
pause