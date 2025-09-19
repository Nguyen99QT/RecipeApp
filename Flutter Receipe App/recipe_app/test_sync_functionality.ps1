# Test AI Recipe Sync Function
# Chạy Flutter app với test để thêm sample AI recipe và test sync

Write-Host "🧪 Testing AI Recipe Sync Functionality..." -ForegroundColor Yellow
Write-Host ""

# Step 1: Add sample AI recipe to local storage
Write-Host "📝 Step 1: Adding sample AI recipe to local storage..." -ForegroundColor Green
cd "c:\RecipeAPPAI2\Flutter Receipe App\recipe_app"
flutter pub run test_ai_recipe_sync.dart

# Step 2: Run app to trigger sync 
Write-Host ""
Write-Host "📱 Step 2: Starting Flutter app to test sync..." -ForegroundColor Green
Write-Host "   The app will automatically sync saved AI recipes to admin panel" -ForegroundColor Cyan
Write-Host "   Check http://localhost:8190/saved-ai-recipes to see synced recipes" -ForegroundColor Cyan
Write-Host ""

# Step 3: Run Flutter app
flutter run