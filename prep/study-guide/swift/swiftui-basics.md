## SwiftUI Basics

---

### Why this matters in interviews

- Many modern iOS roles expect familiarity with **SwiftUI** for new feature work.
- Interviewers probe your understanding of **data flow, state management, and view identity**, not just syntax.
- Good answers show you can reason about **performance, lifecycle, and testability** of SwiftUI views.

---

### Core concepts

- **Declarative views**
  - You describe **what** the UI should look like for a given state; SwiftUI figures out **how** to update it.
- **View is a value type**
  - SwiftUI `View`s are **structs**; they are cheap descriptions, not long‑lived UI objects.
- **State management**
  - `@State`: simple, view‑local value types.
  - `@StateObject`: owns a reference‑type `ObservableObject` for the life of the view.
  - `@ObservedObject`: observes an object owned elsewhere.
  - `@EnvironmentObject`: object injected via environment, shared across subtree.
  - `@Binding`: a two‑way reference to another piece of state.
- **View identity**
  - Determined by **type + position** in the hierarchy + explicit `id` where provided.
  - Changing identity can cause SwiftUI to **recreate** subviews and reset state.

---

### Canonical patterns (with Swift snippets)

#### Simple state with `@State`

```swift
struct CounterView: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Text("Count: \(count)")
            Button("Increment") {
                count += 1
            }
        }
    }
}
```

#### View model with `@StateObject` / `@ObservedObject`

```swift
final class UserViewModel: ObservableObject {
    @Published var user: User?

    func load() {
        // kick off async work
    }
}

struct UserScreen: View {
    @StateObject private var viewModel = UserViewModel()

    var body: some View {
        VStack {
            if let user = viewModel.user {
                Text(user.name)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.load()
        }
    }
}
```

#### Passing `@Binding`

```swift
struct ToggleRow: View {
    @Binding var isOn: Bool

    var body: some View {
        Toggle("Enabled", isOn: $isOn)
    }
}

struct SettingsView: View {
    @State private var notificationsEnabled = false

    var body: some View {
        ToggleRow(isOn: $notificationsEnabled)
    }
}
```

---

### Interview Q&A

- **Q: When should you use `@State` vs `@StateObject` vs `@ObservedObject`?**  
  **A:** Use `@State` for simple value‑type state local to the view. Use `@StateObject` when the view **owns** a reference‑type view model for its entire lifetime. Use `@ObservedObject` when the view **does not own** the object and just needs to observe changes from an external owner.

- **Q: What is view identity and why does it matter?**  
  **A:** SwiftUI tracks views by their identity (type + position + `id`). If identity changes (e.g., conditional branches reorder views without stable IDs), SwiftUI can **drop and recreate** views, resetting `@State`.

- **Q: How does SwiftUI update the UI when state changes?**  
  **A:** State wrappers (e.g., `@State`, `@Published` in an `ObservableObject`) notify SwiftUI when they change; SwiftUI then **recomputes the body** for relevant views and diffs the result against the previous view tree.

- **Q: How do you avoid “State mutation during view update” errors?**  
  **A:** Avoid mutating state **while** SwiftUI is computing `body`. Mutate state only in response to user actions, async callbacks, or lifecycle events (`onAppear`, `task`, etc.), not during view construction.

---

### Practice prompts

- Explain the difference between `@State`, `@StateObject`, `@ObservedObject`, `@EnvironmentObject`, and `@Binding` to an interviewer and give example use cases.
- Sketch how you’d structure a multi‑screen SwiftUI app with a shared session/user object.
- Discuss how view identity affects list items when you add, remove, or reorder rows.
- Describe how you’d migrate a UIKit view controller to SwiftUI incrementally.

