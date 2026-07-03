// See https://svelte.dev/docs/kit/types#app.d.ts
// for information about these interfaces
declare global {
	// injected by Vite's define at build time (see vite.config.ts)
	const __BUILD_DATE__: string;

	namespace App {
		// interface Error {}
		// interface Locals {}
		// interface PageData {}
		// interface PageState {}
		// interface Platform {}
	}
}

export {};
