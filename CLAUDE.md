## Using Claude / Cursor with this workspace

This repo is wired for interactive interview prep with Claude/Cursor. The shared content lives under `content/prep/`, and user-specific material lives under `content/<username>/`. This file summarizes how to drive the AI helpers effectively.

### Core commands for the `msilvis` profile

- **Study sessions – `msilvis:study-prep`**
  - Use when you want to **work through a single question step by step** instead of just seeing the final solution.
  - In chat, call it like:
    - `msilvis:study-prep 001-Easy-TwoSum`
    - `msilvis:study-prep 010-SoftSkill-GettingStuffDone`
  - The agent will:
    - Find the matching prompt in the repo when possible (e.g. under `content/prep/study-guide` or other prep files).
    - Summarize the problem and confirm understanding.
    - Act as a **Socratic tutor**: ask questions, give hints, and only reveal full solutions when you ask.

- **Soft-skills answers – `msilvis:soft-skills`**
  - Use when you want to **draft, refine, or extend behavioral interview answers** grounded in your own history.
  - Command shape:
    - `msilvis:soft-skills <username> <topic-slug> [optional-mode-flags]`
  - For the existing `msilvis` data:
    - Example: `msilvis:soft-skills msilvis getting-stuff-done`
    - Reads templates from `content/prep/soft-skills/`, e.g.  
      - [`content/prep/soft-skills/getting-stuff-done-questions.md`](content/prep/soft-skills/getting-stuff-done-questions.md)
    - Reads user resources from `content/msilvis/resources/`, e.g.  
      - [`content/msilvis/resources/square-history.md`](content/msilvis/resources/square-history.md)
    - Writes/updates answers under `content/msilvis/soft-skills/`, e.g.  
      - [`content/msilvis/soft-skills/getting-stuff-done.md`](content/msilvis/soft-skills/getting-stuff-done.md)
  - Modes (inferred from context or extra flags):
    - **Draft**: create answers when no file exists yet (default).
    - **Refine**: polish and tighten existing answers while keeping your voice.
    - **Append**: add additional stories or variants without overwriting.

- **Reset study state – `msilvis:reset-questions`**
  - Use when you want to **start fresh** and clear any notion of which questions are “done”.
  - Call it as:
    - `msilvis:reset-questions`
  - What it does:
    - Resets the assistant’s mental model of your progress so every question is treated as new for this session.
    - **Does not** touch your files by default (no answers or templates are deleted or edited unless you explicitly ask).

### Folder map the AI expects

- **Shared templates and guides (read-only)**
  - `content/prep/soft-skills/*.md` – behavioral question sets and rubrics  
    - e.g. [`content/prep/soft-skills/getting-stuff-done-questions.md`](content/prep/soft-skills/getting-stuff-done-questions.md)
  - `content/prep/study-guide/algorithms/` – algorithm notes and worked examples  
    - e.g. [`content/prep/study-guide/algorithms/README.md`](content/prep/study-guide/algorithms/README.md)
  - `content/prep/study-guide/swift/` – Swift/iOS study guide
  - `content/prep/leet/` – Swift LeetCode playground and README

- **User-specific content (read/write for answers)**
  - `content/<username>/resources/` – raw history and reference material  
    - For `msilvis`: [`content/msilvis/resources/square-history.md`](content/msilvis/resources/square-history.md)
  - `content/<username>/soft-skills/` – generated or hand-written soft-skills answers  
    - For `msilvis`: [`content/msilvis/soft-skills/getting-stuff-done.md`](content/msilvis/soft-skills/getting-stuff-done.md)

### Creating your own profile and skills

You can replicate the `msilvis` setup for another user:

- **Content**
  - Create `content/<your-name>/resources/` with your own work-history notes.
  - Create `content/<your-name>/soft-skills/` and let the AI generate or refine answers there.

- **Skills (optional but powerful)**
  - Copy `.cursor/skills/msilvis-study-prep/` to `.cursor/skills/<your-name>-study-prep/` and update:
    - `name:` to `<your-name>-study-prep`
    - Command prefix in the text (e.g. `alex:study-prep`).
  - Copy `.cursor/skills/msilvis-soft-skills/` to `.cursor/skills/<your-name>-soft-skills/` and update:
    - `name:` to `<your-name>-soft-skills`
    - Command prefix (e.g. `alex:soft-skills`).
  - Optionally copy `.cursor/skills/msilvis-reset-questions/` to `.cursor/skills/<your-name>-reset-questions/`.

With that in place, you can invoke:

- `alex:study-prep 001-Easy-TwoSum`
- `alex:soft-skills alex getting-stuff-done`
- `alex:reset-questions`

### Markdown viewer & Claude

The markdown viewer under `viewer/` (see `README.md` for setup) will surface all `.md` files under the repo, including the prep content and your generated answers. You can:

- Use Claude/Cursor to update content files.
- Refresh the viewer in your browser to see rendered changes immediately.

