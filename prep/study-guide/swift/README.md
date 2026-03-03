## Swift / SwiftUI / Concurrency Study Guide

This guide is aimed at a **tech lead** level iOS interview where you’ll be asked about:

- Core Swift language fundamentals.
- **Swift concurrency** (async/await, Task, actors, MainActor, structured vs unstructured).
- **SwiftUI** (state management, view identity, navigation, architecture).

For **senior and staff** roles, assume you’ll also be evaluated on how you **design systems end‑to‑end, set patterns for other engineers, and make tradeoffs** across teams and releases.

Use it as a **daily skim** plus a source of talking points for mock interviews.

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

Each file roughly follows:

- **Why this matters in interviews**
- **Core concepts** (5–10 bullets)
- **Canonical patterns** with small Swift snippets where helpful
- **Interview Q&A** (short answers)
- **Practice prompts** (scenario questions you can walk through)

---

### Senior / staff angle

- **Tell end‑to‑end stories**: be ready to narrate how you designed, shipped, and operated a real feature (concurrency model, SwiftUI architecture, data layer, observability).
- **Make tradeoffs explicit**: for each topic, practice explaining at least two viable approaches and why you chose one (risk, migration cost, team familiarity, performance, reliability).
- **Think in org‑level patterns**: use the prompts to practice how you’d standardize patterns (e.g., navigation, async APIs, dependency injection) so multiple teams can move quickly without chaos.
- **Highlight leadership behaviors**: frame answers in terms of mentoring, code review guidance, and how you aligned stakeholders or unblocked a team, not just the code you wrote.

---

### Suggested 2–3 week prep plan

Assume **45–60 minutes per day**, focusing mostly on concurrency and SwiftUI.

#### Week 1 – Foundations + basic SwiftUI

- **Day 1–2: Swift language fundamentals**
  - Skim `swift-language-fundamentals.md`.
  - Implement or review small examples for protocols, generics, and error handling.
- **Day 3–4: SwiftUI basics**
  - Skim `swiftui-basics.md`.
  - Build or review a tiny SwiftUI screen that uses `@State`, `@StateObject`, and `@EnvironmentObject`.
- **Day 5: Concurrency intro**
  - First half of `swift-concurrency.md`: async/await, `Task`, `Task {}`, `Task.detached`.

#### Week 2 – Concurrency deep dive + SwiftUI data flow

- **Day 6–7: Structured concurrency**
  - Remainder of `swift-concurrency.md`: `TaskGroup`, cancellation, `async let`, `MainActor`.
  - Practice translating callback‑based code into async/await.
- **Day 8: Swift memory & performance**
  - Skim `swift-memory-and-performance.md` with focus on ARC, retain cycles, and actors + reference types.
- **Day 9–10: SwiftUI state & architecture**
  - Skim `swiftui-basics.md` again plus `swiftui-architecture-and-patterns.md`.
  - Think through how you’d structure a multi‑screen SwiftUI app using MVVM.

#### Week 3 – TL‑level polishing (optional but ideal)

- **Day 11: Networking & data layer**
  - Skim `networking-and-data-layer.md` and think about error handling, retries, and offline caching.
- **Day 12: Testing & debugging**
  - Skim `testing-and-debugging.md`; consider how to test async functions and SwiftUI views.
- **Day 13–14: System design lite**
  - Skim `system-design-lite-for-ios.md`.
  - Practice describing how your iOS app would integrate with a hotel booking backend (or similar system).

Use any remaining days for **mock interviews** focusing on:

- Explaining a concurrency design choice you’ve made.
- Walking through SwiftUI data flow and view identity.
- Describing how you’d structure a medium‑sized feature end‑to‑end.

