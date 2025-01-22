# Build Scripts

This directory contains all build and deployment scripts for amrthabit.com.

## Quick Start

Run from the root directory:

```powershell
# Local build (PowerShell)
.\scripts\build.ps1

# Docker build
.\scripts\build.ps1 -Mode docker

# WSL build
.\scripts\build.ps1 -Mode wsl
```

## Available Flags

- `-NoInvalidation` - Skip CloudFront invalidation
- `-NoS3Sync` - Skip S3 sync
- `-Mode` - Build mode: 'local' (default), 'docker', or 'wsl'

## Directory Structure

- `/scripts`
  - `build.ps1` - Main build script
  - `deploy.ps1` - Local deployment script
  - `/docker`
    - `Dockerfile` - Docker configuration
    - `build.sh` - Build script for Docker/WSL
    - `docker-build.ps1` - Docker image builder
    - `docker-run.ps1` - Docker container runner

## Examples

```powershell
# Build locally without deployment
.\scripts\build.ps1 -NoS3Sync

# Build with Docker, no CloudFront invalidation
.\scripts\build.ps1 -Mode docker -NoInvalidation

# Full build in WSL
.\scripts\build.ps1 -Mode wsl
```