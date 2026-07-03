# amrthabit.com

A personal website styled as a Wikipedia article about its subject, built with SvelteKit. English at `/`, Arabic (RTL) at `/ar`.

## Features

- Wikipedia-article parody: infobox, contents box, wikitables, references, [citation needed], stub notice
- Light by default, matches the system theme, with a Wikipedia-style Appearance panel (text size, color, width) persisted in localStorage
- Full Arabic translation with a proper RTL document, linked via the language bar
- JSON-LD Person schema and per-language Open Graph tags
- Fully static: every route is prerendered at build time

## Tech Stack

- **SvelteKit** (Svelte 5, adapter-static) - prerendered static output
- **SCSS** - shared article skin with CSS logical properties so RTL mirrors automatically
- **TypeScript** - for type safety
- **Vite** - fast bundling and development server

## Development

### Prerequisites

- Node.js (v20+)
- npm

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/amrthabit/amrthabit.com.git
   cd amrthabit.com
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Start development server:
   ```bash
   npm run dev
   ```

4. Open your browser and visit `http://localhost:5173`

### Building for Production

To create a production build:

```bash
npm run build
```

The output will be in the `build` directory as plain static files.

### Deployment

The build is fully static:

- **Static hosting / self-hosted**: serve the contents of the `build` directory with any web server
- **Vercel/Netlify**: connect the repository; the static adapter output deploys as-is

## Project Structure

See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for a detailed breakdown of the project architecture.

## License

MIT

## Author

Amr Thabit
