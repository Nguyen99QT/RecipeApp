# Build Script for Android Pixel 6 Optimization
# This script optimizes the Flutter Recipe App for Android devices, specifically Pixel 6

Write-Host "🚀 Starting Android Build for Pixel 6..." -ForegroundColor Green

# Clean previous builds
Write-Host "📁 Cleaning previous builds..." -ForegroundColor Yellow
flutter clean

# Get dependencies
Write-Host "📦 Getting Flutter dependencies..." -ForegroundColor Yellow
flutter pub get

# Build for Android with optimizations
Write-Host "🔨 Building APK for Android..." -ForegroundColor Yellow
flutter build apk --target-platform android-arm64 --split-per-abi --release

# Alternative: Build bundle for Play Store
Write-Host "📱 Building App Bundle for Play Store..." -ForegroundColor Yellow
flutter build appbundle --target-platform android-arm64 --release

Write-Host "✅ Build completed!" -ForegroundColor Green
Write-Host "📍 APK Location: build/app/outputs/flutter-apk/" -ForegroundColor Cyan
Write-Host "📍 Bundle Location: build/app/outputs/bundle/release/" -ForegroundColor Cyan

# Optional: Install on connected device
$install = Read-Host "Install on connected device? (y/n)"
if ($install -eq "y" -or $install -eq "Y") {
    Write-Host "📲 Installing on device..." -ForegroundColor Yellow
    flutter install
}

Write-Host "🎉 Done! Ready for Pixel 6!" -ForegroundColor Green
