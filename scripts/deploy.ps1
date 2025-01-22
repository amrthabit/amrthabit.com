# Test deployment script for amrthabit.com
param(
    [switch]$NoInvalidation = $false,
    [switch]$NoS3Sync = $false
)

# Create logs directory if it doesn't exist
New-Item -ItemType Directory -Force -Path "logs"

# Setup logging
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$logFile = "logs/deploy_$timestamp.log"

function Write-Log {
    param($Message, $Color = "White")
    
    # Get the current timestamp
    $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    # Write to console with color
    Write-Host $Message -ForegroundColor $Color
    
    # Write to log file with timestamp
    "$timeStamp - $Message" | Out-File -FilePath $logFile -Append
}

# Function to write build info to a specific path
function Write-BuildInfo {
    param($BuildInfo, $Path)
    Write-Log "Writing build-info.json to: $Path" -Color Yellow
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Path)
    $BuildInfo | ConvertTo-Json | Out-File -FilePath $Path -Encoding UTF8
}

# Function to parse chunk line into mobile format
function Format-ChunkForMobile {
    param($ChunkLine)
    if ($ChunkLine -match "^\s*(.*?)\s*\|\s*(.*?)\s*\|\s*(.*?)\s*\|\s*(.*?)\s*$") {
        return @{
            file         = $matches[1].Trim()
            name         = $matches[2].Trim()
            rawSize      = $matches[3].Trim()
            transferSize = $matches[4].Trim()
        }
    }
    return $null
}

try {
    Write-Log "Starting deployment test..." -Color Cyan
    Write-Log "Options: NoInvalidation=$NoInvalidation, NoS3Sync=$NoS3Sync" -Color Yellow

    # Clean node_modules and package-lock.json
    if (Test-Path "node_modules") {
        Write-Log "Cleaning node_modules..." -Color Yellow
        Remove-Item -Recurse -Force "node_modules"
    }
    if (Test-Path "package-lock.json") {
        Write-Log "Cleaning package-lock.json..." -Color Yellow
        Remove-Item -Force "package-lock.json"
    }

    # Install dependencies
    Write-Log "Installing dependencies..." -Color Yellow
    npm install --legacy-peer-deps

    # Create initial build info
    $buildInfo = @{
        timestamp     = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
        hash          = "building..."
        buildTime     = "0"
        chunks        = @()
        chunksMobile  = @()
        buildLocation = "Local (PowerShell)"
    }

    # Write initial build info to src/assets (for ng serve)
    Write-BuildInfo -BuildInfo $buildInfo -Path "src/assets/build-info.json"

    # Build project
    Write-Log "Building project..." -Color Yellow
    $buildOutput = ng build --configuration production 2>&1
    
    if ($LASTEXITCODE -ne 0) {
        Write-Log "Build failed. Full output:" -Color Red
        $buildOutput | ForEach-Object { Write-Log $_ -Color Red }
        throw "Build failed with exit code $LASTEXITCODE"
    }

    # Update buildInfo object with actual values
    $buildOutput | ForEach-Object {
        $line = $_

        # Extract Hash and Build Time
        if ($line -match "Hash: ([a-f0-9]+).*Time: (\d+)ms") {
            $buildInfo.hash = $matches[1]
            $buildInfo.buildTime = $matches[2]
        }

        # Collect chunk information
        if ($line -match "\|.*\|.*\|") {
            $buildInfo.chunks += $line
            $mobileChunk = Format-ChunkForMobile -ChunkLine $line
            if ($mobileChunk) {
                $buildInfo.chunksMobile += $mobileChunk
            }
        }
    }
    
    # Left pad last line with spaces to match chunk line length
    if ($buildInfo.chunks.Count -gt 0) {
        $buildInfo.chunks[-1] = $buildInfo.chunks[-1].PadLeft($buildInfo.chunks[0].Length)
    }

    # Update both src and dist build info files
    Write-BuildInfo -BuildInfo $buildInfo -Path "src/assets/build-info.json"
    Write-BuildInfo -BuildInfo $buildInfo -Path "dist/assets/build-info.json"

    # S3 sync if not disabled
    if (-not $NoS3Sync) {
        Write-Log "Testing S3 sync..." -Color Yellow
        Write-Log "Syncing to bucket with cache headers..."
        aws s3 sync dist/ s3://amrthabit.com --delete 
    }
    else {
        Write-Log "Skipping S3 sync (--no-s3-sync flag set)" -Color Yellow
    }

    # CloudFront invalidation if not disabled
    if (-not $NoInvalidation) {
        Write-Log "Creating CloudFront invalidation..." -Color Yellow
        aws cloudfront create-invalidation --distribution-id E2AOZ72PC8R9GV --paths "/*"
    }
    else {
        Write-Log "Skipping CloudFront invalidation (--no-invalidation flag set)" -Color Yellow
    }

    Write-Log "Test deployment complete!" -Color Green
}
catch {
    Write-Log "Error occurred during deployment:" -Color Red
    Write-Log $_.Exception.Message -Color Red
    Write-Log "Stack trace:" -Color Red
    Write-Log $_.ScriptStackTrace -Color Red
    exit 1
}