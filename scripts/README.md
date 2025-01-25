# Build Scripts

This directory contains all build and deployment scripts for amrthabit.com.

## Quick Start

Run from the root directory:

```powershell
# Local build (PowerShell)
.\scripts\build-all.ps1

# Docker build
.\scripts\build-all.ps1 -Environment docker

# WSL build
.\scripts\build-all.ps1 -Environment wsl
```

## Available Flags

- `-NoInvalidation` - Skip CloudFront invalidation
- `-NoS3Sync` - Skip S3 sync
- `-KeepPackages` - Skip removing and reinstalling node_modules (faster builds for debugging)
- `-Environment` - Build environment: 'local' (default), 'docker', or 'wsl'

## Directory Structure

- `/scripts`
  - `build-all.ps1` - Main build script that handles all environments
  - `build-local.ps1` - Local build script with build-info.json generation
  - `/docker`
    - `Dockerfile` - Docker configuration
    - `build.sh` - Build script for Docker/WSL
    - `create-image.ps1` - Docker image builder
    - `run-container.ps1` - Docker container runner

## Examples

```powershell
# Build locally without deployment
.\scripts\build-all.ps1 -NoS3Sync

# Build with Docker, no CloudFront invalidation
.\scripts\build-all.ps1 -Environment docker -NoInvalidation

# Full build in WSL
.\scripts\build-all.ps1 -Environment wsl
```