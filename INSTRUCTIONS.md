# Development Instructions

## Setup

1. **Prerequisites**
- Node.js 16.x
- Docker Desktop
- AWS CLI (configured)
- Angular CLI: `npm install -g @angular/cli`

2. **Installation**
```bash
git clone https://github.com/amrthabit/amrthabit.com.git
cd amrthabit.com
npm install --legacy-peer-deps
```

## Development

1. **Local Server**
```bash
# Development with SSL (required for haptic feedback)
ng serve --ssl true
```

2. **Docker Build**
```powershell
# Build and deploy using Docker
.\build-local.ps1
```

3. **Manual Deployment**
```powershell
# Full deployment with CloudFront invalidation
.\deploy.ps1

# Skip invalidation
.\deploy.ps1 -NoInvalidation

# Skip S3 sync
.\deploy.ps1 -NoS3Sync
```

## Best Practices

1. **Styling**
- Use variables from `_variables.scss`
- Follow existing animation patterns
- Test responsive layouts

2. **Performance**
- Optimize animations for mobile
- Test touch interactions
- Monitor bundle size

3. **Development Flow**
- Test locally with Docker
- Verify AWS credentials
- Check build-info.json generation

See [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md) for codebase organization.