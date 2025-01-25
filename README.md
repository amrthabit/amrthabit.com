# [amrthabit.com](https://amrthabit.com)

Personal website built with Angular, featuring dynamic UI elements and automated AWS deployment.

## Technology Stack

- **Frontend**: Angular 16.0.4 with SCSS
- **Infrastructure**: AWS (S3, CloudFront, Route 53)
- **CI/CD**: AWS CodeBuild with GitHub integration
- **Build Tools**: Docker for local development

## Key Features

- Dynamic UI with custom animations and glitch effects
- Responsive design with mobile-first approach
- Form validation with haptic feedback
- Automated AWS deployment pipeline
- Local development environment with Docker

## Quick Start

1. **Local Development**
```powershell
# Start development server
ng serve --ssl true

# Build and deploy locally (with Docker)
.\build-local.ps1
```

2. **Production Deployment**
```powershell
# Using Docker (recommended)
.\build-local.ps1

# Using PowerShell
.\deploy.ps1
```
## AWS Configuration

Configuration in `.aws/`:
- `cloudformation.yml`: AWS resources
- `buildspec.yml`: AWS CodeBuild instructions
- `deployment.yml`: Deployment parameters
- `certificate.yml`: SSL/TLS configuration

IMPORTANT: Next, read [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md) for codebase organization.
