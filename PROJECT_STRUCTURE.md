# Project Structure

This is a minimal personal website built with SvelteKit. Here's a breakdown of the project structure:

## Root Files
- `package.json` - Project dependencies and scripts
- `svelte.config.js` - SvelteKit configuration
- `vite.config.js` - Vite bundler configuration
- `tsconfig.json` - TypeScript configuration
- `.gitignore` - Files to be ignored by git

## Directories

### /src
The main source code directory.

#### /src/app.html
The main HTML template for the entire application. Contains:
- Meta tags
- Fonts (TeX Gyre Pagella, JetBrains Mono, Public Sans)
- Head placeholders for SvelteKit

#### /src/app.d.ts
TypeScript declarations for the project.

#### /src/routes
SvelteKit uses file-based routing.

- `/src/routes/+layout.svelte` - The main layout that wraps all pages
- `/src/routes/+page.svelte` - The main page of the site
- `/src/routes/styles.scss` - Global styles for the site

#### /src/lib
Custom components and utilities.

- `/src/lib/components/Nav.svelte` - The navigation component

### /static
Static assets like favicons and images.

- `/static/favicon.svg` - SVG favicon

## Styling Approach
- SCSS is used for styling
- A mix of global styles and component-scoped styles
- CSS reset included in global styles
- Dark color scheme with soft whites for text

## Design Decisions
- Minimalist design with focus on typography
- Limited color palette (dark backgrounds, soft white text)
- Mobile-responsive using media queries
- Simple but elegant transitions and hover effects

## Build Output
When built (`npm run build`), the output is generated in the `/build` directory, ready for deployment.
