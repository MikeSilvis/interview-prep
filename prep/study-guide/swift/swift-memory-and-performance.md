## Swift Memory & Performance

---

### Why this matters in interviews

- TL interviews often touch on **ARC, retain cycles, memory leaks, and performance tradeoffs**.
- Good answers show you can design APIs that are both **safe and efficient**, especially under Swift concurrency and SwiftUI.

---

### Core concepts

- **Automatic Reference Counting (ARC)**
  - Swift uses ARC for reference types (`class`, closures, actors).
  - Retain count increments on strong references; decrements when references are released.
- **Retain cycles**
  - Two objects strongly reference each other and are never deallocated.
  - Common with closures capturing `self` and reciprocal references between objects.
- **weak vs unowned**
  - `weak` references are optional and set to `nil` when the object deallocates.
  - `unowned` references are non‑optional and assume the referenced object outlives the owner; accessing after deallocation is undefined behavior.
- **Copy‑on‑write (CoW)**
  - Value types like `Array`, `Dictionary`, and `String` share storage until mutated.
  - Mutating a value triggers a real copy if it’s shared.
- **Performance basics**
  - Prefer **value types** and CoW collections where appropriate.
  - Avoid excessive copying and bridging between Foundation and Swift types.

---

### Canonical patterns and pitfalls

#### Avoiding retain cycles with closures

```swift
final class Downloader {
    var onFinish: (() -> Void)?

    func start() {
        // ...
        onFinish = { [weak self] in
            guard let self = self else { return }
            self.cleanup()
        }
    }

    private func cleanup() { /* ... */ }
}
```

Talking point: use `[weak self]` in long‑lived closures that outlive the call site (e.g., async callbacks, timers).

#### Parent/child relationships

```swift
final class Parent {
    var child: Child?
}

final class Child {
    weak var parent: Parent?
}
```

One side must typically be `weak` to avoid cycles.

#### Copy‑on‑write behavior

```swift
var a = [1, 2, 3]
var b = a       // shares storage
b.append(4)     // triggers copy; a remains [1, 2, 3]
```

Important for understanding when passing arrays/strings by value is still efficient.

---

### Interview Q&A

- **Q: How does ARC differ from a garbage collector?**  
  **A:** ARC inserts retain/release calls at compile time and deallocates objects deterministically when their retain count drops to zero; garbage collectors typically run periodically and may pause the world.

- **Q: When should you use `weak` vs `unowned`?**  
  **A:** Use `weak` when the reference can legitimately become `nil` during the owner’s lifetime. Use `unowned` only when you can **guarantee** the referenced object outlives the owner; otherwise you risk crashes.

- **Q: How would you debug a suspected retain cycle?**  
  **A:** Use Xcode’s memory graph debugger, check deinit not being called, inspect object graph for strong reference cycles, and audit closures/parent–child relationships for missing `weak` references.

- **Q: Does using many small value types hurt performance?**  
  **A:** Usually no; Swift is optimized for value types, and CoW collections keep copying efficient. Problems arise primarily with **large copying** or excessive bridging to Objective‑C/Foundation types.

---

### Practice prompts

- Explain how you would design a view model and service layer to avoid retain cycles when using closures and async/await.
- Given a leak report, walk through how you’d identify the cycle and fix it.
- Discuss tradeoffs between modeling data as `class` vs `struct` in a performance‑sensitive path.

