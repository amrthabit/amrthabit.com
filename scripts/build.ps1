param(
    [ValidateSet('local', 'docker', 'wsl')]
    [string]$Mode = 'local',
    [switch]$NoInvalidation = $false,
    [switch]$NoS3Sync = $false
)

$ErrorActionPreference = 'Stop'

# Function to convert PowerShell switches to command line args
function Get-FlagString {
    $flags = @()
    if ($NoInvalidation) { $flags += "--no-invalidation" }
    if ($NoS3Sync) { $flags += "--no-s3-sync" }
    return $flags -join ' '
}

switch ($Mode) {
    'local' {
        Write-Host "Running local PowerShell build..."
        & "$PSScriptRoot\deploy.ps1" -NoInvalidation:$NoInvalidation -NoS3Sync:$NoS3Sync
    }
    'docker' {
        Write-Host "Running Docker build..."
        
        # Check if image exists
        if (-not (docker images amrthabit-builder -q)) {
            Write-Host "Docker image not found. Building first..."
            & "$PSScriptRoot\docker\docker-build.ps1"
        }
        
        & "$PSScriptRoot\docker\docker-run.ps1" -NoInvalidation:$NoInvalidation -NoS3Sync:$NoS3Sync
    }
    'wsl' {
        Write-Host "Running WSL build..."
        $flags = Get-FlagString
        wsl bash ./scripts/docker/build.sh $flags   
    }
} 