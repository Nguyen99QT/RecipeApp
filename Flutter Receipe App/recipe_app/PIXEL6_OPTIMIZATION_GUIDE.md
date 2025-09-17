# Android Performance Configuration for Pixel 6
# This file contains optimizations specifically for Pixel 6 devices

## Key Optimizations Applied:

### 1. Build Configuration
- Target SDK: 35 (Android 14)
- Compile SDK: 35
- Min SDK: 23 (Android 6.0)
- Java Version: 11
- Kotlin JVM Target: 11

### 2. Performance Settings
- Core library desugaring enabled
- R8 code shrinking enabled
- ProGuard optimization enabled
- NDK abiFilters: arm64-v8a (optimized for Pixel 6)

### 3. Memory Optimizations
- Large heap enabled for AI processing
- Hardware acceleration enabled
- Vector drawable support

### 4. Network Optimizations
- HTTP/2 support
- Connection pooling
- Cached network images

### 5. UI/UX Optimizations
- Material 3 design
- Adaptive icons
- Dark theme support
- High refresh rate support (90Hz/120Hz)

### 6. Security Features
- Network security config
- SSL pinning
- Encrypted shared preferences

## Pixel 6 Specific Features:
- Tensor chip optimization
- Camera API 2.0 support
- ML Kit integration ready
- 5G network support

## Build Commands:
```bash
# Development build
flutter build apk --debug --target-platform android-arm64

# Release build (optimized)
flutter build apk --release --target-platform android-arm64 --split-per-abi

# Bundle for Play Store
flutter build appbundle --release --target-platform android-arm64
```

## Performance Tips:
1. Use ARM64 builds for best performance
2. Enable hardware acceleration
3. Optimize images for mobile
4. Use efficient state management
5. Implement proper memory management
