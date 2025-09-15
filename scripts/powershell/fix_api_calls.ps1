# Script to fix API calls in Flutter project
$filePath = "c:\Aptech\7. PRJ4\Receipe\Flutter Receipe App\recipe_app\lib\backend\api_requests\api_calls.dart"

# Read the file content
$content = Get-Content $filePath -Raw

# Replace all instances of $.data.success with $.status
$content = $content -replace '\$\.data\.success', '$.status'

# Replace all instances of $.data.message with $.message  
$content = $content -replace '\$\.data\.message', '$.message'

# Replace int? success with bool? success
$content = $content -replace 'int\? success\(dynamic response\) => castToType<int>\(', 'bool? success(dynamic response) => castToType<bool>('

# Write back to file
Set-Content $filePath $content

Write-Host "API calls fixed successfully!"
