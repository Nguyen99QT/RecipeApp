# Script to update IP address in Flutter Recipe App
# Run this script whenever your IP address changes

Write-Host "Flutter Recipe App - IP Address Updater" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Green

# Get current IP address
$currentIp = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -notlike "*Loopback*" -and $_.IPAddress -notlike "169.254.*" -and $_.IPAddress -ne "127.0.0.1"} | Select-Object -First 1).IPAddress

if ($currentIp) {
    Write-Host "Current IP Address: $currentIp" -ForegroundColor Yellow
    
    # Path to api_calls.dart file
    $apiCallsPath = "lib\backend\api_requests\api_calls.dart"
    
    if (Test-Path $apiCallsPath) {
        # Read the file content
        $content = Get-Content $apiCallsPath -Raw
        
        # Check current IP in the file
        if ($content -match "return 'http://([0-9.]+):8190/api';") {
            $oldIp = $matches[1]
            Write-Host "IP in file: $oldIp" -ForegroundColor Cyan
            
            if ($oldIp -ne $currentIp -and $oldIp -ne "10.0.2.2") {
                $response = Read-Host "Do you want to update IP from $oldIp to $currentIp? (y/n)"
                
                if ($response -eq "y" -or $response -eq "Y") {
                    # Update the IP address
                    $newContent = $content -replace "http://$oldIp:8190/api", "http://$currentIp:8190/api"
                    Set-Content $apiCallsPath -Value $newContent
                    
                    Write-Host "IP address updated successfully!" -ForegroundColor Green
                    Write-Host "Old IP: $oldIp" -ForegroundColor Red
                    Write-Host "New IP: $currentIp" -ForegroundColor Green
                    
                    Write-Host "`nNext steps:" -ForegroundColor Yellow
                    Write-Host "1. Restart your Flutter app" -ForegroundColor White
                    Write-Host "2. Make sure your admin panel is running on $currentIp" -ForegroundColor White
                } else {
                    Write-Host "IP update cancelled." -ForegroundColor Yellow
                }
            } elseif ($oldIp -eq "10.0.2.2") {
                Write-Host "Currently using emulator IP (10.0.2.2) - this is correct for Android emulator" -ForegroundColor Green
            } else {
                Write-Host "IP address is already up to date!" -ForegroundColor Green
            }
        } else {
            Write-Host "Could not find IP pattern in api_calls.dart" -ForegroundColor Red
        }
    } else {
        Write-Host "Error: Could not find api_calls.dart file" -ForegroundColor Red
        Write-Host "Make sure you're running this script from the Flutter project root directory" -ForegroundColor Yellow
    }
} else {
    Write-Host "Error: Could not detect current IP address" -ForegroundColor Red
}

Write-Host "`nCurrent network status:" -ForegroundColor Yellow
Write-Host "Admin Panel should be running on: http://$currentIp:8190" -ForegroundColor White
Write-Host "API endpoint: http://$currentIp:8190/api" -ForegroundColor White

Write-Host "`nPress any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")