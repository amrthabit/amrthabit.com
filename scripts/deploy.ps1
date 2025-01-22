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

    # Install ESLint dependencies if not present
    Write-Log "Checking ESLint dependencies..." -Color Yellow
    if (-not (Test-Path "node_modules/@angular-eslint")) {
        Write-Log "Installing ESLint dependencies..." -Color Yellow
        npm install --save-dev @angular-eslint/builder @angular-eslint/eslint-plugin @angular-eslint/eslint-plugin-template @angular-eslint/schematics @angular-eslint/template-parser
        ng add @angular-eslint/schematics
    }

    # Install dependencies
    Write-Log "Installing dependencies..." -Color Yellow
    npm install -g @angular/cli
    npm install --legacy-peer-deps

    # Run lint
    Write-Log "Running lint..." -Color Yellow
    npm run lint

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
    $buildOutput = ng build --configuration production *>&1 | Tee-Object -Variable fullOutput

    # Update buildInfo object with actual values
    $fullOutput | ForEach-Object {
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
    $buildInfo.chunks[-1] = $buildInfo.chunks[-1].PadLeft($buildInfo.chunks[0].Length)

    # Update both src and dist build info files
    Write-BuildInfo -BuildInfo $buildInfo -Path "src/assets/build-info.json"
    Write-BuildInfo -BuildInfo $buildInfo -Path "dist/assets/build-info.json"

    # S3 sync if not disabled
    if (-not $NoS3Sync) {
        Write-Log "Testing S3 sync..." -Color Yellow
        Write-Log "Syncing to bucket with cache headers..."
        aws s3 sync dist/ s3://amrthabit.com --delete --cache-control max-age=31536000 --exclude "index.html"
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
    Write-Log $_.ScriptStackTrace -Color Red
    exit 1
}