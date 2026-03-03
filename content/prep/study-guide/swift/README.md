## Swift / SwiftUI / Concurrency Study Guide

This guide is written as a **compact book for tech‑lead‑level iOS interviews**, with a heavy emphasis on **concurrency, SwiftUI architecture, and system‑level tradeoffs**.

Treat each markdown file as a **chapter**. You can read front‑to‑back for a structured pass, or jump directly to the chapters that match your weakest areas or an upcoming interview focus.

---

### What this guide covers

- `swift-language-fundamentals.md`
  - Value vs reference types, structs vs classes.
  - Optionals, error handling, protocols, generics.
- `swift-concurrency.md`
  - async/await, tasks, task groups, actors, `MainActor`, cancellation.
  - Bridging from callback‑based APIs.
- `swiftui-basics.md`
  - View lifecycle, identity, diffing.
  - State management: `@State`, `@StateObject`, `@ObservedObject`, `@EnvironmentObject`, `@Binding`.
- `swift-memory-and-performance.md`
  - ARC, retain cycles, `weak` vs `unowned`, copy‑on‑write.
- `swiftui-architecture-and-patterns.md`
  - MVVM in SwiftUI, dependency injection, navigation patterns, modularization.
- `networking-and-data-layer.md`
  - URLSession, Codable, async APIs, retry and error handling at a high level.
- `testing-and-debugging.md`
  - XCTest basics, testability of SwiftUI views and async code, debugging tools.
- `system-design-lite-for-ios.md`
  - How iOS apps talk to backend systems, offline‑first, feature flags, and modular architectures.

Each chapter roughly follows:

- **Why this matters in interviews**
- **Core concepts**
- **Canonical patterns** with small Swift snippets where helpful
- **Advanced issues & tradeoffs** (sharp edges, failure modes, and scaling concerns)
- **Interview Q&A** (short answers)
- **Practice prompts** (scenario questions you can walk through)

---

### Book structure

- **Part I – Swift language & memory**
  - `swift-language-fundamentals.md`
  - `swift-memory-and-performance.md`
- **Part II – Concurrency in modern iOS**
  - `swift-concurrency.md`
  - Interactions between actors, `MainActor`, and SwiftUI.
- **Part III – SwiftUI foundations**
  - `swiftui-basics.md`
  - State management, view identity, navigation.
- **Part IV – Architecture, data, and testing**
  - `swiftui-architecture-and-patterns.md`
  - `networking-and-data-layer.md`
  - `testing-and-debugging.md`
- **Part V – System design lite for iOS**
  - `system-design-lite-for-ios.md`
  - How mobile fits into broader backend and org‑level design.

If you want a “cover‑to‑cover” read, work through Parts I–V in order. If you’re close to an interview, spend disproportionate time on **Parts II–IV**, since that’s where most TL‑level depth questions live.

---

### Senior / staff angle

- **Tell end‑to‑end stories**: for each chapter, prepare at least one concrete story of a real feature you designed, shipped, and operated (concurrency model, SwiftUI architecture, data layer, observability).
- **Make tradeoffs explicit**: be able to contrast at least two viable designs (e.g., callbacks vs async/await, global singletons vs DI, monolith vs modular app) and justify your choice given risk, migration cost, team familiarity, performance, and reliability.
- **Think in org‑level patterns**: treat these chapters as seeds for **standards you’d write for your team** (navigation patterns, error‑handling conventions, how to structure async APIs, how to test SwiftUI code).
- **Highlight leadership behaviors**: frame answers in terms of mentoring, code review guidance, and how you aligned stakeholders or unblocked a team, not just the code you wrote.

---

### How to read and practice

- **First pass (book‑style)**
  - In each chapter, read **core concepts**, then the **canonical patterns**.
  - Pay special attention to the **advanced issues & tradeoffs**: where things break at scale, where APIs are easy to misuse, and how you’d design safer patterns for your team.
- **Second pass (deepening weak spots)**
  - Pick a theme (e.g., “concurrency”, “SwiftUI navigation”, “data layer + offline‑first”) and read the relevant chapters back‑to‑back.
  - After reading, write down how you’d design or refactor a real feature you’ve worked on using those patterns.
- **Interview simulation passes**
  - Use the **Interview Q&A** sections as prompts; answer out loud as if you were in a loop.
  - Use the **practice prompts** to walk through full scenarios (with whiteboard sketches where appropriate): how you’d structure an app, migrate legacy code, or debug a production issue.

Over time, you should be able to:

- Move comfortably between **language details** (value semantics, ARC, actors) and **architecture decisions** (module boundaries, dependency injection).
- Explain **why** Swift’s concurrency and SwiftUI models are designed the way they are, and how you’d keep a large codebase safe and evolvable while using them.

Use this guide as a spine; plug in concrete examples from your own projects so your answers land as **specific, battle‑tested stories** rather than theory.

###
