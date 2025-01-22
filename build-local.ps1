# build-local.ps1

# Get AWS credentials from the credentials file
$awsCredentials = Get-Content "$env:USERPROFILE\.aws\credentials" | Where-Object { $_ -match '=' } | ConvertFrom-StringData
$awsConfig = Get-Content "$env:USERPROFILE\.aws\config" | Where-Object { $_ -match '=' } | ConvertFrom-StringData

# Remove existing image (if exists)
docker rmi amrthabit-codebuild -f

# Build the Docker image
docker build -t amrthabit-codebuild .

# Run the container with mounted AWS credentials and environment variables
docker run -it `
    -v ${PWD}:/workspace `
    -e AWS_ACCESS_KEY_ID=$($awsCredentials.aws_access_key_id) `
    -e AWS_SECRET_ACCESS_KEY=$($awsCredentials.aws_secret_access_key) `
    -e AWS_DEFAULT_REGION=$($awsConfig.region) `
    amrthabit-codebuild