# PowerShell script to count parentheses and find mismatches
$filePath = "c:\RecipeAPPAI2\Flutter Receipe App\recipe_app\lib\pages\home_pages\home_page_componant\home_page_componant_widget.dart"

# Read the file content
$lines = Get-Content -Path $filePath

$openParens = 0
$openBrackets = 0
$openBraces = 0

Write-Host "Checking parentheses balance line by line..."

for ($i = 0; $i -lt $lines.Length; $i++) {
    $line = $lines[$i]
    $lineNum = $i + 1
    
    # Count opening and closing characters in this line
    $parensOpen = ($line.ToCharArray() | Where-Object { $_ -eq '(' }).Count
    $parensClose = ($line.ToCharArray() | Where-Object { $_ -eq ')' }).Count
    $bracketsOpen = ($line.ToCharArray() | Where-Object { $_ -eq '[' }).Count
    $bracketsClose = ($line.ToCharArray() | Where-Object { $_ -eq ']' }).Count
    $bracesOpen = ($line.ToCharArray() | Where-Object { $_ -eq '{' }).Count
    $bracesClose = ($line.ToCharArray() | Where-Object { $_ -eq '}' }).Count
    
    $openParens += $parensOpen - $parensClose
    $openBrackets += $bracketsOpen - $bracketsClose
    $openBraces += $bracesOpen - $bracesClose
    
    # Check for significant imbalances or key lines
    if ($lineNum -eq 113 -or $lineNum -eq 223 -or $lineNum -eq 294 -or $lineNum -eq 1573) {
        Write-Host "Line $lineNum : Parens=$openParens, Brackets=$openBrackets, Braces=$openBraces"
        Write-Host "  Content: $line"
    }
    
    # Check for severe imbalances
    if ($openParens -lt 0 -or $openBrackets -lt 0 -or $openBraces -lt 0) {
        Write-Host "ERROR at line $lineNum : Negative balance! Parens=$openParens, Brackets=$openBrackets, Braces=$openBraces"
        Write-Host "  Content: $line"
    }
}

Write-Host ""
Write-Host "Final balance:"
Write-Host "Parentheses: $openParens"
Write-Host "Brackets: $openBrackets" 
Write-Host "Braces: $openBraces"

if ($openParens -ne 0 -or $openBrackets -ne 0 -or $openBraces -ne 0) {
    Write-Host "File has mismatched delimiters!"
}
else {
    Write-Host "All delimiters are balanced."
}
