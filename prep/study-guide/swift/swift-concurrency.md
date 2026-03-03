## Swift Concurrency

---

### Why this matters in interviews

- For a TL role, interviewers will probe how you **design, reason about, and debug concurrent code**.
- Swift’s structured concurrency model (async/await, Task, actors) is now **first‑class** in modern iOS apps.
- Good answers show you understand both **high‑level patterns** and **sharp edges** (MainActor, cancellation, priority).
- At senior/staff levels, you’re expected to **set concurrency guidelines for your team**, review others’ designs, and lead migrations away from legacy GCD/callback code.

---

### Core concepts

- **async/await**
  - `async` marks functions that can be suspended.
  - `await` yields the current task while waiting for a result.
- **Tasks**
  - `Task { ... }` creates a new concurrent task attached to the current context.
  - `Task.detached { ... }` creates a task without inheriting actor context (use sparingly).
- **Structured concurrency**
  - Child tasks are tied to a parent scope (e.g., `async let`, `TaskGroup`).
  - Cleanup and cancellation are well‑defined.
- **Actors**
  - Reference types that **serialize access** to their mutable state.
  - Enforce isolation at compile time to avoid data races.
- **MainActor**
  - Ensures work runs on the main thread (UI updates).
  - Mark UI‑facing APIs with `@MainActor`.
- **Cancellation**
  - Cooperative; tasks should **check for cancellation** and stop early when appropriate.

---

### Canonical patterns

#### Bridging callbacks to async/await

```swift
func loadData() async throws -> Data {
    try await withCheckedThrowingContinuation { continuation in
        legacyLoadData { result in
            switch result {
            case .success(let data):
                continuation.resume(returning: data)
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }
    }
}
```

Key talking point: you **wrap callback‑based APIs** once, then use async/await everywhere else.

#### Using `async let` for parallel child tasks

```swift
func loadProfileAndFeed() async throws -> (Profile, [Post]) {
    async let profile = api.fetchProfile()
    async let feed = api.fetchFeed()

    return try await (profile, feed)
}
```

Child tasks start immediately and run in parallel; both are awaited before returning.

#### Task groups

```swift
func fetchAllDetails(ids: [String]) async throws -> [Detail] {
    try await withThrowingTaskGroup(of: Detail.self) { group in
        for id in ids {
            group.addTask {
                try await api.fetchDetail(id: id)
            }
        }

        var results: [Detail] = []
        for try await detail in group {
            results.append(detail)
        }
        return results
    }
}
```

Talking point: groups give you **structured fan‑out/fan‑in** and integrated error propagation.

#### Actors and MainActor

```swift
actor Counter {
    private var value = 0

    func increment() {
        value += 1
    }

    func current() -> Int {
        value
    }
}

@MainActor
final class UserViewModel: ObservableObject {
    @Published private(set) var user: User?

    func load() async {
        user = try? await api.fetchUser()
    }
}
```

Key idea: actors protect shared mutable state; `@MainActor` protects UI work.

---

### Interview Q&A

- **Q: What problem does Swift’s concurrency model solve compared to GCD?**  
  **A:** It provides **structured concurrency** with clearer lifecycles and compile‑time checks for actor isolation, reducing callback hell and data races you might still have with ad‑hoc GCD usage.

- **Q: When should you use `Task.detached`?**  
  **A:** Rarely; only when you explicitly **do not want** to inherit actor or priority from the current context (e.g., fire‑and‑forget logging). Most work should be in structured tasks.

- **Q: How do you avoid updating UI from a background thread?**  
  **A:** Mark UI‑facing APIs or view models with `@MainActor`, or hop to the main actor using `await MainActor.run { ... }`.

- **Q: How does cancellation work?**  
  **A:** Cancellation is cooperative. Tasks check `Task.isCancelled` or call `try Task.checkCancellation()` and exit early. Awaiting a cancelled task throws `CancellationError`.

- **Q: How do actors differ from serial dispatch queues?**  
  **A:** Both serialize access, but actors integrate with the **type system**: you can’t accidentally touch isolated state from outside without `await`; the compiler enforces isolation.

---

### Practice prompts

- Explain how you would migrate a callback‑heavy networking layer to async/await in stages.
- Design a **concurrent data loader** that deduplicates identical in‑flight requests using actors.
- Explain how you’d structure concurrency in a screen that loads multiple resources in parallel, cancels when leaving the screen, and safely updates UI.
- Discuss pros/cons of using `Task {}` from a SwiftUI button action vs injecting async functions into your view model.
 - Walk through how you’d debug and prevent a production incident caused by a race condition or missed cancellation (what signals you’d add, what patterns you’d standardize).
 - Describe the concurrency “guardrails” you would propose for your org (when to use `Task.detached`, when to use actors, how to think about `@MainActor` on view models and services).

