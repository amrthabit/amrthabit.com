# Stop on any error
$ErrorActionPreference = 'Stop'

Write-Host "Building Docker image..." -ForegroundColor Cyan

# Ensure we're in the root directory
$rootDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
Push-Location $rootDir

try {
    # Remove existing image if it exists
    $imageName = "amrthabit-builder"
    if (docker images $imageName -q) {
        Write-Host "Removing existing image..." -ForegroundColor Yellow
        docker rmi $imageName -f
    }

    # Build new image
    Write-Host "Building new image..." -ForegroundColor Yellow
    docker build -t $imageName -f scripts/docker/Dockerfile .
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Docker image built successfully!" -ForegroundColor Green
    } else {
        throw "Docker build failed with exit code $LASTEXITCODE"
    }
} catch {
    Write-Host "Error building Docker image: $_" -ForegroundColor Red
    exit 1
} finally {
    Pop-Location
}