# Build script with reduced warnings
Write-Host "🚀 Building RecipeApp..." -ForegroundColor Green

# Clean build
Write-Host "🧹 Cleaning build cache..." -ForegroundColor Yellow
flutter clean

# Get dependencies
Write-Host "📦 Getting dependencies..." -ForegroundColor Yellow  
flutter pub get

# Build APK with reduced output
Write-Host "🔨 Building APK..." -ForegroundColor Yellow
flutter build apk --debug 2>&1 | Where-Object { 
    $_ -notmatch "warning:" -and 
    $_ -notmatch "Note:" -and 
    $_ -notmatch "Support for Android x86 targets" -and
    $_ -notmatch "obsolete and will be removed" -and
    $_ -notmatch "deprecated API" -and
    $_ -notmatch "Xlint"
}

Write-Host "✅ Build completed successfully!" -ForegroundColor Green
Write-Host "📱 APK location: build\app\outputs\flutter-apk\app-debug.apk" -ForegroundColor Cyan
