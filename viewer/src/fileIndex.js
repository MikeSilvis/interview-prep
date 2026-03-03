const fs = require('fs');
const path = require('path');

const IGNORE_DIRS = new Set(['node_modules', '.git', '.cursor', 'mcps', 'viewer']);

function toDisplayName(fileName) {
  if (!fileName) return '';
  const base = String(fileName).replace(/\.(md|pdf)$/i, '');
  const parts = base.split(/[-_]+/).filter(Boolean);
  if (!parts.length) return base;
  return parts
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join(' ');
}

function buildFileIndex(rootDir) {
  const filesBySlug = {};
  const rootNode = { name: '', path: '', type: 'dir', children: [] };

  function ensureDirNode(segments) {
    let node = rootNode;
    for (const segment of segments) {
      if (!segment) continue;
      let child = node.children.find(
        (c) => c.type === 'dir' && c.name === segment,
      );
      if (!child) {
        child = {
          name: segment,
          path: (node.path ? `${node.path}/` : '') + segment,
          type: 'dir',
          children: [],
        };
        node.children.push(child);
      }
      node = child;
    }
    return node;
  }

  function walk(dir) {
    let entries;
    try {
      entries = fs.readdirSync(dir, { withFileTypes: true });
    } catch (err) {
      // Ignore unreadable directories
      return;
    }

    for (const entry of entries) {
      const entryName = entry.name;
      if (IGNORE_DIRS.has(entryName)) continue;
      if (entry.isDirectory() && entryName.startsWith('.')) continue;

      const fullPath = path.join(dir, entryName);

      if (entry.isDirectory()) {
        walk(fullPath);
        continue;
      }

      if (!entry.isFile()) continue;

      const lowerName = entryName.toLowerCase();
      const isMarkdown = lowerName.endsWith('.md');
      const isPdf = lowerName.endsWith('.pdf');

      if (!isMarkdown && !isPdf) continue;

      const relPath = path
        .relative(rootDir, fullPath)
        .split(path.sep)
        .join('/');
      const slug = relPath.replace(/\.(md|pdf)$/i, '');

      const parts = relPath.split('/');
      const fileName = parts.pop();
      const dirSegments = parts;
      const parentNode = ensureDirNode(dirSegments);

      let stat;
      try {
        stat = fs.statSync(fullPath);
      } catch (err) {
        continue;
      }

      const displayName = toDisplayName(fileName);

      // If we already have a markdown file for this slug, prefer that over a PDF.
      if (filesBySlug[slug] && filesBySlug[slug].fileType === 'markdown') {
        continue;
      }

      const fileNode = {
        name: displayName,
        path: relPath,
        slug,
        type: 'file',
        mtimeMs: stat.mtimeMs,
      };

      parentNode.children.push(fileNode);

      filesBySlug[slug] = {
        slug,
        name: displayName,
        relativePath: relPath,
        absolutePath: fullPath,
        mtimeMs: stat.mtimeMs,
        fileType: isMarkdown ? 'markdown' : 'pdf',
      };
    }
  }

  walk(rootDir);

  function sortTree(node) {
    if (!node.children) return;
    node.children.sort((a, b) => {
      if (a.type !== b.type) {
        return a.type === 'dir' ? -1 : 1;
      }
      return a.name.localeCompare(b.name, undefined, { sensitivity: 'base' });
    });
    node.children.forEach(sortTree);
  }

  sortTree(rootNode);

  return { tree: rootNode, filesBySlug };
}

module.exports = {
  buildFileIndex,
};

