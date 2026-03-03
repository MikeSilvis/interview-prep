---
name: msilvis-reset-questions
description: Reset study progress context for a specific user's study sessions so that all questions are treated as fresh and unseen. Use when the user invokes a `<prefix>:reset-questions` command (this instance is wired to `msilvis:reset-questions`) and wants to clear any remembered progress, attempts, or biases across prior study-prep sessions.
---

# Reset questions skill (example: msilvis:reset-questions)

This skill defines how to "reset" the state of all questions for one profile’s study sessions (for this instance, the `msilvis` profile).

The goal is to:
- Clear any remembered notion of which questions have been attempted or completed
- Avoid letting previous context bias future tutoring
- Optionally clean up explicit progress-tracking artifacts when the user asks for it

## When to Use

Use this skill when:
- The user explicitly calls the configured reset-questions command for this profile (for this instance: `msilvis:reset-questions`)
- The user says they want to "start fresh", "reset all questions", or "clear progress" across their study prep
- The user is seeing behavior that relies too heavily on past sessions or completed questions

## What “Reset” Means

In this context, resetting questions is primarily about **resetting the assistant’s behavior and assumptions**, not blindly editing files.

Reset should:
- Clear any mental model of which question IDs are "done", "in progress", or "unstarted"
- Make the assistant treat every question as if it has not been attempted before in the current session
- Avoid referencing prior attempts or answers unless the user explicitly brings them up

Reset should **not** by default:
- Delete or modify question source files
- Overwrite user-written answers or notes
- Remove checkboxes, annotations, or content from prep documents unless the user directly requests it

## Workflow

Follow this process whenever this skill is triggered.

### 1. Clear in-session study context

1. Stop relying on any previous notion of:
   - Which question IDs have been attempted
   - What the user answered before
   - Which questions were marked "complete" or "mastered"
2. Treat all question IDs as fresh:
   - When `msilvis:study-prep` is next invoked, handle it as if it is the first time seeing that ID in this session.

You may still remember **general techniques and explanations**, but you should not assume the user’s prior mastery of a specific question ID unless they say so.

### 2. Avoid automatic file modifications

By default, **do not modify files** when resetting:

1. Do not change question markdown files, notes, or answers automatically.
2. Do not remove progress indicators (e.g. checkboxes, emojis, "DONE" tags) unless:
   - The user explicitly asks you to clear or reset them, and
   - You can clearly identify what constitutes a progress marker vs the question text itself.

If the user requests a **file-based reset** (for example, "clear all completed flags in my prep docs"):
- First, identify exactly which files and markers are involved.
- Make minimal, targeted edits that only touch those markers.
- Preserve question prompts and the user’s written answers unless they explicitly want them removed.

### 3. Reset any explicit tracking artifacts (only when requested)

If there is an explicit tracking mechanism (for example, a JSON or markdown file that lists question IDs and statuses) and the user asks to reset it:

1. Locate the tracking file(s) using search (e.g. look in `prep/` or `.cursor/` for progress-related filenames).
2. Inspect the structure:
   - Determine how question IDs and statuses are represented.
3. Apply one of the following strategies, depending on what the user requested:
   - **Soft reset**: Change all statuses to a neutral value (e.g. from `done`/`in-progress` to `unseen`).
   - **Hard reset**: Clear out the recorded progress entries but leave the file structure intact.
4. Keep edits minimal and reversible (e.g. avoid deleting entire files unless the user clearly wants that).

When in doubt, favor **soft resets** over destructive ones.

### 4. Align future study-prep behavior

After a reset:

1. When `msilvis:study-prep` is invoked for a question ID, behave as if:
   - This is the first session for that ID.
   - You do not know whether the user has seen it before.
2. Ask the user about their familiarity level if helpful:
   - "Have you worked on this one before or is it new to you today?"
3. Tailor the tutoring intensity and level of explanation based on their answer, not on any pre-reset assumptions.

If this skill is adapted for a different prefix, treat any `<prefix>:reset-questions` invocation the same way.

## Adapting this skill for your own prefix

This file is an example instance wired to `msilvis:reset-questions`. To create your own version:

1. Copy this directory to `.cursor/skills/<your-name>-reset-questions/`.
2. In the copied `SKILL.md`:
   - Change the `name:` field to `<your-name>-reset-questions`.
   - Replace references to `msilvis:reset-questions` with your own prefix (for example, `alex:reset-questions`).
3. Use your own reset command (for example, `alex:reset-questions`) to clear context for your study sessions without affecting anyone else’s.

## Examples

### Example 1: Pure context reset

Invocation:
- `msilvis:reset-questions`

Behavior:
- Forget which questions have been attempted or completed in this conversation.
- From now on, treat any question ID passed to `msilvis:study-prep` as fresh for this session.
- Do not modify any files.

### Example 2: File-based progress reset (on request)

User says:
- "Run `msilvis:reset-questions` and also clear all ✅ markers in my question prep markdown."

Behavior:
- Trigger the context reset described above.
- Identify the relevant markdown files (for example, under `prep/`).
- Carefully edit only the progress markers (such as replacing `✅` with a neutral symbol or removing it) while preserving the questions and any written answers.
- Confirm what was changed at a high level without pasting large amounts of file content.

