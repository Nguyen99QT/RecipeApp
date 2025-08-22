# PowerShell script to fix API response parsing in api_calls.dart
$filePath = "lib\flutter_flow\custom_functions.dart"

# Check if the file exists
if (Test-Path $filePath) {
    Write-Host "Found $filePath, applying fixes..."
    
    # Read the file content
    $content = Get-Content $filePath -Raw
    
    # Apply replacements
    $content = $content -replace '\$\.data\.success', '$.status'
    $content = $content -replace '\$\.data\.message', '$.message'
    $content = $content -replace 'int\? success\(dynamic response\) => castToType<int>\(', 'bool? success(dynamic response) => castToType<bool>('
    
    # Write the content back to the file
    Set-Content $filePath -Value $content
    Write-Host "Applied fixes to $filePath"
} else {
    Write-Host "File $filePath not found"
}

# Also fix api_calls.dart
$apiCallsPath = "lib\backend\api_requests\api_calls.dart"
if (Test-Path $apiCallsPath) {
    Write-Host "Found $apiCallsPath, applying fixes..."
    
    $content = Get-Content $apiCallsPath -Raw
    
    # Apply replacements
    $content = $content -replace '\$\.data\.success', '$.status'
    $content = $content -replace '\$\.data\.message', '$.message'
    $content = $content -replace 'int\? success\(dynamic response\) => castToType<int>\(', 'bool? success(dynamic response) => castToType<bool>('
    
    Set-Content $apiCallsPath -Value $content
    Write-Host "Applied fixes to $apiCallsPath"
} else {
    Write-Host "File $apiCallsPath not found"
}

Write-Host "Script completed!"
