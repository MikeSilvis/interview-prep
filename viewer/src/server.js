<<<<<<< HEAD
const path = require('path');
const fs = require('fs');
const express = require('express');
const MarkdownIt = require('markdown-it');
const hljs = require('highlight.js');
const { buildFileIndex } = require('./fileIndex');
const { renderSidebar } = require('./sidebar');

const app = express();
const port = process.env.PORT || 3000;

const defaultContentRoot = path.resolve(__dirname, '..', '..');
const contentRoot = process.env.CONTENT_ROOT
  ? path.resolve(process.env.CONTENT_ROOT)
  : defaultContentRoot;

const { tree, filesBySlug } = buildFileIndex(contentRoot);

let layoutTemplate = '';
let notFoundTemplate = '';
let errorTemplate = '';
let pdfViewerTemplate = '';
let pdfApiTemplate = '';
let searchResultItemTemplate = '';

function applyTemplate(template, data) {
  if (!template || !data) return template;
  return Object.keys(data).reduce((result, key) => {
    const value = data[key] == null ? '' : String(data[key]);
    const pattern = new RegExp(`{{\\s*${key}\\s*}}`, 'g');
    return result.replace(pattern, value);
  }, template);
}

try {
  const templatesDir = path.join(__dirname, 'templates');
  layoutTemplate = fs.readFileSync(
    path.join(templatesDir, 'layout.html'),
    'utf8',
  );
  notFoundTemplate = fs.readFileSync(
    path.join(templatesDir, 'not-found.html'),
    'utf8',
  );
  errorTemplate = fs.readFileSync(
    path.join(templatesDir, 'error.html'),
    'utf8',
  );
  pdfViewerTemplate = fs.readFileSync(
    path.join(templatesDir, 'pdf-viewer.html'),
    'utf8',
  );
  pdfApiTemplate = fs.readFileSync(
    path.join(templatesDir, 'pdf-api.html'),
    'utf8',
  );
  searchResultItemTemplate = fs.readFileSync(
    path.join(templatesDir, 'search-result-item.html'),
    'utf8',
  );
} catch (err) {
  // eslint-disable-next-line no-console
  console.error('Failed to load templates:', err);
  layoutTemplate = '';
  notFoundTemplate = '';
  errorTemplate = '';
  pdfViewerTemplate = '';
  pdfApiTemplate = '';
  searchResultItemTemplate = '';
}

const md = new MarkdownIt({
  html: false,
  linkify: true,
  typographer: true,
  highlight(str, lang) {
    if (lang && hljs.getLanguage(lang)) {
      try {
        const highlighted = hljs.highlight(str, {
          language: lang,
          ignoreIllegals: true,
        }).value;
        return `<pre><code class="hljs language-${lang}">${highlighted}</code></pre>`;
      } catch (err) {
        // fall through
      }
    }
    const escaped = md.utils.escapeHtml(str);
    return `<pre><code class="hljs">${escaped}</code></pre>`;
  },
});

function renderLayout(pageTitle, contentHtml, slugForSidebar) {
  const sidebarHtml = renderSidebar(tree, filesBySlug, slugForSidebar);
  return applyTemplate(layoutTemplate, {
    title: pageTitle,
    pageTitle,
    sidebar: sidebarHtml,
    content: contentHtml,
  });
}

function renderSearchResults(query) {
  if (!searchResultItemTemplate || !query) return '';

  const q = String(query).trim().toLowerCase();
  if (!q) return '';

  const allFiles = Object.values(filesBySlug || {});

  const matches = allFiles
    .filter((meta) => {
      if (!meta || !meta.slug) return false;
      const name = (meta.name || meta.slug || '').toLowerCase();
      const relPath = (meta.relativePath || '').toLowerCase();
      return name.includes(q) || relPath.includes(q);
    })
    .slice(0, 12);

  if (!matches.length) return '';

  const itemsHtml = matches
    .map((meta) => {
      const slug = meta.slug || '';
      if (!slug) return '';

      const label = meta.name || meta.slug || '';
      const title = meta.relativePath || meta.slug || '';

      return applyTemplate(searchResultItemTemplate, {
        slug: md.utils.escapeHtml(encodeURI(slug)),
        title: md.utils.escapeHtml(title),
        label: md.utils.escapeHtml(label),
      });
    })
    .filter(Boolean)
    .join('');

  return itemsHtml;
}

function findDefaultSlug() {
  if (filesBySlug['README']) return 'README';
  const slugs = Object.keys(filesBySlug);
  return slugs.length ? slugs[0] : null;
}

function renderPage(slug) {
  const meta = filesBySlug[slug];
  if (!meta) {
    const notFoundHtml = applyTemplate(notFoundTemplate, {
      slug: md.utils.escapeHtml(slug || ''),
    });
    const pageTitle = 'Not found';
    const html = renderLayout(pageTitle, notFoundHtml, slug);

    return { status: 404, html };
  }

  const fileType = meta.fileType || 'markdown';

  if (fileType === 'pdf') {
    const pageTitle = '';
    const pdfUrl = `/files/${meta.relativePath}`;

    const contentHtml = applyTemplate(pdfViewerTemplate, {
      pdfUrl,
    });

    const html = renderLayout(pageTitle, contentHtml, slug);

    return { status: 200, html };
  }

  let markdown = '';
  try {
    markdown = fs.readFileSync(meta.absolutePath, 'utf8');
  } catch (err) {
    const errorHtml = applyTemplate(errorTemplate, {
      path: md.utils.escapeHtml(meta.relativePath),
    });
    const pageTitle = 'Error';
    const html = renderLayout(pageTitle, errorHtml, slug);
    return { status: 500, html };
  }

  const contentHtml = md.render(markdown);
  const pageTitle = meta.name;

  const html = renderLayout(pageTitle, contentHtml, slug);

  return { status: 200, html };
}

app.use(express.static(path.join(__dirname, '..', 'public')));

// Expose the content root so non-markdown assets (like PDFs) can be served directly.
// Example: /files/content/msilvis/resources/resume.pdf
app.use(
  '/files',
  express.static(contentRoot, {
    fallthrough: true,
  }),
);

app.get('/health', (req, res) => {
  res.json({
    ok: true,
    contentRoot,
    fileCount: Object.keys(filesBySlug).length,
  });
});

app.get('/api/files', (req, res) => {
  res.json({
    tree,
    slugs: Object.keys(filesBySlug),
  });
});

app.get('/api/search', (req, res) => {
  const q = (req.query.q || '').toString();
  const html = renderSearchResults(q);
  res
    .status(200)
    .set('Content-Type', 'text/html; charset=utf-8')
    .send(html);
});

app.get('/api/file/*', (req, res) => {
  const slugParam = req.params[0] || '';
  const slug = slugParam || findDefaultSlug();
  if (!slug) {
    return res.status(404).json({ error: 'No markdown files found' });
  }

  const meta = filesBySlug[slug];
  if (!meta) {
    return res.status(404).json({ error: 'Not found', slug });
  }

  const fileType = meta.fileType || 'markdown';

  if (fileType === 'pdf') {
    const pdfUrl = `/files/${meta.relativePath}`;
    const html = applyTemplate(pdfApiTemplate, {
      pdfUrl,
    });

    return res.json({
      meta,
      markdown: '',
      html,
    });
  }

  let markdown = '';
  try {
    markdown = fs.readFileSync(meta.absolutePath, 'utf8');
  } catch (err) {
    return res.status(500).json({
      error: 'Failed to read file',
      slug,
      path: meta.relativePath,
    });
  }

  const html = md.render(markdown);

  res.json({
    meta,
    markdown,
    html,
  });
});

// Inline viewer for the main resume PDF with a download button.
app.get('/resume', (req, res) => {
  const pageTitle = '';
  const pdfRelativePath = 'content/msilvis/resources/resume.pdf';
  const pdfUrl = `/files/${pdfRelativePath}`;

  const contentHtml = applyTemplate(pdfViewerTemplate, {
    pdfUrl,
  });

  const html = renderLayout(pageTitle, contentHtml, null);

  res.status(200).send(html);
});

app.get('/', (req, res) => {
  const slug = findDefaultSlug();
  if (!slug) {
    return res.status(500).send('No markdown files found in the content root.');
  }

  const result = renderPage(slug);
  res.status(result.status).send(result.html);
});

app.get('/*', (req, res, next) => {
  const pathName = req.path.slice(1);
  if (pathName.startsWith('api/')) return next();
  if (pathName === '') return next();

  const slug = decodeURI(pathName);
  const result = renderPage(slug);
  res.status(result.status).send(result.html);
});

app.listen(port, () => {
  console.log(`Markdown viewer listening on http://localhost:${port}`);
  console.log(`Using content root: ${contentRoot}`);
});

||||||| parent of d51015a (update reuslts)
=======
const path = require('path');
const fs = require('fs');
const express = require('express');
const MarkdownIt = require('markdown-it');
const hljs = require('highlight.js');
const { buildFileIndex } = require('./fileIndex');
const { renderSidebar } = require('./sidebar');

const app = express();
const port = process.env.PORT || 3000;

const defaultContentRoot = path.resolve(__dirname, '..', '..');
const contentRoot = process.env.CONTENT_ROOT
  ? path.resolve(process.env.CONTENT_ROOT)
  : defaultContentRoot;

const { tree, filesBySlug } = buildFileIndex(contentRoot);

let layoutTemplate = '';
let notFoundTemplate = '';
let errorTemplate = '';
let pdfViewerTemplate = '';
let pdfApiTemplate = '';
let searchResultItemTemplate = '';
let codeToggleTemplate = '';

function applyTemplate(template, data) {
  if (!template || !data) return template;
  return Object.keys(data).reduce((result, key) => {
    const value = data[key] == null ? '' : String(data[key]);
    const pattern = new RegExp(`{{\\s*${key}\\s*}}`, 'g');
    return result.replace(pattern, value);
  }, template);
}

try {
  const templatesDir = path.join(__dirname, 'templates');
  layoutTemplate = fs.readFileSync(
    path.join(templatesDir, 'layout.html'),
    'utf8',
  );
  notFoundTemplate = fs.readFileSync(
    path.join(templatesDir, 'not-found.html'),
    'utf8',
  );
  errorTemplate = fs.readFileSync(
    path.join(templatesDir, 'error.html'),
    'utf8',
  );
  pdfViewerTemplate = fs.readFileSync(
    path.join(templatesDir, 'pdf-viewer.html'),
    'utf8',
  );
  pdfApiTemplate = fs.readFileSync(
    path.join(templatesDir, 'pdf-api.html'),
    'utf8',
  );
  searchResultItemTemplate = fs.readFileSync(
    path.join(templatesDir, 'search-result-item.html'),
    'utf8',
  );
  codeToggleTemplate = fs.readFileSync(
    path.join(templatesDir, 'code-toggle.html'),
    'utf8',
  );
} catch (err) {
  // eslint-disable-next-line no-console
  console.error('Failed to load templates:', err);
  layoutTemplate = '';
  notFoundTemplate = '';
  errorTemplate = '';
  pdfViewerTemplate = '';
  pdfApiTemplate = '';
  searchResultItemTemplate = '';
  codeToggleTemplate = '';
}

const md = new MarkdownIt({
  html: false,
  linkify: true,
  typographer: true,
  highlight(str, lang) {
    if (lang && hljs.getLanguage(lang)) {
      try {
        const highlighted = hljs.highlight(str, {
          language: lang,
          ignoreIllegals: true,
        }).value;
        return `<pre><code class="hljs language-${lang}">${highlighted}</code></pre>`;
      } catch (err) {
        // fall through
      }
    }
    const escaped = md.utils.escapeHtml(str);
    return `<pre><code class="hljs">${escaped}</code></pre>`;
  },
});

function applyCodeToggles(html) {
  if (!codeToggleTemplate || !html) return html;

  const pattern =
    /<pre><code class="hljs language-swift">([\s\S]*?)<\/code><\/pre>\s*<pre><code class="hljs language-kotlin">([\s\S]*?)<\/code><\/pre>/g;

  return html.replace(
    pattern,
    (match, swiftInner, kotlinInner) =>
      applyTemplate(codeToggleTemplate, {
        swiftBlock: `<pre><code class="hljs language-swift">${swiftInner}</code></pre>`,
        kotlinBlock: `<pre><code class="hljs language-kotlin">${kotlinInner}</code></pre>`,
      }) || match,
  );
}

function renderMarkdownWithEnhancements(markdown) {
  const baseHtml = md.render(markdown || '');
  return applyCodeToggles(baseHtml);
}

function renderLayout(pageTitle, contentHtml, slugForSidebar) {
  const sidebarHtml = renderSidebar(tree, filesBySlug, slugForSidebar);
  return applyTemplate(layoutTemplate, {
    title: pageTitle,
    pageTitle,
    sidebar: sidebarHtml,
    content: contentHtml,
  });
}

function renderSearchResults(query) {
  if (!searchResultItemTemplate || !query) return '';

  const q = String(query).trim().toLowerCase();
  if (!q) return '';

  const allFiles = Object.values(filesBySlug || {});

  const matches = allFiles
    .filter((meta) => {
      if (!meta || !meta.slug) return false;
      const name = (meta.name || meta.slug || '').toLowerCase();
      const relPath = (meta.relativePath || '').toLowerCase();
      return name.includes(q) || relPath.includes(q);
    })
    .slice(0, 12);

  if (!matches.length) return '';

  const itemsHtml = matches
    .map((meta) => {
      const slug = meta.slug || '';
      if (!slug) return '';

      const label = meta.name || meta.slug || '';
      const title = meta.relativePath || meta.slug || '';

      return applyTemplate(searchResultItemTemplate, {
        slug: md.utils.escapeHtml(encodeURI(slug)),
        title: md.utils.escapeHtml(title),
        label: md.utils.escapeHtml(label),
      });
    })
    .filter(Boolean)
    .join('');

  return itemsHtml;
}

function findDefaultSlug() {
  if (filesBySlug['README']) return 'README';
  const slugs = Object.keys(filesBySlug);
  return slugs.length ? slugs[0] : null;
}

function renderPage(slug) {
  const meta = filesBySlug[slug];
  if (!meta) {
    const notFoundHtml = applyTemplate(notFoundTemplate, {
      slug: md.utils.escapeHtml(slug || ''),
    });
    const pageTitle = 'Not found';
    const html = renderLayout(pageTitle, notFoundHtml, slug);

    return { status: 404, html };
  }

  const fileType = meta.fileType || 'markdown';

  if (fileType === 'pdf') {
    const pageTitle = '';
    const pdfUrl = `/files/${meta.relativePath}`;

    const contentHtml = applyTemplate(pdfViewerTemplate, {
      pdfUrl,
    });

    const html = renderLayout(pageTitle, contentHtml, slug);

    return { status: 200, html };
  }

  let markdown = '';
  try {
    markdown = fs.readFileSync(meta.absolutePath, 'utf8');
  } catch (err) {
    const errorHtml = applyTemplate(errorTemplate, {
      path: md.utils.escapeHtml(meta.relativePath),
    });
    const pageTitle = 'Error';
    const html = renderLayout(pageTitle, errorHtml, slug);
    return { status: 500, html };
  }

  const contentHtml = renderMarkdownWithEnhancements(markdown);
  const pageTitle = meta.name;

  const html = renderLayout(pageTitle, contentHtml, slug);

  return { status: 200, html };
}

app.use(express.static(path.join(__dirname, '..', 'public')));

// Expose the content root so non-markdown assets (like PDFs) can be served directly.
// Example: /files/content/msilvis/resources/resume.pdf
app.use(
  '/files',
  express.static(contentRoot, {
    fallthrough: true,
  }),
);

app.get('/health', (req, res) => {
  res.json({
    ok: true,
    contentRoot,
    fileCount: Object.keys(filesBySlug).length,
  });
});

app.get('/api/files', (req, res) => {
  res.json({
    tree,
    slugs: Object.keys(filesBySlug),
  });
});

app.get('/api/search', (req, res) => {
  const q = (req.query.q || '').toString();
  const html = renderSearchResults(q);
  res
    .status(200)
    .set('Content-Type', 'text/html; charset=utf-8')
    .send(html);
});

app.get('/api/file/*', (req, res) => {
  const slugParam = req.params[0] || '';
  const slug = slugParam || findDefaultSlug();
  if (!slug) {
    return res.status(404).json({ error: 'No markdown files found' });
  }

  const meta = filesBySlug[slug];
  if (!meta) {
    return res.status(404).json({ error: 'Not found', slug });
  }

  const fileType = meta.fileType || 'markdown';

  if (fileType === 'pdf') {
    const pdfUrl = `/files/${meta.relativePath}`;
    const html = applyTemplate(pdfApiTemplate, {
      pdfUrl,
    });

    return res.json({
      meta,
      markdown: '',
      html,
    });
  }

  let markdown = '';
  try {
    markdown = fs.readFileSync(meta.absolutePath, 'utf8');
  } catch (err) {
    return res.status(500).json({
      error: 'Failed to read file',
      slug,
      path: meta.relativePath,
    });
  }

  const html = renderMarkdownWithEnhancements(markdown);

  res.json({
    meta,
    markdown,
    html,
  });
});

// Inline viewer for the main resume PDF with a download button.
app.get('/resume', (req, res) => {
  const pageTitle = '';
  const pdfRelativePath = 'content/msilvis/resources/resume.pdf';
  const pdfUrl = `/files/${pdfRelativePath}`;

  const contentHtml = applyTemplate(pdfViewerTemplate, {
    pdfUrl,
  });

  const html = renderLayout(pageTitle, contentHtml, null);

  res.status(200).send(html);
});

app.get('/', (req, res) => {
  const slug = findDefaultSlug();
  if (!slug) {
    return res.status(500).send('No markdown files found in the content root.');
  }

  const result = renderPage(slug);
  res.status(result.status).send(result.html);
});

app.get('/*', (req, res, next) => {
  const pathName = req.path.slice(1);
  if (pathName.startsWith('api/')) return next();
  if (pathName === '') return next();

  const slug = decodeURI(pathName);
  const result = renderPage(slug);
  res.status(result.status).send(result.html);
});

app.listen(port, () => {
  console.log(`Markdown viewer listening on http://localhost:${port}`);
  console.log(`Using content root: ${contentRoot}`);
});

>>>>>>> d51015a (update reuslts)
