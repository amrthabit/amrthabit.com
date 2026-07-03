<script>
  import { browser } from '$app/environment';

  let { labels = {} } = $props();
  const L = $derived({
    button: 'Appearance',
    text: 'Text',
    color: 'Color',
    width: 'Width',
    small: 'Small',
    standard: 'Standard',
    large: 'Large',
    auto: 'Automatic',
    light: 'Light',
    dark: 'Dark',
    wide: 'Wide',
    ...labels
  });

  // The inline script in app.html applied saved settings before paint;
  // read them back as the initial state. On the server, defaults are fine.
  const ds = browser ? document.documentElement.dataset : {};
  let panelOpen = $state(false);
  let theme = $state(ds.theme ?? 'auto');
  let font = $state(ds.font ?? 'standard');
  let width = $state(ds.width ?? 'standard');

  const LIGHT = '#ffffff';
  const DARK = '#101418';

  $effect(() => {
    const d = document.documentElement.dataset;
    if (theme === 'auto') delete d.theme;
    else d.theme = theme;
    if (font === 'standard') delete d.font;
    else d.font = font;
    if (width === 'standard') delete d.width;
    else d.width = width;

    // keep the browser chrome color in step with the effective theme
    for (const m of document.querySelectorAll('meta[name="theme-color"]')) {
      const media = m.getAttribute('media') ?? '';
      const autoValue = media.includes('dark') ? DARK : LIGHT;
      m.setAttribute('content', theme === 'dark' ? DARK : theme === 'light' ? LIGHT : autoValue);
    }

    try {
      localStorage.setItem('appearance', JSON.stringify({ theme, font, width }));
    } catch {
      // private browsing; settings just will not persist
    }
  });
</script>

<svelte:window
  onclick={(e) => {
    if (panelOpen && e.target instanceof Element && !e.target.closest('.appearance')) {
      panelOpen = false;
    }
  }}
  onkeydown={(e) => {
    if (e.key === 'Escape') panelOpen = false;
  }}
/>

<div class="appearance">
  <button
    type="button"
    class="app-btn"
    aria-expanded={panelOpen}
    aria-controls="appearance-panel"
    onclick={() => (panelOpen = !panelOpen)}
  >
    {L.button}
  </button>
  {#if panelOpen}
    <div class="app-panel" id="appearance-panel">
      <fieldset>
        <legend>{L.text}</legend>
        <label><input type="radio" bind:group={font} value="small" /> {L.small}</label>
        <label><input type="radio" bind:group={font} value="standard" /> {L.standard}</label>
        <label><input type="radio" bind:group={font} value="large" /> {L.large}</label>
      </fieldset>
      <fieldset>
        <legend>{L.color}</legend>
        <label><input type="radio" bind:group={theme} value="auto" /> {L.auto}</label>
        <label><input type="radio" bind:group={theme} value="light" /> {L.light}</label>
        <label><input type="radio" bind:group={theme} value="dark" /> {L.dark}</label>
      </fieldset>
      <fieldset>
        <legend>{L.width}</legend>
        <label><input type="radio" bind:group={width} value="standard" /> {L.standard}</label>
        <label><input type="radio" bind:group={width} value="wide" /> {L.wide}</label>
      </fieldset>
    </div>
  {/if}
</div>

<style>
  .appearance {
    position: relative;
  }
  .app-btn {
    border: 1px solid var(--line);
    border-radius: 2px;
    background: var(--box);
    color: var(--ink);
    font-size: 12.5px;
    padding: 6px 12px;
    cursor: pointer;
  }
  .app-btn:focus-visible {
    outline: 2px solid var(--link);
  }
  .app-panel {
    position: absolute;
    inset-inline-end: 0;
    top: calc(100% + 6px);
    z-index: 100;
    width: 180px;
    background: var(--paper);
    border: 1px solid var(--line);
    border-radius: 2px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.18);
    padding: 12px 14px 4px;
    font-size: 13px;
  }
  .app-panel fieldset {
    border: none;
    margin-bottom: 10px;
  }
  .app-panel legend {
    font-weight: 700;
    font-size: 12px;
    margin-bottom: 3px;
  }
  .app-panel label {
    display: block;
    cursor: pointer;
    padding: 1px 0;
  }
  .app-panel input {
    accent-color: var(--link);
    margin-inline-end: 4px;
  }
</style>
