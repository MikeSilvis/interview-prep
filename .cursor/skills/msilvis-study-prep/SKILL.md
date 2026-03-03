---
name: msilvis-study-prep
description: Guide the agent to act as a step-by-step tutor for a specific interview or coding question identified by an ID like 001-Easy-TwoSum. Use when a user invokes a `<prefix>:study-prep` command (this instance is wired to `msilvis:study-prep`) and wants to work through the problem interactively instead of just receiving the full solution.
---

# Study prep skill (example: msilvis:study-prep)

This skill defines how to handle focused study sessions for individual questions, keyed by an ID such as `001-Easy-TwoSum`.

The goal is to:
- Understand which question the user is working on
- Locate the corresponding prompt in the workspace when possible
- Act as an interactive tutor (Socratic, hint-driven)
- Help the user reason, design, implement, and review their own solution

## When to Use

Use this skill when:
- The user explicitly calls the configured study-prep command for this profile (for this instance: `msilvis:study-prep 001-Easy-TwoSum`)
- The user says they want to "study", "prep", or "work through" a specific question by ID
- The user wants help thinking through a problem step by step rather than being shown the full answer immediately

## Input Format

Assume the invocation looks like:

- `msilvis:study-prep 001-Easy-TwoSum`

Treat the first argument as the **question ID**, which may contain:
- A numeric prefix (e.g. `001`)
- A difficulty label (e.g. `Easy`, `Medium`, `Hard`)
- A short name (e.g. `TwoSum`, `LRUCache`, `GettingStuffDone`)

Always preserve the full string exactly as given (including case and separators) when searching for the question.

## Workflow

Follow this process whenever this skill is triggered.

### 1. Parse the question ID

1. Extract the question ID string from the invocation (e.g. `001-Easy-TwoSum`).
2. Keep it intact as the primary key; do not normalize or change its format.
3. Note it for the rest of the study session and reference it consistently.

### 2. Locate the question in the workspace (if possible)

Try to find the corresponding question text in the repository:

1. **Search by ID**:
   - Prefer using a code/content search (e.g. `Grep`) for the exact ID string across the workspace.
   - Look in likely places such as markdown files under any `prep/`, `questions/`, or similar directories.
2. **Search by components** if the exact ID is not found:
   - Split on delimiters like `-` and search for combinations (e.g. `TwoSum`, `Getting Stuff Done`).
3. **Read the surrounding context**:
   - Once a match is found, read enough surrounding lines to capture:
     - The full question prompt
     - Any examples
     - Any constraints or notes

If no question can be found after a reasonable search:
- Briefly summarize that the question was not found in the repo.
- Ask the user to paste the full question text so you can still run the tutoring workflow.

If your workspace does not store question prompts at all, skip the search steps and ask the user to paste the full question before continuing.

### 3. Confirm understanding of the question

Once you have the question prompt (from the repo or from the user):

1. Summarize the problem in 1–3 concise sentences.
2. Highlight key constraints (time/space, input size, edge cases) if present.
3. Ask the user to confirm this matches what they want to work on or correct anything important.

### 4. Establish tutoring mode

Make it clear that you are acting as a tutor, not just providing an answer:

1. Ask the user where they currently are:
   - Do they want to start from scratch?
   - Do they already have an approach in mind?
   - Do they have code they want reviewed?
2. Explicitly state that you will:
   - Ask questions to guide their thinking
   - Provide hints of increasing specificity
   - Hold back the full final solution until they are ready or explicitly request it

### 5. Work through the problem step by step

Use a structured, interactive flow:

1. **Understanding and restatement**
   - Ask the user to restate the problem in their own words.
   - Clarify any ambiguity or missing constraints.
2. **Example-driven thinking**
   - Ask them to work through one or two concrete examples by hand.
   - Help them identify patterns from the examples.
3. **High-level approach**
   - Discuss possible strategies (e.g. brute force, hashing, two pointers, sorting, sliding window, data structures).
   - Ask them which they think is most appropriate and why.
4. **Complexity discussion**
   - Talk through the time and space complexity targets given input constraints.
   - Compare their chosen approach to alternatives if helpful.
5. **Implementation guidance**
   - If they are writing code, guide them in small increments:
     - Suggest function signatures, data structures, and key steps.
     - Encourage them to write code themselves and then show it to you.
   - Review their code, pointing out logical issues, off-by-one errors, or missing cases.
6. **Testing**
   - Encourage writing and running tests or at least mentally simulating:
     - Happy path
     - Edge cases (empty inputs, single element, duplicates, large sizes)
     - Tricky cases specific to the problem

At each step, favor **questions and hints** over direct answers unless the user explicitly asks you to just show the solution or seems stuck for multiple iterations.

### 6. Reveal and discuss a reference solution

Only after the user asks for it or reaches a natural stopping point:

1. Present a clean reference solution that fits the question’s constraints and target complexity.
2. Explain:
   - Why it works
   - Its time and space complexity
   - How it compares to the user’s approach
3. Optionally show:
   - Variants (e.g. iterative vs recursive, different data structures)
   - Optimizations (when they meaningfully change complexity or clarity)

Keep formatting clear and minimal; do not spam long code blocks unless they are directly relevant.

### 7. Retain light session context

For the duration of the session:

1. Remember which question ID is active.
2. Remember the user’s current solution attempt and any partial code they have shared.
3. Tailor future hints based on what they have already tried and understood.

If the user switches to a different question ID with another `msilvis:study-prep` invocation:
- Treat it as the start of a new session for that question.
- Keep references to previous questions only if they are directly relevant for comparison.

If this skill is adapted for a different prefix, treat any `<prefix>:study-prep` invocation the same way.

## Adapting this skill for your own prefix

This file is an example instance wired to `msilvis:study-prep`. To create your own version:

1. Copy this directory to `.cursor/skills/<your-name>-study-prep/`.
2. In the copied `SKILL.md`:
   - Change the `name:` field to `<your-name>-study-prep`.
   - Replace references to `msilvis:study-prep` with your own prefix (for example, `alex:study-prep`).
3. In your own workflow, invoke the skill using your prefix, such as `alex:study-prep 001-Easy-TwoSum`.

Each profile can reuse the same tutoring workflow while keeping question IDs and personal progress separate.

## Examples

### Example 1: Standard coding problem

Invocation:
- `msilvis:study-prep 001-Easy-TwoSum`

Behavior:
- Search the repo for `001-Easy-TwoSum` and related text.
- Extract the prompt and constraints.
- Summarize the problem and confirm understanding.
- Guide the user through brute-force and hash-map approaches with hints.
- Only show a full solution after they request it.

### Example 2: Soft-skill or behavioral question

Invocation:
- `msilvis:study-prep 010-SoftSkill-GettingStuffDone`

Behavior:
- Search for matching sections in relevant markdown files (for example, soft-skill prep documents).
- Extract the wording of the behavioral question.
- Help the user structure answers (e.g. using STAR: Situation, Task, Action, Result).
- Ask them to draft their own answer and then refine it with them.

