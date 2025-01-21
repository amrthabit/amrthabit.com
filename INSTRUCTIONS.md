# Development Instructions

## Setup

1. **Prerequisites**
   ```bash
   # Install Node.js LTS version
   # Install Angular CLI globally
   npm install -g @angular/cli
   ```

2. **Installation**
   ```bash
   # Clone the repository
   git clone https://github.com/amrthabit/amrthabit.com.git
   
   # Navigate to project directory
   cd amrthabit.com
   
   # Install dependencies
   npm install
   ```

3. **Development Server**
   ```bash
   # Start development server
   ng serve
   
   # For HTTPS (needed for vibration API)
   ng serve --ssl true
   
   # For custom cert
   ng serve --ssl true --ssl-cert path/to/cert.pem --ssl-key path/to/key.pem
   ```

## Development Guidelines

### Working with Styles

1. **Using Variables**
   - Always use variables from `_variables.scss` for consistency
   - Add new variables to appropriate sections
   - Use semantic naming for new variables

2. **Adding Animations**
   - Define new animations in `_animations.scss`
   - Use existing animation curves when possible
   - Test performance on mobile devices

3. **Responsive Design**
   - Use provided mixins for breakpoints
   - Test all features on mobile devices
   - Ensure touch targets are adequate size

### Animation Development

1. **Glitch Effects**
   ```scss
   // Example of adding glitch effect
   .element {
     animation: glitch-text 3s infinite $curve-smooth;
   }
   ```

2. **Performance**
   - Use hardware-accelerated properties
   - Test animations on lower-end devices
   - Provide reduced motion alternatives

## Testing

1. **Unit Tests**
   ```bash
   # Run unit tests
   ng test
   ```

2. **End-to-End Tests**
   ```bash
   # Run e2e tests
   ng e2e
   ```

3. **Manual Testing Checklist**
   - Test on multiple browsers
   - Test on various mobile devices
   - Verify form validation
   - Check animation performance
   - Test haptic feedback
   - Verify responsive layouts

## Building

1. **Development Build**
   ```bash
   ng build
   ```

2. **Production Build**
   ```bash
   ng build --configuration production
   ```

## Deployment

1. **AWS S3 Deployment**
   ```bash
   # Install AWS CLI
   # Configure AWS credentials
   
   # Sync build folder with S3
   aws s3 sync dist/amrthabit s3://your-bucket-name
   ```

2. **CloudFront Update**
   ```bash
   # Invalidate CloudFront cache
   aws cloudfront create-invalidation --distribution-id YOUR_DISTRIBUTION_ID --paths "/*"
   ```

## Troubleshooting

### Common Issues

1. **Vibration API Not Working**
   - Ensure HTTPS is enabled
   - Check browser support
   - Verify user interaction occurred

2. **Animation Performance**
   - Reduce animation complexity
   - Use hardware acceleration
   - Check browser dev tools performance panel

3. **CORS Issues**
   - Check API endpoint configuration
   - Verify SSL certificates
   - Review security headers

## Best Practices

1. **Code Organization**
   - Follow Angular style guide
   - Keep components focused and small
   - Use TypeScript features appropriately
   - Always write complete code, never use "previous styles remain the same" or similar
   - Reread files before modifying them if they're frequently updated

2. **Performance**
   - Optimize images and assets
   - Minimize bundle size
   - Use lazy loading where appropriate
   - Consider animation performance impact

3. **Security**
   - Validate all inputs
   - Sanitize user content
   - Keep dependencies updated

4. **Code Clarity**
   - Write complete, explicit code without shortcuts
   - Include all necessary styles even if unchanged
   - Document changes comprehensively
   - Maintain full context in code reviews
