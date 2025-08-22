# Script to fix API response parsing paths
$filePath = "C:\Aptech\7. PRJ4\Receipe\Flutter Receipe App\recipe_app\lib\backend\api_requests\api_calls.dart"
$content = Get-Content $filePath -Raw

Write-Host "Fixing API parsing paths..."

# Fix patterns - remove intermediate object names that don't exist in server response
$fixes = @{
    'r'''$.data.category[:]' = 'r'''$.data[:]'
    'r'''$.data.cuisines[:]' = 'r'''$.data[:]'
    'r'''$.data.recipe[:]' = 'r'''$.data[:]'
    'r'''$.data.favouriteRecipe[:]' = 'r'''$.data[:]'
    'r'''$.data.setting[:]' = 'r'''$.data[:]'
}

foreach ($pattern in $fixes.Keys) {
    $replacement = $fixes[$pattern]
    $oldCount = ($content -split [regex]::Escape($pattern)).Count - 1
    $content = $content -replace [regex]::Escape($pattern), $replacement
    $newCount = ($content -split [regex]::Escape($replacement)).Count - 1
    Write-Host "Replaced '$pattern' with '$replacement' - $oldCount occurrences"
}

# Save the updated content
$content | Set-Content $filePath -Encoding UTF8
Write-Host "API parsing paths fixed successfully!"
