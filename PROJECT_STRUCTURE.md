# Project Structure

## Core Directories

```
.
├── .aws/                   # AWS configuration files
├── src/
│   ├── app/               # Angular components
│   ├── assets/            # Static files
│   └── styles/            # Global SCSS files
├── build.sh               # Docker build script
├── scripts/                # Build scripts
```

## Key Components

### AWS Configuration
- `cloudformation.yml`: Resources and IAM roles
- `buildspec.yml`: CodeBuild pipeline
- `deployment.yml`: S3 and CloudFront settings

### Build Scripts
- `README.md`: Read this to understand what is happening in this directory

### Angular Components
- `about/`: Bio and information
- `contact/`: Email form with haptic feedback
- `projects/`: Portfolio showcase
- `title/`: Animated header
- `links/`: Social and external links

### Styles
- `_variables.scss`: Global variables
- `_animations.scss`: Custom animations
- `_mixins.scss`: Reusable patterns

## Development Guidelines

1. **Component Structure**
- Maintain single responsibility
- Keep styles scoped
- Document complex animations

2. **Style Architecture**
- Follow existing naming patterns
- Use provided mixins
- Maintain responsive design

3. **Build Process**
- Test Docker builds locally
- Verify AWS deployments
- Monitor build artifacts