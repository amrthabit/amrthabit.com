param(
    [switch]$NoInvalidation = $false,
    [switch]$NoS3Sync = $false
)

# Stop on any error
$ErrorActionPreference = 'Stop'

# Ensure we're in the root directory
$rootDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
Push-Location $rootDir

try {
    # Construct flags based on parameters
    $flags = @()
    if ($NoInvalidation) { $flags += "--no-invalidation" }
    if ($NoS3Sync) { $flags += "--no-s3-sync" }

    # Check if image exists
    if (-not (docker images amrthabit-builder -q)) {
        throw "Docker image 'amrthabit-builder' not found. Please run docker-build.ps1 first."
    }

    # Run the Docker container
    $command = "docker run -v ${PWD}:/workspace amrthabit-builder /usr/local/bin/build.sh $($flags -join ' ')"
    Write-Host "Running: $command" -ForegroundColor Cyan
    Invoke-Expression $command

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Docker build completed successfully!" -ForegroundColor Green
    } else {
        throw "Docker run failed with exit code $LASTEXITCODE"
    }
} catch {
    Write-Host "Error running Docker container: $_" -ForegroundColor Red
    exit 1
} finally {
    Pop-Location
}