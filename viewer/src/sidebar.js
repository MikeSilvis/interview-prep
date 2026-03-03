const fs = require('fs');
const path = require('path');

let sidebarTemplate = '';
let fileItemTemplate = '';
let folderItemTemplate = '';

// Simple string-based templating helper.
// Replaces {{key}} with the corresponding value from the data object.
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
  sidebarTemplate = fs.readFileSync(
    path.join(templatesDir, 'sidebar.html'),
    'utf8',
  );
  fileItemTemplate = fs.readFileSync(
    path.join(templatesDir, 'sidebar-file-item.html'),
    'utf8',
  );
  folderItemTemplate = fs.readFileSync(
    path.join(templatesDir, 'sidebar-folder-item.html'),
    'utf8',
  );
} catch (err) {
  // eslint-disable-next-line no-console
  console.error('Failed to load sidebar templates:', err);
  sidebarTemplate = '';
  fileItemTemplate = '';
  folderItemTemplate = '';
}

function renderSidebar(tree, filesBySlug, currentSlug) {
  function nodeContainsSlug(node, slug) {
    if (!node || !slug) return false;
    if (node.type === 'file') return node.slug === slug;
    if (!node.children) return false;
    return node.children.some((child) => nodeContainsSlug(child, slug));
  }

  function renderNode(n, depth) {
    if (n.type === 'file') {
      const isActive = n.slug === currentSlug;
      const href = `/${encodeURI(n.slug)}`;

      return applyTemplate(fileItemTemplate, {
        href,
        isActive: isActive ? 'true' : 'false',
        depth,
        label: n.name,
      });
    }

    // If this is the top-level `content` folder, don't render a
    // labeled container at all – just surface its children as the
    // effective roots of the sidebar.
    if (
      depth === 0 &&
      n.type === 'folder' &&
      typeof n.name === 'string' &&
      n.name.toLowerCase() === 'content'
    ) {
      if (!n.children || n.children.length === 0) return '';
      return n.children
        .map((child) => renderNode(child, depth))
        .filter(Boolean)
        .join('');
    }

    if (!n.children || n.children.length === 0) return '';

    const childrenHtml = n.children
      .map((child) => renderNode(child, depth + 1))
      .filter(Boolean)
      .join('');
    if (!childrenHtml) return '';

    // Never render a visible \"CONTENT\" row – just surface its children.
    if (n.name && n.name.toLowerCase() === 'content') {
      return childrenHtml;
    }

    const isOpen = nodeContainsSlug(n, currentSlug);
    const label =
      n.name && n.name.length
        ? n.name
        : 'Misc';

    return applyTemplate(folderItemTemplate, {
      openAttr: isOpen ? 'open' : '',
      depth,
      label,
      children: childrenHtml,
    });
  }

  // Prefer rooting the sidebar at the `content` folder so the UI
  // shows its sections (e.g. msilvis, prep) directly at the top level.
  let rootChildren = (tree && tree.children) || [];
  if (rootChildren && rootChildren.length) {
    const contentFolder = rootChildren.find(
      (n) =>
        n &&
        n.type === 'folder' &&
        typeof n.name === 'string' &&
        n.name.toLowerCase() === 'content',
    );
    if (contentFolder && Array.isArray(contentFolder.children)) {
      rootChildren = contentFolder.children;
    }
  }

  const inner =
    rootChildren && rootChildren.length
      ? rootChildren.map((child) => renderNode(child, 0)).filter(Boolean).join('')
      : '';

  return sidebarTemplate.replace(/{{items}}/g, inner);
}

module.exports = {
  renderSidebar,
};

