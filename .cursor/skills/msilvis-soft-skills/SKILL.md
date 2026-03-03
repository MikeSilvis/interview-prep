---
name: soft-skills-generator
description: Generate and maintain user-specific soft-skills answers by reading shared question templates from `content/prep/soft-skills`, user history/resources from `content/<username>/resources`, and the career ladder reference in `content/prep/references/ladder.md`, then writing structured answers into `content/<username>/soft-skills` and summarizing current vs target ladder levels for interview prep. This instance is wired to the `msilvis:soft-skills` prefix and expects a username (for now typically `msilvis`) as an explicit first argument.
---

# Soft-skills answer generator (example: `msilvis:soft-skills`)

This skill defines how to:

- Take **shared behavioral/soft-skills question templates** from `content/prep/soft-skills`
- Take **user-specific background/resources** (e.g. work history, projects) from `content/<username>/resources`
- Generate or refine **user-specific answer packs** under `content/<username>/soft-skills`

At runtime, you should assume everything you need comes from these locations:

- Question templates in `content/prep/soft-skills`
- User resources in `content/<username>/resources`
- User answers in `content/<username>/soft-skills`
- The career ladder reference in `content/prep/references/ladder.md`

There is no separate configuration file; the only dynamic input is the username (first argument) and topic slug (second argument).

## When to Use

Use this skill when:

- The user explicitly invokes the configured soft-skills command (for this instance: `msilvis:soft-skills <username> <topic-slug> ...`)
- The user wants help **drafting or iterating** on behavioral / soft-skill interview answers
- You should base answers on:
  - Question templates in `content/prep/soft-skills`
  - User resources in `content/<username>/resources`
  - Existing answers (if any) in `content/<username>/soft-skills`

Examples (current primary use):

- `msilvis:soft-skills msilvis getting-stuff-done`

## Input Format

Assume the invocation looks like one of:

- **Single-topic mode (default):**
  - `msilvis:soft-skills <username> <topic-slug> [optional-args...]`
- **All-topics-in-folder mode:**
  - `msilvis:soft-skills <username> all [optional-args...]`
  - or (if only a username is provided) `msilvis:soft-skills <username>` → treat as `all`

Where:

- `<username>` (required):
  - The logical profile name (for now, typically `msilvis`)
  - Maps directly to per-user folders under `content/<username>/...`
- `<topic-slug>`:
  - A short identifier for which question set to work with
  - Typically corresponds to filenames under `content/prep/soft-skills`, for example:
    - `getting-stuff-done` → `content/prep/soft-skills/getting-stuff-done-questions.md`
    - `faang-soft-skills-and-behavioral-questions` → `content/prep/soft-skills/faang-soft-skills-and-behavioral-questions.md`
    - `block-hotel-booking-system` → `content/prep/soft-skills/block-hotel-booking-system.md`
- `all`:
  - Special topic indicator meaning "iterate over **all** templates in `content/prep/soft-skills` and generate/refresh answers for each one".

If extra arguments are present, treat them as **mode flags** (see "Modes of operation").

## Directory Conventions

Follow these directory patterns:

- **Shared question templates (read-only):**
  - `content/prep/soft-skills/*.md`
  - Example: `content/prep/soft-skills/getting-stuff-done-questions.md`

- **User resources (read-only reference data):**
  - `content/<username>/resources/*.md`
  - Example for `msilvis`: `content/msilvis/resources/square-history.md`
  - These files contain raw material: work history, project summaries, successes, failures, etc.

- **User answers (you may create/update):**
  - `content/<username>/soft-skills/*.md`
  - Example for `msilvis`: `content/msilvis/soft-skills/getting-stuff-done.md`
  - These are the per-user answer documents you generate or refine.

Never modify files under `content/prep/soft-skills` unless the user explicitly asks you to update the templates themselves.

## Modes of Operation

Support at least these modes (driven by optional-args or user instructions in the conversation):

- **Draft** (default): Create or substantially rewrite answers for the selected topic.
- **Refine**: Improve clarity, structure, or concision of existing user answers without discarding their voice.
- **Append**: Add additional stories or variants while preserving existing content.

If no explicit mode is given, infer from context:

- If the user has **no existing answer file** for the topic: use **Draft**.
- If the file exists and the user says "help me polish" / "tighten" / "refine": use **Refine**.
- If the user asks for "more examples" or "another story": use **Append**.

## High-level Workflow

Whenever this skill is triggered:

### 1. Parse inputs

1. Extract:
   - `username` (first argument)
   - `topicSlug` (second argument)
   - Any remaining arguments as raw `modeFlags` (optional)
2. Normalize only for **lookup**:
   - Keep the original strings for references and headings.
   - For filenames, you may:
     - Lowercase
     - Replace spaces with `-`
     - Strip non-filename-safe characters

### 2. Locate the question template(s)

Support both **single-topic** and **all-topics** flows:

1. If `topicSlug` is **`all` or missing**:
   - Enumerate all markdown files under `content/prep/soft-skills` (e.g. `*.md`).
   - For each file:
     - Derive a logical topic slug from the filename (e.g. `getting-stuff-done-questions.md` → `getting-stuff-done`).
     - Treat it as one topic and run the rest of this workflow (mapping questions → answers, generating/refining, integrating ladder) for that topic.
   - This is the "do all topics in the folder" behavior.
2. If `topicSlug` is a specific identifier:
   - Look for a markdown file under `content/prep/soft-skills` that matches `topicSlug`.
     - First, try common patterns:
       - `<topicSlug>-questions.md`
       - `<topicSlug>.md`
     - If that fails, use a content search scoped to `content/prep/soft-skills` for the slug text and pick the best match.

For each template file you select (one or many), **read** it and identify:

- The main **prompt(s)** and question text (titles, `### Question N`, and any quoted question blocks).
- Any **rubric** / "what interviewers are looking for" sections.
- Any suggested **depth prompts** that can guide follow-up questions.

If no matching template is found for a specific slug, say so explicitly and ask the user whether to:

- Paste the question in manually, or
- Point you to a different prep file.

### 3. Locate user resources

1. Look for a directory:
   - `content/<username>/resources`
2. If it exists:
   - Read all `.md` files in this directory (for example, `square-history.md`).
   - Treat them as **raw material**:
     - Projects
     - Incidents
     - Themes
     - Mistakes and learnings
3. If no resources directory exists:
   - Continue, but:
     - Be explicit that you are missing user-specific material.
     - Prefer to ask the user for 1–2 concrete stories before fabricating anything.

When constructing answers, **prioritize real stories from resources** over generic or invented examples.

### 4. Locate or create the user answer file

1. Derive the target answer path:
   - `content/<username>/soft-skills/<topicSlug>.md`
   - For example:
     - `msilvis` + `getting-stuff-done` →
       - `content/msilvis/soft-skills/getting-stuff-done.md`
2. If the directory `content/<username>/soft-skills` does not exist:
   - Create it when the user has asked you to write answers.
3. If the answer file already exists:
   - Read it in full.
   - Treat it as the **source of truth for the user’s current answers**.
   - Only modify it according to the selected mode (Draft/Refine/Append).

### 5. Build a mapping from questions → answers

Treat the question template as the authoritative list of prompts. For each question:

1. Extract:
   - A stable question identifier (e.g. heading text or "Question 3 — Most difficult bug").
   - The core prompt text.
   - Any associated rubric items.
2. In the user answer file:
   - Preserve or construct a structure that mirrors the template:
     - Same sections (e.g. `## Focus Area 1 - Collaboration & Communication`)
     - Same question headings with user-specific content underneath.
3. When refining or appending:
   - Try to keep existing headings and only update or add to the body under each question.

### 6. Generate or refine answers

For each question, follow this pattern:

1. **Grounding from resources**:
   - Look for relevant stories in `content/<username>/resources/*.md`:
     - Match by themes (e.g. "collaboration", "quality", "mentorship").
     - Match by concrete projects (e.g. "Device Profiles v2", "Cash Management rewrite").
2. **Draft or adjust the answer** using:
   - STAR / SAR or similar structure:
     - Situation
     - Task
     - Action
     - Result
   - Clear signposting and concise paragraphs.
3. **Voice & authenticity**:
   - When resources exist:
     - Maintain the user’s tone and factual details.
     - Do not invent companies, teams, or projects that are not mentioned unless the user explicitly allows anonymization or synthesis.
   - When resources are missing:
     - Ask the user for story details instead of fabricating them.
4. **Alignment with rubric**:
   - Use the rubric dimensions from the template (e.g. Collaboration, Communication, Awareness).
   - Make sure each answer surfaces evidence along those axes.

### 7. Write back to the user answer file

When writing to `content/<username>/soft-skills/<topicSlug>.md`:

- **Do**:
  - Keep a clean, predictable heading structure.
  - Insert clear section dividers (`---`) between major focus areas where it aids readability.
  - Preserve any **user-added notes** that aren’t part of a question’s main answer (e.g. TODOs), unless the user asks you to clean them up.
- **Avoid**:
  - Deleting large sections of user-authored content without being asked.
  - Overwriting answers that the user explicitly marked as "final" or "locked" (e.g. via inline comments).

If the operation is destructive (e.g. major rewrite), clearly say so in your explanation to the user and summarize what changed.

### 8. Summarize and suggest practice flow

After updating the file:

1. Summarize at a high level:
   - Which questions were added or updated.
   - Any major structural changes (e.g. new sections, consolidated stories).
2. Suggest a **practice flow**:
   - How the user might rehearse these answers.
   - Which questions they might want to prioritize based on the role or company.
3. Optionally, offer to:
   - Run a mock Q&A using the newly written answers.
   - Tighten or shorten long answers on request.

### 9. Integrate the career ladder (`content/prep/references/ladder.md`)

After (or alongside) generating/refining answers, use the ladder reference to help the user understand where they currently sit and what to emphasize in interviews.

1. **Read the ladder reference**
   - Open `content/prep/references/ladder.md`.
   - Focus primarily on the **IC ladder** sections (`L3 IC`, `L4 IC`, `L5 IC`, `L6 IC`, `L7 IC`, etc.) unless the user or their resources clearly indicate a people‑manager role.

2. **Determine the closest current level**
   - Use the combination of:
     - Concrete stories and responsibilities from `content/<username>/resources/*.md`.
     - The strength and scope of answers in `content/<username>/soft-skills/<topicSlug>.md`.
   - For each IC level:
     - Check how many bullets under **Scope & Impact**, **Technical Contributions**, **Ownership**, **Collaboration**, **Mentorship**, etc., are clearly supported by the user’s examples.
   - Identify:
     - The level where the user **fully satisfies the majority of bullets**.
     - The next level up where they **partially satisfy some bullets but have clear gaps**.
   - Summarize this as:
     - "You currently look closest to **Lx IC — [ladder title]**."
     - "You are partway toward **Ly IC — [ladder title]**."

3. **Show what’s needed to go up a level**
   - From the next-level section (e.g. L6 if the user is closest to L5), extract bullets that:
     - Are **not yet clearly demonstrated** by the user’s stories.
     - Are high‑leverage for promotion (e.g. leading multi‑team projects, setting technical direction, mentoring at scale).
   - Present these as a short, concrete list:
     - "**To grow toward L{target} IC, you’ll want more evidence of:**"
     - Then 3–7 bullets paraphrased into user‑friendly language.

4. **Highlight what to discuss in interviews**
   - From the current and next-level bullets the user **does** meet:
     - Map each to 1–2 specific stories from their resources/answers.
   - Produce a short "interview talking points" list:
     - Grouped by theme (e.g. "Ownership & Impact", "Cross‑team leadership", "Mentorship").
     - Each item should reference:
       - The ladder bullet it supports.
       - The concrete story to tell (by short name, not full retelling).
   - Emphasize:
     - **Which stories to lead with** for seniority calibration.
     - Where they can subtly show they are already operating at (or near) the next level.

5. **Keep ladder output concise**
   - Avoid pasting the entire ladder section.
   - Instead:
     - Name the closest and target levels.
     - List 3–7 "you already show these behaviors" talking points.
     - List 3–7 "these are the behaviors to lean into or grow" items.

This ladder integration should help the user both:

- Understand where they are on the Block‑style IC ladder.
- Know exactly **what to talk about in interviews** to signal current level and readiness for the next.

## Using `content/msilvis/resources` as a concrete example

For the `msilvis` username specifically:

- **Question templates**:
  - `content/prep/soft-skills/getting-stuff-done-questions.md`
  - `content/prep/soft-skills/faang-soft-skills-and-behavioral-questions.md`
- **Resources**:
  - `content/msilvis/resources/square-history.md`
  - (and any additional files added later)
- **Answers**:
  - `content/msilvis/soft-skills/getting-stuff-done.md`
  - Additional answer files per topic will be created as needed.

When invoked as:

- `msilvis:soft-skills msilvis getting-stuff-done`

You should:

1. Read `getting-stuff-done-questions.md` to understand the prompts and rubric.
2. Read `square-history.md` to pull concrete Square engineering stories and time periods.
3. Update `content/msilvis/soft-skills/getting-stuff-done.md` by:
   - Ensuring each question in the template has a corresponding answer section.
   - Aligning each answer with the rubric and leveraging specific stories from the resources.
   - Preserving Mike’s voice and details while improving structure and clarity.

## Adapting this skill for other prefixes

This file is an instance wired to the `msilvis:soft-skills` command. To create your own version:

1. Copy this directory to `.cursor/skills/<your-name>-soft-skills/`.
2. In the copied `SKILL.md`:
   - Change the `name:` field to `<your-name>-soft-skills`.
   - Replace references to `msilvis:soft-skills` with your own prefix (for example, `alex:soft-skills`).
3. Use your own command, such as:
   - `alex:soft-skills alex getting-stuff-done`

The core workflow remains the same; only the prefix and default username change.

