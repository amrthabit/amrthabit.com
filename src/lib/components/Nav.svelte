<script>
  let scrollY;
  $: isScrolled = scrollY > 20;
</script>

<svelte:window bind:scrollY />

<nav class={isScrolled ? 'scrolled' : ''}>
  <div class="container">
    <a href="/" class="logo">AT</a>
  </div>
</nav>

<style lang="scss">
  nav {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 100;
    transition: all 0.3s ease;
    background-color: transparent;
    padding: 1rem 0;
    
    &.scrolled {
      background-color: rgba(26, 26, 26, 0.9);
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }
  }
  
  .container {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .logo {
    font-family: 'TeX Gyre Pagella', Palatino, serif;
    font-size: 1.5rem;
    font-weight: 700;
  }
</style>
