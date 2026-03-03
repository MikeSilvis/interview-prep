document.addEventListener('DOMContentLoaded', () => {
  try {
    const activeLink = document.querySelector('[data-sidebar-active="true"]');
    if (activeLink && activeLink.scrollIntoView) {
      activeLink.scrollIntoView({ block: 'nearest' });
    }
  } catch (err) {
    // ignore
  }

  // Lightweight page search to quickly jump between files
  try {
    const searchInput = document.getElementById('page-search');
    const resultsContainer = document.getElementById('page-search-results');

    if (searchInput && resultsContainer) {
      function hideResults() {
        resultsContainer.classList.add('hidden');
        resultsContainer.innerHTML = '';
      }

      function showResultsHtml(html) {
        if (!html) {
          hideResults();
          return;
        }

        resultsContainer.innerHTML = html;
        resultsContainer.classList.remove('hidden');
      }

      function performSearch(query) {
        const q = query.trim().toLowerCase();
        if (!q) {
          hideResults();
          return;
        }

        try {
          const url = `/api/search?q=${encodeURIComponent(q)}`;
          fetch(url)
            .then((res) => (res.ok ? res.text() : ''))
            .then((html) => {
              showResultsHtml(html || '');
            })
            .catch(() => {
              hideResults();
            });
        } catch (err) {
          hideResults();
        }
      }

      searchInput.addEventListener('input', () => {
        performSearch(searchInput.value || '');
      });

      searchInput.addEventListener('keydown', (event) => {
        if (event.key === 'Escape') {
          hideResults();
          searchInput.blur();
          return;
        }
        if (event.key === 'Enter') {
          const first = resultsContainer.querySelector('[data-search-slug]');
          if (first) {
            const slug = first.getAttribute('data-search-slug');
            if (slug) {
              window.location.href = '/' + slug;
            }
          }
        }
      });

      resultsContainer.addEventListener('mousedown', (event) => {
        const target = event.target.closest('[data-search-slug]');
        if (!target) return;
        const slug = target.getAttribute('data-search-slug');
        if (slug) {
          window.location.href = '/' + slug;
        }
      });

      document.addEventListener('click', (event) => {
        if (
          event.target !== searchInput &&
          !resultsContainer.contains(event.target)
        ) {
          hideResults();
        }
      });

      // Keyboard shortcut: Ctrl+K / Cmd+K to focus search
      document.addEventListener('keydown', (event) => {
        if ((event.metaKey || event.ctrlKey) && event.key.toLowerCase() === 'k') {
          event.preventDefault();
          searchInput.focus();
          searchInput.select();
        }
      });
    }
  } catch (err) {
    // ignore search errors
  }

  // Close the sidebar drawer when a sidebar item is clicked
  try {
    const drawerToggle = document.getElementById('docs-drawer');
    const sidebar = document.querySelector('.app-sidebar');

    if (drawerToggle && sidebar) {
      sidebar.addEventListener('click', (event) => {
        const link = event.target.closest('a[href]');
        if (!link) return;
        drawerToggle.checked = false;
      });
    }
  } catch (err) {
    // ignore drawer toggle errors
  }

  // Swift / Kotlin code toggle helper – behavior only, markup is server-rendered.
  try {
    const activeClasses =
      'px-2 py-0.5 rounded-md border border-base-300/70 bg-primary text-primary-content text-[11px] font-semibold tracking-[0.18em] uppercase';
    const inactiveClasses =
      'px-2 py-0.5 rounded-md border border-base-300/40 bg-base-100 text-base-content/70 text-[11px] font-semibold tracking-[0.18em] uppercase';

    document.addEventListener('click', (event) => {
      const btn = event.target.closest('[data-code-toggle-btn]');
      if (!btn) return;

      const wrapper = btn.closest('[data-code-toggle]');
      if (!wrapper) return;

      const targetLang = btn.getAttribute('data-lang');
      if (!targetLang) return;

      const buttons = wrapper.querySelectorAll('[data-code-toggle-btn]');
      const panels = wrapper.querySelectorAll('[data-code-panel]');

      buttons.forEach((button) => {
        const lang = button.getAttribute('data-lang');
        const isActive = lang === targetLang;
        button.className = isActive ? activeClasses : inactiveClasses;
        button.setAttribute('aria-selected', isActive ? 'true' : 'false');
      });

      panels.forEach((panel) => {
        const lang = panel.getAttribute('data-lang');
        const isActive = lang === targetLang;
        if (isActive) {
          panel.removeAttribute('hidden');
        } else {
          panel.setAttribute('hidden', 'true');
        }
      });
    });
  } catch (err) {
    // ignore code-toggle errors
  }
});
