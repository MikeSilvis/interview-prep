## Algorithms & Data Structures Study Guide

This guide is meant to be a **fast daily skim** to keep LeetCode‑style fundamentals fresh, not a full textbook.

Use it alongside active practice on your platform of choice. Read a section for 5–10 minutes, then immediately apply it to 1–2 problems that use the pattern.

---

### What this guide covers

- **Core data structures**
  - Arrays, strings, hash maps/sets.
  - Linked lists (fast/slow pointers, reversal, merging, cycles).
  - Stacks and queues (including monotonic variants).
  - Trees and BSTs.
  - Graphs (BFS/DFS, shortest paths at a high level).
- **Core algorithms and patterns**
  - Sorting and binary search patterns.
  - Recursion and backtracking (light touch).
  - Dynamic programming recognition and templates.
  - Time/space complexity and tradeoffs.

Each topic file follows a consistent template:

- **Why this matters in interviews**
- **Core concepts** (5–10 bullets)
- **Canonical patterns** with small pseudo‑code templates
- **Interview Q&A** (short, direct answers)
- **Practice prompts** (problem ideas without full solutions)

---

### Senior / staff angle

- **Optimize for clarity and speed under pressure**: aim to converge on a solid approach in 10–15 minutes while narrating tradeoffs as you go.
- **Keep at least two approaches in your head** for common patterns and be able to justify which one you’d ship given real‑world constraints (input sizes, latency, memory, team familiarity).
- **Practice “reviewer mode”**: for each topic, think through how you’d coach a mid‑level engineer from an initial brute‑force idea to a production‑ready, observable implementation.
- **Tie patterns back to systems you own**: relate array/hash map tricks to caches and indexes, graph ideas to dependency graphs and routing, DP to pricing, recommendations, or resource allocation problems.

---

### How to use this guide

- **Before a session**
  - Pick **one topic** (e.g., arrays/strings sliding window).
  - Skim the **core concepts** and **canonical patterns** sections.
- **During a session**
  - Do 1–3 problems that explicitly use that pattern.
  - After each, quickly map which part of your code corresponds to which bullet in the pattern.
- **After a session**
  - Glance at the **Q&A** section and answer questions out loud.
  - Note 1–2 pitfalls you hit; revisit that topic the next day.

---

### Sample weekly rotation (30 minutes/day)

#### Weekday rotation

- **Day 1 – Arrays & Strings**
  - Sliding window (fixed and variable).
  - Two pointers from both ends; fast/slow pointer in a single array.
- **Day 2 – Linked Lists**
  - Reverse list (iterative + recursive).
  - Detect cycle and find cycle start.
- **Day 3 – Trees & BSTs**
  - DFS traversals (pre/in/post‑order).
  - BFS level‑order; depth/height problems.
- **Day 4 – Graphs**
  - BFS vs DFS template.
  - Topological sort intuition and skeleton.
- **Day 5 – Dynamic Programming**
  - 1D DP (climbing stairs, house robber).
  - 2D grid DP (unique paths, min path sum).

Weekend:

- Quick **Big‑O cheatsheet review**.
- One mixed session using whatever patterns you’re weakest on.

---

### Combining this with LeetCode

- If you are using Swift, the `prep/leet/LeetCode.playground` in this repo is a ready-made problem set that matches these patterns.

- **Warm‑up (5 minutes)**
  - Skim one topic file’s **canonical patterns**.
- **Practice (20–30 minutes)**
  - Solve 1–2 problems tagged with that topic.
  - If you get stuck for >10 minutes, look back at the pattern template, not the solution.
- **Cool‑down (5 minutes)**
  - Answer 2–3 **Q&A** bullets for that topic out loud.
  - Write a 1–2 line summary of the pattern in your own words.

Over time, you should be able to recognize **“this is a sliding window problem”** or **“this is DP on sequences”** within the first minute of reading a prompt.

