@echo off
echo ========================================
echo      Recipe App - Admin Panel
echo ========================================
echo.
echo Starting admin panel server...
echo Please wait while dependencies load...
echo.

cd /d "%~dp0Recipe App Admin Panel Source Code\Script"

if not exist node_modules (
    echo Installing dependencies for the first time...
    npm install
    echo.
)

echo Starting admin panel on http://localhost:3000
echo.
echo To stop the server, press Ctrl+C
echo ========================================
echo.

npm start

echo.
echo Admin panel has stopped.
pause