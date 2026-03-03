## Interview Prep Workspace

This repo is organized to separate **shared study materials** from **per-user notes and AI skills**, so anyone can plug in their own profile without stepping on others.

### Layout

- **`content/prep/`** – Shared, general-purpose prep content
  - `study-guide/algorithms/` – Algorithm study notes and worked examples  
    - e.g. [arrays & strings](content/prep/study-guide/algorithms/examples/arrays-strings.md), [dynamic programming](content/prep/study-guide/algorithms/examples/dynamic-programming.md)
  - `study-guide/swift/` – Swift/iOS study guide  
    - e.g. [Swift fundamentals](content/prep/study-guide/swift/examples/swift-language-fundamentals.md)
  - `leet/` – Shared Swift LeetCode playground and README  
    - see [`content/prep/leet/README.md`](content/prep/leet/README.md)
  - `soft-skills/` – Question templates and interview rubrics (no user-specific answers)  
    - e.g. [getting-stuff-done-questions](content/prep/soft-skills/getting-stuff-done-questions.md)
- **`content/<username>/`** – Per-user content (notes, answers, resumes, etc.)
  - `content/msilvis/soft-skills/getting-stuff-done.md` – Mike’s example answers for the "getting stuff done" template
  - `content/msilvis/resources/square-history.md` – Long-form career/resource history used by the soft-skills skill
  - `content/msilvis/resources/resume.pdf` – Resume used in examples
- **`.cursor/skills/`** – AI skills that define how the agent behaves in this workspace
  - `msilvis-study-prep/` – Step-by-step study sessions (see `CLAUDE.md` for how to call `msilvis:study-prep`)
  - `msilvis-soft-skills/` – Soft-skills answer generator for this workspace (`msilvis:soft-skills`)
  - `msilvis-reset-questions/` – Reset `msilvis`’s study progress context (`msilvis:reset-questions`)

### What is “general knowledge” vs “user-specific”?

- **General knowledge** lives in `content/prep/`:
  - Question banks, rubrics, and templates (like [`content/prep/soft-skills/getting-stuff-done-questions.md`](content/prep/soft-skills/getting-stuff-done-questions.md))
  - Shared problem sets and reference solutions (like the Swift LeetCode playground under `content/prep/leet/`)
  - Language/framework study guides (like [`content/prep/study-guide/algorithms/README.md`](content/prep/study-guide/algorithms/README.md))
- **User-specific content** lives in `content/<your-name>/` and is optional:
  - Your own written answers to behavioral questions (e.g. `content/<your-name>/soft-skills/...`)
  - Personal resumes, career history, and private notes (e.g. `content/<your-name>/resources/...`)
  - Any custom material tailored to your background

### Adding your own profile

1. **Create your user folder**
   - Add `content/<your-name>/soft-skills/` for behavioral answers
   - Add `content/<your-name>/resources/` for resumes or other personal docs
2. **Reuse the shared question banks**
   - Use the prompts in [`content/prep/soft-skills/getting-stuff-done-questions.md`](content/prep/soft-skills/getting-stuff-done-questions.md) or other files in `content/prep/soft-skills/` as your question source.
   - Create your own answer file alongside Mike’s, e.g. `content/<your-name>/soft-skills/getting-stuff-done.md`.
3. **(Optional) Add AI skills for your profile**
   - Copy the pattern from `.cursor/skills/msilvis-study-prep/SKILL.md`, but:
     - Change the `name:` to `<your-name>-study-prep`
     - Update any examples or commands to use your own prefix (e.g. `alex:study-prep` instead of `msilvis:study-prep`)
   - If you want a “reset” command, mirror `.cursor/skills/msilvis-reset-questions/SKILL.md` with your own prefix.
   - For soft-skills, you can mirror `.cursor/skills/msilvis-soft-skills/SKILL.md` and use your own prefix (e.g. `alex:soft-skills`).

### Using the LeetCode playground with skills

The Swift playground in `content/prep/leet/` is general-purpose and can be used by anyone. The examples in `content/prep/leet/README.md` reference `msilvis`-specific commands; treat those as one concrete example:

- If you create your own study skill, you can define similar commands that map to your prefix.
- If you don’t define any skills, you can still open and run the playground entirely in Xcode.

### Quick start for new users

1. **Explore shared prep materials**
   - Browse `content/prep/leet/` for hands-on coding problems and `content/prep/study-guide/` for topic overviews.
   - Skim `content/prep/soft-skills/getting-stuff-done-questions.md` if you want a behavioral interview template.
2. **Create your own profile (optional but recommended)**
   - Make a folder `content/<your-name>/soft-skills/` for your behavioral answers.
   - Make a folder `content/<your-name>/resources/` for your resume, history, or ladder notes.
3. **Keep shared vs personal content separate**
   - Do **not** edit question banks under `content/prep/` with personal answers.
   - Instead, create your own answer files under `content/<your-name>/` (mirroring the `content/msilvis/` examples).
4. **(Optional) Add your own AI skills**
   - Copy `.cursor/skills/msilvis-study-prep/`, `.cursor/skills/msilvis-soft-skills/`, and `.cursor/skills/msilvis-reset-questions/` as templates.
   - Rename the directories and update the `name:` and command prefix inside each `SKILL.md` to use your own handle.

### AI helpers (Claude / Cursor)

- **Workspace + skills overview**: See [`CLAUDE.md`](CLAUDE.md) for how to:
  - Run interactive study sessions with `msilvis:study-prep`
  - Generate or refine soft-skills answers with `msilvis:soft-skills`
  - Reset study context with `msilvis:reset-questions`
- **Project rules for agents**: Cursor/Claude will also read [`.cursor/rules/interview-workspace.mdc`](.cursor/rules/interview-workspace.mdc) to stay aware of this layout and these commands.

### Markdown viewer (Dockerized)

This repo includes a small web app under `viewer/` that scans the repository for `.md` files and renders them with a modern Tailwind + DaisyUI theme.

- **Run locally**
  1. `cd viewer`
  2. Install deps: `npm install`
  3. Build CSS: `npm run build:css`
  4. Start the server: `npm start`
  5. Open `http://localhost:3000` in a browser.

   By default, the app scans the repo root (one level above `viewer/`) for all `.md` files.

- **Run via Docker**
  1. Build the image (from repo root):\
     `docker build -t markdown-viewer ./viewer`
  2. Run the container, mounting this repo at `/content`:\
     `docker run --rm -p 3000:3000 -v "$(pwd)":/content -e CONTENT_ROOT=/content markdown-viewer`
  3. Open `http://localhost:3000` to browse all markdown files, organized by folder and styled with Tailwind + DaisyUI.

All `.md` files under the repo (excluding `.git`, `node_modules`, `.cursor`, `mcps`, and `viewer`) will be discoverable and viewable.

### Tooling with `mise`

This repo includes a minimal [`mise`](https://github.com/jdx/mise) config in `.mise.toml` to pin Node and add tasks for the viewer:

- **Tools**
  - Pins **Node 20** for the markdown viewer via:
    - `[tools] node = "20"`

- **Tasks**
  - `mise run viewer:install` – install viewer dependencies.
  - `mise run viewer:build-css` – build Tailwind/DaisyUI CSS.
  - `mise run viewer:start` – start the viewer on `http://localhost:3000`.
  - `mise run viewer:docker:build` – build the Docker image.
  - `mise run viewer:docker:run` – run the Docker container, mounting the current repo into `/content`.

