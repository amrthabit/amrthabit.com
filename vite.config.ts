import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
	plugins: [sveltekit()],
	define: {
		// full ISO 8601 datetime; ProfilePage dateModified requires time + zone
		__BUILD_DATE__: JSON.stringify(new Date().toISOString())
	}
});
