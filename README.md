## Interview Prep Workspace

This repo is organized to separate **shared study materials** from **per-user notes and AI skills**, so anyone can plug in their own profile without stepping on others.

### Layout

- **`prep/`** – Shared, general-purpose prep content
  - `study-guide/` – Algorithm and Swift study guides (general knowledge)
  - `leet/` – Shared Swift LeetCode playground and README
  - `soft-skills/` – Question templates and interview rubrics (no user-specific answers)
- **`users/`** – Per-user content (notes, answers, resumes, etc.)
  - `users/msilvis/` – Mike’s personal materials
    - `soft-skills/getting-stuff-done.md` – Answer examples for the soft-skills template
    - `resources/resume.pdf` – Resume used in examples
- **`.cursor/skills/`** – AI skills that define how the agent behaves
  - `msilvis-study-prep/` – Skill for running question-focused study sessions for `msilvis`
  - `msilvis-reset-questions/` – Skill for resetting `msilvis`’s study progress context

### What is “general knowledge” vs “user-specific”?

- **General knowledge** lives in `prep/`:
  - Question banks, rubrics, and templates (like `prep/soft-skills/getting-stuff-done-questions.md`)
  - Shared problem sets and reference solutions (like the Swift LeetCode playground)
  - Language/framework study guides
- **User-specific content** lives in `users/<your-name>/` and is optional:
  - Your own written answers to behavioral questions
  - Personal resumes, career history, and private notes
  - Any custom material tailored to your background

### Adding your own profile

1. **Create your user folder**
   - Add `users/<your-name>/soft-skills/` for behavioral answers
   - Add `users/<your-name>/resources/` for resumes or other personal docs
2. **Reuse the shared question banks**
   - Use the prompts in `prep/soft-skills/getting-stuff-done-questions.md` as your question source.
   - Create your own answer file alongside Mike’s, e.g. `users/<your-name>/soft-skills/getting-stuff-done.md`.
3. **(Optional) Add AI skills for your profile**
   - Copy the pattern from `.cursor/skills/msilvis-study-prep/SKILL.md`, but:
     - Change the `name:` to `<your-name>-study-prep`
     - Update any examples or commands to use your own prefix (e.g. `alex:study-prep` instead of `msilvis:study-prep`)
   - If you want a “reset” command, mirror `.cursor/skills/msilvis-reset-questions/SKILL.md` with your own prefix.

### Using the LeetCode playground with skills

The Swift playground in `prep/leet/` is general-purpose and can be used by anyone. The examples in `prep/leet/README.md` reference `msilvis`-specific commands; treat those as one concrete example:

- If you create your own study skill, you can define similar commands that map to your prefix.
- If you don’t define any skills, you can still open and run the playground entirely in Xcode.

### Quick start for new users

1. **Explore shared prep materials**
   - Browse `prep/leet/` for hands-on coding problems and `prep/study-guide/` for topic overviews.
   - Skim `prep/soft-skills/getting-stuff-done-questions.md` if you want a behavioral interview template.
2. **Create your own profile (optional but recommended)**
   - Make a folder `users/<your-name>/soft-skills/` for your behavioral answers.
   - Make a folder `users/<your-name>/resources/` for your resume, history, or ladder notes.
3. **Keep shared vs personal content separate**
   - Do **not** edit question banks under `prep/` with personal answers.
   - Instead, create your own answer files under `users/<your-name>/` (mirroring the `users/msilvis/` examples).
4. **(Optional) Add your own AI skills**
   - Copy `.cursor/skills/msilvis-study-prep/` and `.cursor/skills/msilvis-reset-questions/` as templates.
   - Rename the directories and update the `name:` and command prefix inside each `SKILL.md` to use your own handle.

