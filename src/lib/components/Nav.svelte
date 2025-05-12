<script>
  let scrollY;
  let innerWidth;

  // Track scroll position for transparent/solid nav switch
  $: isScrolled = scrollY > 50;
  $: isMobile = innerWidth < 768;
  
  let isMenuOpen = false;
  
  function toggleMenu() {
    isMenuOpen = !isMenuOpen;
  }
  
  function closeMenu() {
    isMenuOpen = false;
  }
</script>

<svelte:window bind:scrollY bind:innerWidth />

<nav class={isScrolled ? 'scrolled' : ''}>
  <div class="container nav-container">
    <a href="#" class="logo">AT</a>
    
    {#if isMobile}
      <button class="menu-toggle" on:click={toggleMenu} aria-label="Toggle menu">
        <span></span>
        <span></span>
        <span></span>
      </button>
    {/if}
    
    <ul class={`nav-links ${isMobile ? 'mobile' : ''} ${isMenuOpen ? 'open' : ''}`}>
      <li><a href="#about" on:click={closeMenu}>About</a></li>
      <li><a href="#contact" on:click={closeMenu}>Contact</a></li>
    </ul>
  </div>
</nav>

<style lang="scss">
  nav {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    z-index: 1000;
    transition: all 0.3s ease;
    background-color: transparent;
    padding: 1.5rem 0;
    
    &.scrolled {
      background-color: rgba(26, 26, 26, 0.95);
      padding: 1rem 0;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
  }
  
  .nav-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
  
  .logo {
    font-size: 1.8rem;
    font-weight: 700;
    color: white;
  }
  
  .nav-links {
    display: flex;
    gap: 2rem;
    list-style: none;
    
    li a {
      color: white;
      font-size: 1.1rem;
      transition: opacity 0.3s ease;
      
      &:hover {
        opacity: 0.7;
      }
    }
    
    &.mobile {
      position: fixed;
      flex-direction: column;
      top: 0;
      right: -100%;
      width: 70%;
      height: 100vh;
      background-color: #1a1a1a;
      padding: 5rem 2rem;
      transition: right 0.3s ease;
      
      &.open {
        right: 0;
      }
    }
  }
  
  .menu-toggle {
    background: none;
    border: none;
    cursor: pointer;
    width: 30px;
    height: 20px;
    position: relative;
    z-index: 1001;
    
    span {
      display: block;
      width: 100%;
      height: 2px;
      background-color: white;
      margin: 5px 0;
      transition: all 0.3s ease;
    }
  }
</style>
