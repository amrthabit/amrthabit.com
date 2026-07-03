# Project Structure

This is a personal website built with SvelteKit, styled as a Wikipedia article about its subject. Here's a breakdown of the project structure:

## Root Files
- `package.json` - Project dependencies and scripts
- `svelte.config.js` - SvelteKit configuration (adapter-static; every route is prerendered)
- `vite.config.ts` - Vite bundler configuration
- `tsconfig.json` - TypeScript configuration
- `.gitignore` - Files to be ignored by git

## Directories

### /src
The main source code directory.

#### /src/app.html
The main HTML template for the entire application. Contains:
- Viewport and theme-color meta tags (paired light/dark `theme-color` values)
- An inline script that applies saved appearance settings (theme, text size, width, from the `appearance` localStorage key) before first paint
- Head/body placeholders for SvelteKit

No webfonts are loaded: like real Wikipedia, body text uses the system `sans-serif` and headings use the local Linux Libertine/Georgia serif stack.

#### /src/hooks.server.js
Rewrites `<html lang="en">` to `<html lang="ar" dir="rtl">` for the `/ar` route. Runs at prerender time, so the built Arabic HTML is a proper RTL Arabic document.

#### /src/app.d.ts
TypeScript declarations for the project.

#### /src/routes
SvelteKit uses file-based routing.

- `/src/routes/+layout.js` - Exports `prerender = true` (the whole site is static)
- `/src/routes/+layout.svelte` - The main layout that wraps all pages
- `/src/routes/+page.svelte` - The main page of the site (English Wikipedia-style article)
- `/src/routes/ar/+page.svelte` - Arabic version of the article (RTL, linked via the language bar)
- `/src/routes/styles.scss` - Global styles: reset, theme tokens, and the shared article skin

#### /src/lib
Custom components and utilities, imported via `$lib`.

- `/src/lib/index.ts` - `calcAge()` helper shared by both language pages
- `/src/lib/components/Appearance.svelte` - The Wikipedia-style Appearance panel (text size, color, width), used by both pages with localized labels; persists to localStorage and syncs the theme-color meta

### /static
Static assets, copied into the build output as-is.

- `/static/favicon.svg` - SVG favicon
- `/static/design/proposals.html` - Self-contained page with 20 landing page mockups (plain to wild); served at `/design/proposals.html` in production, or open the file directly in a browser

## Styling Approach
- Theme tokens as CSS custom properties in `styles.scss`; light is the default, dark comes from `prefers-color-scheme` OR an explicit `data-theme` attribute set by the Appearance panel (the panel overrides the system in both directions). The dark token set is defined once as an SCSS mixin.
- The Wikipedia article skin (infobox, wikitable, contents box, references, etc.) lives once in `styles.scss`, written with CSS logical properties so the same rules render LTR on `/` and mirrored RTL on `/ar`.
- Page components keep only genuinely per-language rules (wordmark typography, LTR table cells in the Arabic works table).

## Design Decisions
- The site is a Wikipedia-article parody of its subject (proposal 09 in `/static/design/proposals.html`): infobox, contents box, wikitable, references, stub notice
- Real Wikipedia conventions where possible; the search box actually searches Wikipedia (Arabic Wikipedia on `/ar`), [edit] links open an email
- Mobile-responsive: the infobox unfloats below 720px

## Build Output
When built (`npm run build`), every route is prerendered into the `/build` directory as plain static files, ready for any web server.
