## Swift Language Fundamentals

---

### Why this matters in interviews

- Even in TL interviews, you’ll be expected to have **sharp fundamentals**.
- Many questions probe your understanding of **value vs reference semantics**, optionals, protocols, and generics.
- Good answers show you can reason about **safety, clarity, and performance** in Swift.

---

### Core concepts

- **Value vs reference types**
  - `struct`, `enum`, and `tuple` are **value types** (copied on assignment).
  - `class` and closures are **reference types** (shared references).
  - Prefer value types for modeling immutable or lightweight domain data.
- **Optionals**
  - `T?` can be `nil` or a `T`.
  - Unwrap via `if let`, `guard let`, optional chaining, or `??`.
  - Avoid `!` unless you’ve proven non‑nil (e.g., in tests or controlled code paths).
- **Protocols and protocol‑oriented style**
  - Protocols define **behavior contracts**.
  - Use protocol extensions for default implementations.
  - Helps with testability and decoupling.
- **Generics**
  - Let you write code that works with **any type** that meets constraints.
  - Combine generics with protocols to get type‑safe abstractions.
- **Error handling**
  - `throws` / `try` / `do-catch`.
  - Model recoverable errors vs programming mistakes differently.

---

### Canonical patterns (with Swift snippets)

#### Value vs reference semantics

```swift
struct Point {
    var x: Int
    var y: Int
}

class Box {
    var value: Int
    init(value: Int) { self.value = value }
}

var p1 = Point(x: 0, y: 0)
var p2 = p1         // copy
p2.x = 10           // does NOT affect p1

var b1 = Box(value: 0)
var b2 = b1         // shares reference
b2.value = 10       // DOES affect b1
```

#### Safe optional handling

```swift
func loadUserName(from storage: [String: String]) -> String {
    guard let name = storage["name"], !name.isEmpty else {
        return "Guest"
    }
    return name
}
```

#### Protocols + dependency injection

```swift
protocol UserService {
    func fetchUser(id: String) async throws -> User
}

struct RealUserService: UserService {
    func fetchUser(id: String) async throws -> User {
        // call backend
    }
}

final class UserViewModel: ObservableObject {
    private let service: UserService

    init(service: UserService) {
        self.service = service
    }
}
```

#### Generics with constraints

```swift
func maxElement<T: Comparable>(_ items: [T]) -> T? {
    guard var best = items.first else { return nil }
    for item in items.dropFirst() {
        if item > best {
            best = item
        }
    }
    return best
}
```

---

### Interview Q&A

- **Q: When would you choose a struct over a class?**  
  **A:** When you want **value semantics**, immutability by default, and simple data modeling without inheritance. Structs are great for domain models, DTOs, and view models that don’t need shared identity.

- **Q: How do you avoid force unwrapping?**  
  **A:** Prefer `guard let` / `if let` / `??` to handle nil cases explicitly. Only use `!` in cases where a crash is acceptable or you have strong invariants (e.g., outlets that are guaranteed to be wired).

- **Q: When would you use a protocol instead of a concrete type?**  
  **A:** When you want to **decouple** consumers from specific implementations (e.g., services, data sources) and to enable mocking in tests.

- **Q: How do generics help with performance?**  
  **A:** Generics are resolved at compile time, avoiding dynamic dispatch and boxing that you might see with `Any` or type‑erased containers.

---

### Practice prompts

- Explain to an interviewer how Swift’s value semantics help avoid bugs compared to reference semantics.
- Refactor an API using concrete types into one that depends on a **protocol** with multiple implementations (e.g., real vs mock network).
- Take a function that works on `[Any]` and refactor it to use **generics** and **constraints**.
- Describe how you’d model a domain object (e.g., `User`, `Order`) as a struct and why.

