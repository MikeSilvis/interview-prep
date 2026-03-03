## Algorithms & Data Structures Study Guide

This guide is written as a **short book on interview‑grade algorithms**, not a daily checklist.

Read it as you would a reference text: work through the chapters in order when you want a structured pass, or jump directly to a chapter when you need to refresh a pattern or go deeper on harder cases.

---

### What this guide covers

- **Core data structures**
  - Arrays, strings, and hash maps/sets.
  - Linked lists (fast/slow pointers, reversal, merging, cycles).
  - Stacks and queues (including monotonic variants).
  - Trees and BSTs.
  - Graphs (BFS/DFS, shortest paths, topological ordering).
- **Core algorithms and patterns**
  - Sorting and binary search patterns.
  - Recursion and backtracking.
  - Dynamic programming recognition and templates.
  - Time/space complexity and tradeoffs at **scale**.

Each topic file is a **chapter** and follows a consistent template:

- **Why this matters in interviews**
- **Core concepts**
- **Canonical patterns** with small pseudo‑code templates
- **Advanced issues & tradeoffs** (edge cases, scale, and production‑style concerns)
- **Interview Q&A** (short, direct answers)
- **Practice prompts** (problem ideas without full solutions)

---

### Book structure

- **Part I – Foundations**
  - Big‑O and complexity.
  - Arrays & strings, hash maps/sets.
  - Linked lists, stacks, queues.
- **Part II – Trees, graphs, and traversal**
  - Trees & BSTs.
  - Graphs, BFS/DFS, topological sort.
- **Part III – Dynamic programming and advanced patterns**
  - Classic DP families (1D, 2D, knapsack‑style).
  - How to recognize DP vs greedy vs graph formulations.
  - Space/time optimizations and when they matter.
- **Part IV – Interview execution**
  - How to narrate tradeoffs.
  - How to debug and iterate under time pressure.

You don’t have to follow this order strictly, but if you want a “cover‑to‑cover” pass, treat Parts I–III as the main spine and revisit Part IV before interviews.

---

### Senior / staff angle

- **Optimize for clarity and tradeoffs, not tricks**: aim to converge on a solid approach in 10–15 minutes while stating what you would ship in production and why.
- **Keep at least two viable approaches in mind** for common patterns and be ready to compare them (e.g., sliding window vs prefix sums, BFS vs Dijkstra, \(O(n^2)\) DP vs \(O(n \log n)\) optimizations).
- **Practice “reviewer mode”**: for each chapter, think through how you’d coach a mid‑level engineer from an initial brute‑force idea to a production‑ready, observable implementation.
- **Tie patterns back to systems you own**: relate array/hash map tricks to caches and indexes, graph ideas to dependency graphs and routing, DP to pricing, recommendations, or resource allocation problems.

---

### How to read and practice

- **First pass (book‑style)**
  - Read each chapter’s **core concepts** and **canonical patterns**.
  - Skim the **advanced issues & tradeoffs** section to see how the pattern behaves under pathological inputs, scale, or real‑world constraints.
- **Second pass (problem‑driven)**
  - For a given pattern, solve 2–3 problems that use it.
  - After each problem, map your solution back to the chapter: which template did you actually implement, and where did you diverge?
- **Refinement passes**
  - Use the **Interview Q&A** sections as flashcards.
  - Use the **practice prompts** to design your own problems or mock whiteboard sessions.

If you are using Swift, the `prep/leet/LeetCode.playground` in this repo is a ready‑made problem set that roughly matches these chapters; treat each playground page as a worked example for the patterns described here.

Over time, you should be able to recognize **“this smells like sliding window / two pointers / DP on sequences / graph traversal”** within the first minute of reading a prompt, and confidently discuss alternative approaches and tradeoffs.

###
