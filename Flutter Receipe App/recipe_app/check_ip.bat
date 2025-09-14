@echo off
echo =================================
echo Flutter Recipe App - IP Checker
echo =================================
echo.

echo Current Computer IP Addresses:
echo --------------------------------
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "IPv4"') do (
    echo %%a
)

echo.
echo Admin Panel URL: http://[YOUR_IP]:8190
echo API Base URL: http://[YOUR_IP]:8190/api
echo.
echo Note: Use 10.0.2.2 for Android Emulator
echo       Use actual IP for real devices
echo.
pause