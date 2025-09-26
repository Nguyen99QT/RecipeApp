@echo off
echo ========================================
echo       Recipe App - Complete Setup
echo ========================================
echo.
echo This will start both admin panel and mobile app
echo Make sure you have installed:
echo - Node.js
echo - MongoDB  
echo - Flutter
echo - Android Studio
echo.
echo Press any key to continue or Ctrl+C to cancel...
pause > nul

echo.
echo Starting MongoDB service...
net start MongoDB > nul 2>&1

echo Starting admin panel in new window...
start "Recipe Admin Panel" "%~dp0start_admin_panel.bat"

echo.
echo Waiting 5 seconds for admin panel to start...
timeout /t 5 /nobreak > nul

echo Starting mobile app in new window...  
start "Recipe Mobile App" "%~dp0start_mobile_app.bat"

echo.
echo ========================================
echo Both applications are starting!
echo.
echo Admin Panel: http://localhost:3000
echo Mobile App: Check Android emulator
echo.
echo Close this window when you're done.
echo ========================================
echo.
pause