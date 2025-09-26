# Recipe App Admin Panel Backend Startup Script
Write-Host "Starting Recipe App Admin Panel Backend..." -ForegroundColor Green

# Navigate to backend directory
Set-Location -Path ".\backend"

# Check if Java is installed
try {
    $javaVersion = java -version 2>&1
    Write-Host "Java version detected: $javaVersion" -ForegroundColor Yellow
} catch {
    Write-Host "Java not found. Please install Java 17 or higher." -ForegroundColor Red
    exit 1
}

# Check if Maven is installed
try {
    $mavenVersion = mvn -version 2>&1
    Write-Host "Maven detected" -ForegroundColor Yellow
} catch {
    Write-Host "Maven not found. Please install Maven." -ForegroundColor Red
    exit 1
}

# Clean and compile the project
Write-Host "Cleaning and compiling the project..." -ForegroundColor Yellow
mvn clean compile

if ($LASTEXITCODE -eq 0) {
    Write-Host "Project compiled successfully!" -ForegroundColor Green
    
    # Start the Spring Boot application
    Write-Host "Starting Spring Boot Admin Panel..." -ForegroundColor Green
    Write-Host "Admin Panel will be available at: http://localhost:8080" -ForegroundColor Cyan
    mvn spring-boot:run
} else {
    Write-Host "Compilation failed. Please check the errors above." -ForegroundColor Red
    exit 1
}