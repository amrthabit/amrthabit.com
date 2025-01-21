# Project Structure

## Directory Organization

```
src/
├── app/                      # Application components
│   ├── about/               # About page component
│   ├── contact/             # Contact section
│   ├── contact-form/        # Contact form component
│   ├── dialog/             # Reusable dialog component
│   ├── links/              # Links section
│   ├── projects/           # Projects section
│   ├── title/              # Title component with animations
│   └── app.component.*     # Root component files
├── assets/                  # Static assets
│   ├── fonts/              # Custom fonts
│   └── icons/              # SVG icons
└── styles/                  # Global styles
    ├── _variables.scss     # Global SCSS variables
    ├── _animations.scss    # Animation definitions
    ├── _about.scss        # About-specific variables
    └── _mixins.scss       # Reusable mixins

```

## Style Architecture

### Variables Organization (`_variables.scss`)
- Typography (fonts, sizes, weights)
- Colors (primary, background, text, states)
- Spacing scales
- Breakpoints
- Animation timings
- Component-specific variables
- Z-index scales

### Animations (`_animations.scss`)
- Transition curves
- Animation mixins
- Keyframe definitions
- Interactive effects

### Mixins (`_mixins.scss`)
- Responsive design helpers
- Common patterns
- Layout utilities
- Interactive states

## Component Structure

### Each component typically includes:
- Component class (`.ts`)
- Template (`.html`)
- Styles (`.scss`)
- Tests (`.spec.ts`)

### Key Components:

#### Contact Form
- Form validation
- Haptic feedback
- Success/error states
- Loading states
- Responsive layout

#### Title
- Advanced glitch effects
- Chromatic aberration
- Interactive animations
- Responsive scaling

#### Dialog
- Modal overlay
- Animation transitions
- Backdrop effects

## Style Guidelines

### SCSS Best Practices
- Use variables for repeated values
- Nest selectors max 3 levels deep
- Follow BEM naming when applicable
- Use mixins for repeated patterns
- Keep component styles modular

### Animation Guidelines
- Use curves for smooth transitions
- Keep animations under 400ms
- Provide reduced-motion alternatives
- Use transform over position properties
- Optimize for performance

### Responsive Design
- Mobile-first approach
- Use standard breakpoints
- Fluid typography
- Flexible layouts
- Touch-optimized interactions

### Accessibility
- Semantic HTML
- ARIA labels where needed
- Keyboard navigation
- Focus management
- Screen reader support