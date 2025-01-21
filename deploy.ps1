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

    # Build project
    Write-Log "Building project..." -Color Yellow
    $buildOutput = ng build --configuration production *>&1 | Tee-Object -Variable fullOutput

    # Ensure the assets directory exists
    New-Item -ItemType Directory -Force -Path "dist/assets"

    # Initialize buildInfo object
    $buildInfo = @{
        timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
        hash = ""
        buildTime = ""
        chunks = @()
        buildLocation = "Local (PowerShell)"
    }

    # Parse the build output
    $fullOutput | ForEach-Object {
        $line = $_
        Write-Log $line

        # Extract Hash and Build Time
        if ($line -match "Hash: ([a-f0-9]+).*Time: (\d+)ms") {
            $buildInfo.hash = $matches[1]
            $buildInfo.buildTime = $matches[2]
        }

        # Collect chunk information
        if ($line -match "\.(js|css)\s+\|.*\|.*\|") {
            $buildInfo.chunks += $line.Trim()
        }
    }

    # Save build info to JSON file
    $buildInfoJson = $buildInfo | ConvertTo-Json
    Write-Log "Saving build info to dist/assets/build-info.json" -Color Yellow
    $buildInfoJson | Out-File -FilePath "dist/assets/build-info.json" -Encoding UTF8

    # S3 sync if not disabled
    if (-not $NoS3Sync) {
        Write-Log "Testing S3 sync..." -Color Yellow
        Write-Log "Syncing to bucket with cache headers..."
        aws s3 sync dist/ s3://amrthabit.com --delete --cache-control max-age=31536000,public

        Write-Log "Updating index.html with no-cache..."
        aws s3 cp dist/index.html s3://amrthabit.com/index.html --cache-control no-cache
    } else {
        Write-Log "Skipping S3 sync (--no-s3-sync flag set)" -Color Yellow
    }

    # CloudFront invalidation if not disabled
    if (-not $NoInvalidation) {
        Write-Log "Creating CloudFront invalidation..." -Color Yellow
        aws cloudfront create-invalidation --distribution-id E2AOZ72PC8R9GV --paths "/*"
    } else {
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