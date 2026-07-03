<script>
  import { calcAge } from '$lib';
  import Appearance from '$lib/components/Appearance.svelte';

  const age = calcAge();

  // client-side navigation from /ar must restore the document language
  $effect(() => {
    const root = document.documentElement;
    root.lang = 'en';
    root.dir = 'ltr';
  });

  const personSchema = JSON.stringify({
    '@context': 'https://schema.org',
    '@type': 'Person',
    name: 'Amr Thabit',
    url: 'https://amrthabit.com',
    email: 'mailto:contact@amrthabit.com',
    birthDate: '2001-08',
    birthPlace: { '@type': 'Country', name: 'Yemen' },
    homeLocation: { '@type': 'City', name: 'Hamilton, Ontario, Canada' },
    jobTitle: 'Project Engineer II',
    worksFor: { '@type': 'Organization', name: 'Evertz Microsystems' },
    alumniOf: { '@type': 'CollegeOrUniversity', name: 'McMaster University' },
    knowsLanguage: ['en', 'ar'],
    sameAs: [
      'https://github.com/amrthabit',
      'https://linkedin.com/in/AmrThabit',
      'https://instagram.com/thbbit'
    ]
  });
</script>

<svelte:head>
  <title>Amr Thabit</title>
  <meta
    name="description"
    content="Software developer based in Ontario, Canada with a passion for clean, elegant solutions."
  />
  <link rel="alternate" hreflang="en" href="https://amrthabit.com/" />
  <link rel="alternate" hreflang="ar" href="https://amrthabit.com/ar" />
  <meta property="og:title" content="Amr Thabit" />
  <meta property="og:description" content="Software developer based in Ontario, Canada with a passion for clean, elegant solutions." />
  <meta property="og:type" content="profile" />
  <meta property="og:url" content="https://amrthabit.com/" />
  <meta property="og:locale" content="en_CA" />
  {@html `<script type="application/ld+json">${personSchema}<\/script>`}
</svelte:head>

<div class="chrome">
  <header class="site-head">
    <a class="wordmark" href="/">
      <span class="wm">W<small>IKIPEDI</small>A</span>
      <span class="tagline">The Free Encyclopedia</span>
    </a>
    <form
      class="search"
      action="https://en.wikipedia.org/wiki/Special:Search"
      method="get"
      target="_blank"
      rel="noopener noreferrer"
    >
      <input type="search" name="search" placeholder="Search Wikipedia" aria-label="Search Wikipedia" />
      <button type="submit">Search</button>
    </form>
    <Appearance />
  </header>

  <article class="page">
    <div class="langbar"><a href="/ar" hreflang="ar" lang="ar">العربية</a></div>
    <h1>Amr Thabit</h1>
    <div class="site-sub">From Wikipedia, the free encyclopedia</div>

    <div class="hatnote">
      For the domain, you are already here. Not to be confused with other people named Amr
      Thabit, who are welcome to build their own encyclopedias.
    </div>

    <aside class="infobox">
      <div class="ib-title">Amr Thabit</div>
      <table>
        <tbody>
          <tr>
            <th>Born</th>
            <td>August 2001 (age {age})<br /><a href="https://en.wikipedia.org/wiki/Yemen" target="_blank" rel="noopener noreferrer">Yemen</a></td>
          </tr>
          <tr>
            <th>Residence</th>
            <td><a href="https://en.wikipedia.org/wiki/Hamilton,_Ontario" target="_blank" rel="noopener noreferrer">Hamilton, Ontario</a>, Canada</td>
          </tr>
          <tr>
            <th>Education</th>
            <td><a href="https://en.wikipedia.org/wiki/Glendale_Secondary_School" target="_blank" rel="noopener noreferrer">Glendale Secondary School</a> (2019)</td>
          </tr>
          <tr><th>Alma mater</th><td><a href="https://en.wikipedia.org/wiki/McMaster_University" target="_blank" rel="noopener noreferrer">McMaster University</a> (BS, CS, 2025)</td></tr>
          <tr><th>Occupation</th><td>Broadcast systems engineer</td></tr>
          <tr><th>Employer</th><td>Evertz Microsystems</td></tr>
          <tr><th>Title</th><td>Project Engineer II</td></tr>
          <tr>
            <th>Known for</th>
            <td>Collaborating, learning, building</td>
          </tr>
          <tr>
            <th>Website</th>
            <td><a href="/">amrthabit.com</a></td>
          </tr>
        </tbody>
      </table>
    </aside>

    <p class="lead">
      <b>Amr Thabit</b> is a Canadian <a href="https://en.wikipedia.org/wiki/Software_developer" target="_blank" rel="noopener noreferrer">software developer</a>
      and <a href="https://en.wikipedia.org/wiki/Broadcast_engineering" target="_blank" rel="noopener noreferrer">broadcast systems engineer</a>
      known for a passion for clean, elegant solutions<sup class="cn">[citation needed]</sup>. He studied
      computer science at <a href="https://en.wikipedia.org/wiki/McMaster_University" target="_blank" rel="noopener noreferrer">McMaster University</a>
      and serves as a Project Engineer II at
      <a href="https://en.wikipedia.org/wiki/Evertz_Microsystems" target="_blank" rel="noopener noreferrer">Evertz Microsystems</a>.<sup><a href="#ref1">[1]</a></sup>
    </p>
    <p>
      Thabit maintains an active presence on <a href="https://github.com/amrthabit" target="_blank" rel="noopener noreferrer">GitHub</a><sup><a href="#ref2">[2]</a></sup>
      and <a href="https://linkedin.com/in/AmrThabit" target="_blank" rel="noopener noreferrer">LinkedIn</a>,<sup><a href="#ref1">[1]</a></sup>
      and can be reached by <a href="mailto:contact@amrthabit.com">electronic mail</a>.
    </p>

    <nav class="toc" aria-label="Contents">
      <div class="toc-h">Contents</div>
      <ol>
        <li><a href="#education">Early life and education</a></li>
        <li><a href="#career">Career</a></li>
        <li><a href="#works">Selected works</a></li>
        <li><a href="#selfhosting">Self-hosting</a></li>
        <li><a href="#external">External links</a></li>
        <li><a href="#references">References</a></li>
      </ol>
    </nav>

    <h2 id="education">
      Early life and education
      <span class="edit">[<a href="mailto:contact@amrthabit.com?subject=Edit%20request%3A%20Amr%20Thabit">edit</a>]</span>
    </h2>
    <p>
      Thabit was born in <a href="https://en.wikipedia.org/wiki/Yemen" target="_blank" rel="noopener noreferrer">Yemen</a>
      in August 2001 and was raised in
      <a href="https://en.wikipedia.org/wiki/Riyadh" target="_blank" rel="noopener noreferrer">Riyadh</a>,
      <a href="https://en.wikipedia.org/wiki/Saudi_Arabia" target="_blank" rel="noopener noreferrer">Saudi Arabia</a>.
      He later moved to <a href="https://en.wikipedia.org/wiki/Hamilton,_Ontario" target="_blank" rel="noopener noreferrer">Hamilton, Ontario</a>,
      where he completed high school at
      <a href="https://en.wikipedia.org/wiki/Glendale_Secondary_School" target="_blank" rel="noopener noreferrer">Glendale Secondary School</a>
      in the city's east end in 2019.
    </p>
    <p>
      He studied computer science at McMaster University from 2020 to 2025, graduating with a
      grade point average of 3.82 and a place on the Dean's Honours List.<sup><a href="#ref1">[1]</a></sup>
      It was there, records suggest, that he first developed the habit of collaborating, learning,
      and building, in roughly that order.<sup class="cn">[citation needed]</sup> His capstone project,
      Abdomaid, attempted to detect abdominal injuries from medical imaging using machine
      learning; Thabit built its front and back ends, and the team notes that the model's 65
      percent accuracy was, at minimum, better than guessing.<sup class="cn">[citation needed]</sup>
    </p>

    <h2 id="career">
      Career
      <span class="edit">[<a href="mailto:contact@amrthabit.com?subject=Edit%20request%3A%20Amr%20Thabit">edit</a>]</span>
    </h2>
    <p>
      Thabit joined Evertz Microsystems, a broadcast equipment manufacturer headquartered in
      <a href="https://en.wikipedia.org/wiki/Burlington,_Ontario" target="_blank" rel="noopener noreferrer">Burlington, Ontario</a>,
      as a project engineering co-op in January 2024. He spent the co-op deploying
      <a href="https://en.wikipedia.org/wiki/Playout" target="_blank" rel="noopener noreferrer">playout</a>
      servers across a multi-site hub-and-spoke broadcast network, rolling out platform and
      firmware upgrades to more than thirty stations, mentoring two fellow co-ops, and writing
      over a dozen technical runbooks along the way. At his first review he was promoted to
      Project Engineer II, on his lead's recommendation.<sup><a href="#ref1">[1]</a></sup>
    </p>
    <p>
      As of 2026, he deploys and maintains broadcast playout and
      <a href="https://en.wikipedia.org/wiki/Digital_asset_management" target="_blank" rel="noopener noreferrer">media asset management</a>
      systems for major American broadcasters and affiliate networks. He owns the production
      content pipelines, from schedule translation through media ingest to metadata
      synchronization, and builds the tooling around them: automated recovery scripts, health
      checks, configuration audits, and self-service dashboards that let operations teams answer
      their own questions.<sup><a href="#ref1">[1]</a></sup>
    </p>
    <p>
      The work has him troubleshooting across the whole stack, from
      <a href="https://en.wikipedia.org/wiki/Linux" target="_blank" rel="noopener noreferrer">Linux</a>
      servers to container orchestration, guided by a principle he considers self-evident: any
      problem he cannot fix must be coming from upstream.<sup class="cn">[citation needed]</sup>
      He is conversant in video over IP and
      <a href="https://en.wikipedia.org/wiki/SMPTE_2110" target="_blank" rel="noopener noreferrer">SMPTE ST 2110</a>,
      especially ST 2110-40, the part that carries the
      <a href="https://en.wikipedia.org/wiki/Ancillary_data" target="_blank" rel="noopener noreferrer">ancillary data</a>:
      the captions, the ad triggers, the timecode, and most of the interesting problems.
    </p>
    <p>
      Before broadcasting, Thabit operated machinery at a bakery in
      <a href="https://en.wikipedia.org/wiki/Ancaster,_Ontario" target="_blank" rel="noopener noreferrer">Ancaster</a>
      that produced <a href="https://en.wikipedia.org/wiki/Tim_Hortons" target="_blank" rel="noopener noreferrer">Tim Hortons</a>
      bagels and muffins, some of which were consumed fresh off the line as a form of quality
      assurance,<sup class="cn">[citation needed]</sup> and worked in an adidas warehouse in
      <a href="https://en.wikipedia.org/wiki/Paris,_Ontario" target="_blank" rel="noopener noreferrer">Paris, Ontario</a>,
      shipping <a href="https://en.wikipedia.org/wiki/Adidas_Yeezy" target="_blank" rel="noopener noreferrer">Yeezys</a>
      to people who wanted them very badly. The closest either role came to a media pipeline was
      the radio, which, to his lasting frustration, could not be remuxed, re-encoded, or piped
      through
      <a href="https://en.wikipedia.org/wiki/FFmpeg" target="_blank" rel="noopener noreferrer">FFmpeg</a>.<sup class="cn">[citation needed]</sup>
    </p>
    <table class="wikitable">
      <thead>
        <tr><th>Years</th><th>Position</th><th>Organization</th></tr>
      </thead>
      <tbody>
        <tr><td>2025&ndash;present</td><td>Project Engineer II</td><td>Evertz Microsystems</td></tr>
        <tr><td>2024&ndash;2025</td><td>Project engineering co-op</td><td>Evertz Microsystems</td></tr>
        <tr><td>2020&ndash;2022</td><td>Machine operator</td><td>Aspire Bakeries, Ancaster</td></tr>
        <tr><td>2020</td><td>Warehouse associate</td><td>adidas, Paris, Ontario</td></tr>
      </tbody>
    </table>

    <h2 id="works">
      Selected works
      <span class="edit">[<a href="mailto:contact@amrthabit.com?subject=Edit%20request%3A%20Amr%20Thabit">edit</a>]</span>
    </h2>
    <p>
      Thabit maintains a collection of browser games, several of them multiplayer, alongside
      websites. The multiplayer games are served from his own hardware
      (see <a href="#selfhosting">&sect; Self-hosting</a>).
    </p>
    <table class="wikitable">
      <thead>
        <tr><th>Work</th><th>Type</th><th>Notes</th></tr>
      </thead>
      <tbody>
        <tr>
          <td>amrthabit.com</td>
          <td>Personal website (Svelte)</td>
          <td>The page you are reading</td>
        </tr>
        <tr>
          <td><a href="https://ketype.com" target="_blank" rel="noopener noreferrer">ketype.com</a></td>
          <td>Typing game</td>
          <td>Type fast, feel good</td>
        </tr>
        <tr>
          <td><a href="https://wordle.amr.ooo" target="_blank" rel="noopener noreferrer">wordle.amr.ooo</a></td>
          <td>Multiplayer word game</td>
          <td>Wordle, but you can lose to your friends</td>
        </tr>
        <tr>
          <td><a href="https://snake.amr.ooo" target="_blank" rel="noopener noreferrer">snake.amr.ooo</a></td>
          <td>Multiplayer arcade game</td>
          <td>Snake, where the obstacle is other people</td>
        </tr>
        <tr>
          <td><a href="https://outlier.amr.ooo" target="_blank" rel="noopener noreferrer">outlier.amr.ooo</a></td>
          <td>Multiplayer party game</td>
          <td>Find the odd one out</td>
        </tr>
        <tr>
          <td><a href="https://tetris.amr.ooo" target="_blank" rel="noopener noreferrer">tetris.amr.ooo</a></td>
          <td>Multiplayer puzzle game</td>
          <td>In testing</td>
        </tr>
        <tr>
          <td><a href="https://brockmsa.ca" target="_blank" rel="noopener noreferrer">brockmsa.ca</a></td>
          <td>Community website</td>
          <td>Built for the Brock Muslim Students' Association</td>
        </tr>
      </tbody>
    </table>

    <h2 id="selfhosting">
      Self-hosting
      <span class="edit">[<a href="mailto:contact@amrthabit.com?subject=Edit%20request%3A%20Amr%20Thabit">edit</a>]</span>
    </h2>
    <p>
      Thabit is a
      <a href="https://en.wikipedia.org/wiki/Self-hosting_(web_services)" target="_blank" rel="noopener noreferrer">self-hosting</a>
      enthusiast, and runs nearly everything he builds on his own hardware, an arrangement he
      regards as a feature rather than a hobby.<sup class="cn">[citation needed]</sup> His
      multiplayer games are served from a low-power server in his home running
      <a href="https://en.wikipedia.org/wiki/DietPi" target="_blank" rel="noopener noreferrer">DietPi</a>
      and the <a href="https://en.wikipedia.org/wiki/Caddy_(web_server)" target="_blank" rel="noopener noreferrer">Caddy</a>
      web server, with each game backed by its own
      <a href="https://en.wikipedia.org/wiki/WebSocket" target="_blank" rel="noopener noreferrer">WebSocket</a> service.<sup><a href="#ref3">[3]</a></sup>
    </p>
    <p>
      The same network includes a storage server with a mirrored 3.6-terabyte array holding media
      and backups, a self-hosted Git server,
      <a href="https://en.wikipedia.org/wiki/Nextcloud" target="_blank" rel="noopener noreferrer">Nextcloud</a>, and both
      <a href="https://en.wikipedia.org/wiki/Plex" target="_blank" rel="noopener noreferrer">Plex</a> and
      <a href="https://en.wikipedia.org/wiki/Jellyfin" target="_blank" rel="noopener noreferrer">Jellyfin</a>,
      which serve the same 26 movies.<sup><a href="#ref3">[3]</a></sup> Monitoring is handled by
      <a href="https://en.wikipedia.org/wiki/Prometheus_(software)" target="_blank" rel="noopener noreferrer">Prometheus</a>.
      Thabit maintains that the entire setup is simpler than it sounds.<sup class="cn">[citation needed]</sup>
    </p>
    <p>
      Everything listed on this page is supposed to be up. A page that fails to load is a genuine
      incident: readers are encouraged to
      <a href="mailto:contact@amrthabit.com?subject=Something%20is%20down">report it</a>, becoming,
      in that moment, part of the monitoring stack.<sup class="cn">[citation needed]</sup>
    </p>

    <h2 id="external">
      External links
      <span class="edit">[<a href="mailto:contact@amrthabit.com?subject=Edit%20request%3A%20Amr%20Thabit">edit</a>]</span>
    </h2>
    <ul class="external">
      <li><a href="mailto:contact@amrthabit.com">Official correspondence</a> (electronic mail)</li>
      <li><a href="https://github.com/amrthabit" target="_blank" rel="noopener noreferrer">Amr Thabit</a> on GitHub</li>
      <li><a href="https://linkedin.com/in/AmrThabit" target="_blank" rel="noopener noreferrer">Amr Thabit</a> on LinkedIn</li>
      <li><a href="https://instagram.com/thbbit" target="_blank" rel="noopener noreferrer">@thbbit</a> on Instagram</li>
    </ul>

    <h2 id="references">
      References
      <span class="edit">[<a href="mailto:contact@amrthabit.com?subject=Edit%20request%3A%20Amr%20Thabit">edit</a>]</span>
    </h2>
    <ol class="refs">
      <li id="ref1">
        <span class="up">^</span> "Amr Thabit, Project Engineer II".
        <a href="https://linkedin.com/in/AmrThabit" target="_blank" rel="noopener noreferrer"><i>LinkedIn</i></a>. Retrieved 3 July 2026.
      </li>
      <li id="ref2">
        <span class="up">^</span> "amrthabit (Amr Thabit)".
        <a href="https://github.com/amrthabit" target="_blank" rel="noopener noreferrer"><i>GitHub</i></a>. Retrieved 3 July 2026.
      </li>
      <li id="ref3">
        <span class="up">^</span> Thabit, A. (2026). <i>Homelab journal</i>. Self-published; self-hosted, naturally.
      </li>
    </ol>

    <div class="stub">
      <span class="stub-icon" aria-hidden="true">&#9998;</span>
      This article about a software developer is a <a href="https://en.wikipedia.org/wiki/Wikipedia:Stub" target="_blank" rel="noopener noreferrer">stub</a>.
      You can help by <a href="mailto:contact@amrthabit.com">reaching out</a>.
    </div>

    <div class="catlinks">
      <b>Categories:</b>
      <a href="https://en.wikipedia.org/wiki/Category:2001_births" target="_blank" rel="noopener noreferrer">2001 births</a>
      <span>|</span>
      <a href="https://en.wikipedia.org/wiki/Category:Living_people" target="_blank" rel="noopener noreferrer">Living people</a>
      <span>|</span>
      <a href="https://en.wikipedia.org/wiki/Category:People_from_Hamilton,_Ontario" target="_blank" rel="noopener noreferrer">People from Hamilton, Ontario</a>
      <span>|</span>
      <a href="https://en.wikipedia.org/wiki/Category:McMaster_University_alumni" target="_blank" rel="noopener noreferrer">McMaster University alumni</a>
      <span>|</span>
      <a href="https://en.wikipedia.org/wiki/Category:Canadian_computer_programmers" target="_blank" rel="noopener noreferrer">Canadian computer programmers</a>
    </div>

    <footer class="page-foot">
      <p>This page was last edited on 3 July 2026, by its subject, which explains a lot.</p>
      <p>
        This site is a loving parody of a Wikipedia article. It is not affiliated with, or
        endorsed by, Wikipedia or the Wikimedia Foundation, whose citations are more rigorous.
      </p>
      <p>
        <a href="mailto:contact@amrthabit.com">Contact</a> &middot;
        <a href="https://github.com/amrthabit" target="_blank" rel="noopener noreferrer">GitHub</a> &middot;
        <a href="https://linkedin.com/in/AmrThabit" target="_blank" rel="noopener noreferrer">LinkedIn</a> &middot;
        <a href="https://instagram.com/thbbit" target="_blank" rel="noopener noreferrer">Instagram</a>
      </p>
    </footer>
  </article>
</div>

<style>
  /* Only per-language rules live here; the shared article skin is in styles.scss */
  .wordmark {
    line-height: 1.15;
  }
  .wm {
    display: block;
    font-family: 'Linux Libertine', Georgia, 'Times New Roman', serif;
    font-size: 24px;
    letter-spacing: 0.02em;
  }
  .wm small {
    font-size: 19px;
  }
  .tagline {
    display: block;
    font-family: Georgia, serif;
    font-size: 10.5px;
    letter-spacing: 0.08em;
    color: var(--mut);
  }
</style>
