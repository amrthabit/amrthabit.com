param(
    [ValidateSet('local', 'docker', 'wsl')]
    [string]$Environment = 'local',
    [switch]$NoInvalidation = $false,
    [switch]$NoS3Sync = $false,
    [switch]$KeepPackages = $false
)

$ErrorActionPreference = 'Stop'

# Function to convert PowerShell switches to command line args for WSL
function Get-FlagString {
    $flags = @()
    if ($NoInvalidation) { $flags += "--no-invalidation" }
    if ($NoS3Sync) { $flags += "--no-s3-sync" }
    return $flags -join ' '
}

# Store current location
$originalLocation = Get-Location

try {
    # Change to root directory for any environment
    Set-Location (Split-Path $PSScriptRoot)
    Write-Host "Changed to directory: $(Get-Location)"
    
    switch ($Environment) {
        'local' {
            Write-Host "Running local PowerShell build..."
            # Use build-local.ps1 which maintains build-info.json functionality
            & ".\scripts\build-local.ps1" -NoInvalidation:$NoInvalidation -NoS3Sync:$NoS3Sync -KeepPackages:$KeepPackages
            if ($LASTEXITCODE -ne 0) {
                throw "Local build failed with exit code $LASTEXITCODE"
            }
        }
        'docker' {
            Write-Host "Running Docker build..."
            # Check if image exists
            if (-not (docker images amrthabit-builder -q)) {
                Write-Host "Docker image not found. Building first..."
                & ".\scripts\docker\create-image.ps1"
            }
            & ".\scripts\docker\run-container.ps1" -NoInvalidation:$NoInvalidation -NoS3Sync:$NoS3Sync
        }
        'wsl' {
            Write-Host "Running WSL build..."
            $flags = Get-FlagString
            wsl bash ./scripts/docker/build.sh $flags   
        }
    }
}
catch {
    Write-Host "Error during build:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host "Stack trace:" -ForegroundColor Red
    Write-Host $_.ScriptStackTrace -ForegroundColor Red
    exit 1
}
finally {
    # Restore original location
    Set-Location $originalLocation
}