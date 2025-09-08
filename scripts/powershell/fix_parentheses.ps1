# PowerShell script to fix the missing closing parenthesis
$filePath = "c:\RecipeAPPAI2\Flutter Receipe App\recipe_app\lib\pages\home_pages\home_page_componant\home_page_componant_widget.dart"

# Read the file content
$lines = Get-Content -Path $filePath

# Find the line with "), and add a closing parenthesis after it
for ($i = 0; $i -lt $lines.Length; $i++) {
    $line = $lines[$i]
    $lineNum = $i + 1
    
    # Look for the specific line where AI Recipe Search button should end
    # This should be around line 378-380 based on previous analysis
    if ($lineNum -ge 375 -and $lineNum -le 385 -and $line -match "^\s*\),\s*$") {
        Write-Host "Found potential AI button end at line $lineNum : $line"
        
        # Check the next few lines to see context
        if ($i + 1 -lt $lines.Length) {
            $nextLine = $lines[$i + 1]
            Write-Host "Next line: $nextLine"
            
            # If next line starts Expanded, this is likely where AI button ends
            if ($nextLine -match "^\s*Expanded\(") {
                Write-Host "Adding closing parenthesis after line $lineNum"
                $lines[$i] = $line + ")"
                break
            }
        }
    }
}

# Write the corrected content back
Set-Content -Path $filePath -Value $lines -Encoding UTF8
Write-Host "File correction attempted"
