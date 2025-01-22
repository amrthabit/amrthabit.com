#!/bin/bash

# Parse command line arguments
NO_S3_SYNC=false
NO_INVALIDATION=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --no-s3-sync) NO_S3_SYNC=true ;;
        --no-invalidation) NO_INVALIDATION=true ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

echo "Starting build process..."

# Determine environment
if [ -d "/workspace" ]; then
    WORKING_DIR="/workspace"
    BUILD_LOCATION="Docker Container"
else
    WORKING_DIR="$(pwd)"
    BUILD_LOCATION="WSL"
fi

cd "$WORKING_DIR"

# Check for required tools
command -v node >/dev/null 2>&1 || { echo "Node.js is required but not installed. Aborting." >&2; exit 1; }
command -v npm >/dev/null 2>&1 || { echo "npm is required but not installed. Aborting." >&2; exit 1; }
command -v jq >/dev/null 2>&1 || { echo "jq is required but not installed. Aborting." >&2; exit 1; }

# Install dependencies if needed
echo "Installing dependencies..."
npm install --legacy-peer-deps

# Function to format chunk line for mobile format
format_chunk_line() {
    line="$1"
    file=$(echo "$line" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $1); print $1}')
    name=$(echo "$line" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}')
    raw_size=$(echo "$line" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $3); print $3}')
    transfer_size=$(echo "$line" | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/, "", $4); print $4}')
    
    echo "{\"file\":\"$file\",\"name\":\"$name\",\"rawSize\":\"$raw_size\",\"transferSize\":\"$transfer_size\"}"
}

# Create initial build-info.json
mkdir -p src/assets
cat > src/assets/build-info.json << BUILDJSON
{
    "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")",
    "hash": "building...",
    "buildTime": "0",
    "chunks": [],
    "chunksMobile": [],
    "buildLocation": "$BUILD_LOCATION"
}
BUILDJSON

# Run lint (ignore errors)
echo "Running lint..."
npm run lint || true

# Capture build output and process it
echo "Starting production build..."
ng build --configuration production 2>&1 | tee build.log

# Extract hash and build time
HASH=$(grep "Hash:" build.log | sed -E "s/.*Hash: ([a-f0-9]+).*/\1/")
BUILD_TIME=$(grep "Time:" build.log | sed -E "s/.*Time: ([0-9]+)ms.*/\1/")

# Extract chunks information
CHUNK_LINES=$(awk '/^.*\|.*\|.*\|.*\|/ {print}' build.log)

# Create chunks array (as JSON array of strings)
CHUNKS_JSON=$(echo "$CHUNK_LINES" | jq -R -s 'split("\n")|map(select(length>0))')

# Create chunks mobile array
CHUNKS_MOBILE="["
first=true
while IFS= read -r line; do
    if [ -n "$line" ]; then
        if [ "$first" = true ]; then
            first=false
        else
            CHUNKS_MOBILE+=","
        fi
        CHUNKS_MOBILE+=$(format_chunk_line "$line")
    fi
done <<< "$CHUNK_LINES"
CHUNKS_MOBILE+="]"

# Create final build-info.json
cat > src/assets/build-info.json << EOF
{
    "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")",
    "hash": "$HASH",
    "buildTime": "$BUILD_TIME",
    "chunks": $CHUNKS_JSON,
    "chunksMobile": $CHUNKS_MOBILE,
    "buildLocation": "$BUILD_LOCATION"
}
EOF

# Copy to dist
mkdir -p dist/assets
cp src/assets/build-info.json dist/assets/build-info.json

# Clean up
rm build.log

# Deploy if AWS credentials are present and no-s3-sync is not set
if [ -n "$AWS_ACCESS_KEY_ID" ] && [ -n "$AWS_SECRET_ACCESS_KEY" ] && [ "$NO_S3_SYNC" = false ]; then
    echo "AWS credentials found, proceeding with deployment..."
    
    # Check for AWS CLI
    command -v aws >/dev/null 2>&1 || { echo "AWS CLI is required for deployment but not installed. Skipping deployment." >&2; exit 1; }
    
    aws s3 sync dist/ s3://amrthabit.com --delete --cache-control max-age=31536000 --exclude "index.html"
    aws s3 cp dist/index.html s3://amrthabit.com/index.html --cache-control no-cache
    
    # Create CloudFront invalidation if no-invalidation is not set
    if [ "$NO_INVALIDATION" = false ] && [ -n "$CLOUDFRONT_ID" ]; then
        aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_ID --paths "/*"
    else
        echo "Skipping CloudFront invalidation (--no-invalidation flag set or missing CLOUDFRONT_ID)"
    fi
else
    if [ "$NO_S3_SYNC" = true ]; then
        echo "Skipping S3 sync (--no-s3-sync flag set)"
    else
        echo "Missing AWS credentials, skipping deployment"
    fi
fi