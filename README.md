# amrthabit.com

A minimalist personal portfolio website built with SvelteKit.

## Features

- Clean, elegant design with dark theme
- Responsive layout for all device sizes
- Fast and lightweight
- Built with modern web technologies

## Tech Stack

- **SvelteKit** - Modern JavaScript framework with server-side rendering
- **SCSS** - For advanced styling capabilities
- **TypeScript** - For type safety
- **Vite** - Fast bundling and development server

## Development

### Prerequisites

- Node.js (v16+)
- npm or yarn

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/amrthabit.com.git
   cd amrthabit.com
   ```

2. Install dependencies:
   ```bash
   npm install
   # or
   yarn install
   ```

3. Start development server:
   ```bash
   npm run dev
   # or
   yarn dev
   ```

4. Open your browser and visit `http://localhost:5173`

### Building for Production

To create a production build:

```bash
npm run build
# or
yarn build
```

The output will be in the `build` directory.

### Deployment

This site is configured for easy deployment to various platforms:

- **Vercel/Netlify**: Just connect your repository
- **Static hosting**: Upload the contents of the `build` directory

## Project Structure

See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for a detailed breakdown of the project architecture.

## Customization

To customize this site for your own use:

1. Update personal information in `src/routes/+page.svelte`
2. Modify colors and styling in `src/routes/styles.scss`
3. Replace contact links with your own
4. Update the favicon in `static/favicon.svg`

## License

MIT

## Author

Amr Thabit
