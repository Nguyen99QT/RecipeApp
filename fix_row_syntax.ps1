# PowerShell script to fix the Row syntax issue
$filePath = "c:\RecipeAPPAI2\Flutter Receipe App\recipe_app\lib\pages\home_pages\home_page_componant\home_page_componant_widget.dart"

# Read the file content
$content = Get-Content -Path $filePath -Raw

# The issue is that the Row constructor at line 119 is missing a closing parenthesis
# We need to ensure that the Row constructor is properly closed before the .animateOnPageLoad call

# Look for the specific pattern and fix it
$pattern = "children: \[\s*Padding\(\s*padding:\s*const EdgeInsetsDirectional\.fromSTEB\(0\.0, 0\.0, 16\.0, 0\.0\),"
if ($content -match $pattern) {
    Write-Host "Found the problematic Row pattern"
    
    # Look for the line with .animateOnPageLoad and ensure Row is properly closed
    $lines = $content -split "`n"
    $newLines = @()
    $inRowConstruct = $false
    $rowOpenCount = 0
    
    for ($i = 0; $i -lt $lines.Length; $i++) {
        $line = $lines[$i]
        
        # Check if this is the problematic Row
        if ($line -match "child: Row\(" -and $i -gt 115 -and $i -lt 125) {
            $inRowConstruct = $true
            $rowOpenCount = 1
            Write-Host "Found Row at line $($i + 1)"
        }
        
        if ($inRowConstruct) {
            # Count opening and closing parentheses
            $opens = ($line.ToCharArray() | Where-Object { $_ -eq '(' }).Count
            $closes = ($line.ToCharArray() | Where-Object { $_ -eq ')' }).Count
            $rowOpenCount += $opens - $closes
            
            # If we find the .animateOnPageLoad call and row is not properly closed
            if ($line -match "\.animateOnPageLoad" -and $rowOpenCount -gt 0) {
                # Add the missing closing parenthesis
                $line = $line -replace "(\s*)(\.animateOnPageLoad)", "`$1)`$2"
                $rowOpenCount--
                Write-Host "Fixed line $($i + 1): Added missing ')'"
            }
        }
        
        $newLines += $line
    }
    
    # Write the corrected content back
    $newContent = $newLines -join "`n"
    Set-Content -Path $filePath -Value $newContent -Encoding UTF8
    Write-Host "File has been corrected"
}
else {
    Write-Host "Pattern not found, trying alternative approach"
}
