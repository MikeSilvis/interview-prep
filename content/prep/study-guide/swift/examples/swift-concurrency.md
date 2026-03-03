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

```kotlin
suspend fun loadData(): ByteArray =
    suspendCancellableCoroutine { continuation ->
        legacyLoadData { result ->
            when (result) {
                is Result.Success -> continuation.resume(result.data, null)
                is Result.Failure -> continuation.resume(null, result.error)
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

```kotlin
suspend fun loadProfileAndFeed(): Pair<Profile, List<Post>> = coroutineScope {
    val profileDeferred = async { api.fetchProfile() }
    val feedDeferred = async { api.fetchFeed() }

    val profile = profileDeferred.await()
    val feed = feedDeferred.await()
    profile to feed
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

```kotlin
suspend fun fetchAllDetails(ids: List<String>): List<Detail> = coroutineScope {
    ids.map { id ->
        async { api.fetchDetail(id) }
    }.map { deferred ->
        deferred.await()
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

```kotlin
class Counter {
    private val mutex = Mutex()
    private var value = 0

    suspend fun increment() {
        mutex.withLock {
            value += 1
        }
    }

    suspend fun current(): Int =
        mutex.withLock { value }
}

class UserViewModel(
    private val api: UserApi,
) : ViewModel() {
    private val _user = MutableStateFlow<User?>(null)
    val user: StateFlow<User?> = _user.asStateFlow()

    fun load() {
        viewModelScope.launch {
            _user.value = api.fetchUser()
        }
    }
}
```

Key idea: actors protect shared mutable state; `@MainActor` protects UI work.

---

### Advanced issues & tradeoffs

- **Structured vs unstructured concurrency in large codebases**
  - Overuse of `Task {}` and `Task.detached` turns code back into “callback soup”. As a TL, you should push most work into **structured scopes** (task groups, `async let`, clearly owned tasks) and reserve detached tasks for explicit, well‑documented fire‑and‑forget cases.
- **Cancellation propagation and leaks**
  - A common production bug is work that keeps running after a user leaves a screen. Design your APIs so that **cancellation flows from UI to tasks** (e.g., view model exposing `cancel()` or holding onto `Task` handles), and make child tasks respect cancellation checks.
- **Actor reentrancy and performance**
  - Actors serialize access, but excessive cross‑actor chatter can kill throughput. Be prepared to discuss when you’d **split actors**, minimize hops, or move heavy pure computations **outside** actors to avoid bottlenecks.
- **MainActor over‑use**
  - Blanket `@MainActor` on large types can hide slow work on the main thread. Prefer keeping only UI‑critical pieces on `MainActor` and pushing heavy work to background executors, then hopping back to the main actor for the final update.
- **Interoperability with legacy code**
  - When bridging from callbacks/GCD, centralize your continuations and async adapters instead of sprinkling `withCheckedContinuation` everywhere. This makes it easier to **audit correctness, cancellation, and error mapping** later.

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

