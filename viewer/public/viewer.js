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

  // Swift / Kotlin code toggle helper.
  // Looks for adjacent Swift and Kotlin code blocks and wraps them in a small toggle UI.
  try {
    const swiftCodeBlocks = document.querySelectorAll('pre > code.language-swift');

    swiftCodeBlocks.forEach((codeEl) => {
      const preSwift = codeEl.parentElement;
      if (!preSwift || preSwift.dataset.codeToggleGroupInitialized === 'true') {
        return;
      }

      const next = preSwift.nextElementSibling;
      if (!next || !next.matches('pre')) return;

      const kotlinCode = next.querySelector('code.language-kotlin');
      if (!kotlinCode) return;

      const preKotlin = next;

      // Mark so we don't process the same pair twice.
      preSwift.dataset.codeToggleGroupInitialized = 'true';
      preKotlin.dataset.codeToggleGroupInitialized = 'true';

      const wrapper = document.createElement('div');
      wrapper.className =
        'mb-4 rounded-lg border border-base-300/70 overflow-hidden bg-base-100';

      const header = document.createElement('div');
      header.className =
        'flex items-center justify-end gap-x-2 border-b border-base-300/60 bg-base-100/95 px-3 py-1.5 text-xs text-base-content/80';
      header.setAttribute('role', 'tablist');
      header.setAttribute('aria-label', 'Language toggle');

      const btnSwift = document.createElement('button');
      btnSwift.type = 'button';
      btnSwift.textContent = 'Swift';
      btnSwift.className =
        'px-2 py-0.5 rounded-md border border-base-300/70 bg-primary text-primary-content text-[11px] font-semibold tracking-[0.18em] uppercase';
      btnSwift.setAttribute('data-lang', 'swift');
      btnSwift.setAttribute('role', 'tab');
      btnSwift.setAttribute('aria-selected', 'true');

      const btnKotlin = document.createElement('button');
      btnKotlin.type = 'button';
      btnKotlin.textContent = 'Kotlin';
      btnKotlin.className =
        'px-2 py-0.5 rounded-md border border-base-300/40 bg-base-100 text-base-content/70 text-[11px] font-semibold tracking-[0.18em] uppercase';
      btnKotlin.setAttribute('data-lang', 'kotlin');
      btnKotlin.setAttribute('role', 'tab');
      btnKotlin.setAttribute('aria-selected', 'false');

      header.appendChild(btnSwift);
      header.appendChild(btnKotlin);

      const body = document.createElement('div');
      body.className = 'bg-base-100';

      preSwift.dataset.language = 'swift';
      preKotlin.dataset.language = 'kotlin';

      preKotlin.style.display = 'none';

      body.appendChild(preSwift);
      body.appendChild(preKotlin);

      const parent = preSwift.parentNode;
      if (!parent) return;

      parent.insertBefore(wrapper, preSwift);
      wrapper.appendChild(header);
      wrapper.appendChild(body);

      function setActive(lang) {
        const showSwift = lang === 'swift';
        preSwift.style.display = showSwift ? '' : 'none';
        preKotlin.style.display = showSwift ? 'none' : '';

        if (showSwift) {
          btnSwift.className =
            'px-2 py-0.5 rounded-md border border-base-300/70 bg-primary text-primary-content text-[11px] font-semibold tracking-[0.18em] uppercase';
          btnSwift.setAttribute('aria-selected', 'true');
          btnKotlin.className =
            'px-2 py-0.5 rounded-md border border-base-300/40 bg-base-100 text-base-content/70 text-[11px] font-semibold tracking-[0.18em] uppercase';
          btnKotlin.setAttribute('aria-selected', 'false');
        } else {
          btnKotlin.className =
            'px-2 py-0.5 rounded-md border border-base-300/70 bg-primary text-primary-content text-[11px] font-semibold tracking-[0.18em] uppercase';
          btnKotlin.setAttribute('aria-selected', 'true');
          btnSwift.className =
            'px-2 py-0.5 rounded-md border border-base-300/40 bg-base-100 text-base-content/70 text-[11px] font-semibold tracking-[0.18em] uppercase';
          btnSwift.setAttribute('aria-selected', 'false');
        }
      }

      btnSwift.addEventListener('click', () => setActive('swift'));
      btnKotlin.addEventListener('click', () => setActive('kotlin'));
    });
  } catch (err) {
    // ignore code-toggle errors
  }
});
