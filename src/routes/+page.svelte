<script>
  // Component logic here
</script>

<svelte:head>
  <title>Amr Thabit | Software Developer</title>
  <meta
    name="description"
    content="Software developer based in Ontario, Canada with a passion for clean, elegant solutions."
  />
</svelte:head>

<div class="page-container">
  <div class="main-content">
    <h1>Amr Thabit</h1>
    
    <p>
      Software developer based in Ontario, Canada with a background in computer science 
      from McMaster University. Currently working as a Project Engineer II at Evertz 
      Microsystems. I like collaborating, learning, and building. Feel free to reach out:
    </p>
    
    <div class="social">
      <a href="mailto:contact@amrthabit.com" class="social-link">Email</a>
      <a
        href="https://linkedin.com/in/AmrThabit"
        target="_blank"
        rel="noopener noreferrer"
        class="social-link">LinkedIn</a
      >
      <a
        href="https://github.com/amrthabit"
        target="_blank"
        rel="noopener noreferrer"
        class="social-link">GitHub</a
      >
      <a
        href="https://instagram.com/thbbit"
        target="_blank"
        rel="noopener noreferrer"
        class="social-link">Instagram</a
      >
    </div>

    <div class="projects-card">
      <h2>Projects & Writings</h2>
      <p class="projects-intro">Funny static sites and random experiments</p>
      <div class="project-links">
        <!-- Projects will be added here -->
        <span class="coming-soon">Coming soon...</span>
      </div>
    </div>
  </div>
</div>

<style lang="scss">
  .projects-card {
    margin-top: 3rem;
    padding: 2rem;
    background: rgba(255, 255, 255, 0.02);
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 8px;
    backdrop-filter: blur(3px);

    h2 {
      font-size: 1.5rem;
      margin-bottom: 0.5rem;
      font-weight: 600;
    }

    .projects-intro {
      font-size: 1rem;
      margin-bottom: 1.5rem;
      opacity: 0.7;
    }

    .project-links {
      display: flex;
      flex-direction: column;
      gap: 0.75rem;

      a {
        color: #e0e0e0;
        text-decoration: none;
        font-size: 1.1rem;
        padding: 0.5rem 0;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        transition: all 0.3s ease;

        &:hover {
          color: #fff;
          border-bottom-color: rgba(255, 255, 255, 0.3);
          padding-left: 0.5rem;
        }

        &:last-child {
          border-bottom: none;
        }
      }

      .coming-soon {
        color: rgba(255, 255, 255, 0.4);
        font-style: italic;
        font-size: 0.95rem;
      }
    }
  }

  @media (max-width: 768px) {
    .projects-card {
      margin-top: 2rem;
      padding: 1.5rem;

      h2 {
        font-size: 1.3rem;
      }
    }
  }
</style>
