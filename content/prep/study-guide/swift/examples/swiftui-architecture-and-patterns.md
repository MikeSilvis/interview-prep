## SwiftUI Architecture & Patterns

---

### Why this matters in interviews

- TL interviews focus on **how you structure a SwiftUI app**, not just how to build a single screen.
- You should be able to discuss **MVVM, dependency injection, navigation, modularization, and testability** in SwiftUI.
- At senior/staff levels, you’re also expected to reason about **team boundaries, long‑term evolution of the architecture, and how SwiftUI fits into a larger multi‑year strategy**.

---

### Core concepts

- **MVVM with SwiftUI**
  - `View` is a lightweight rendering of state.
  - `ViewModel` holds business logic and talks to services.
  - Services handle networking, persistence, and side effects.
- **Dependency injection**
  - Inject services into view models via initializers or environment.
  - Enables mocking and easier testing.
- **Navigation patterns**
  - `NavigationStack` and `NavigationPath` for explicit stack control.
  - Coordinators/routers for more complex flows.
- **State ownership**
  - Clearly define **who owns what**: avoid multiple owners of the same state.
  - Use `@StateObject` at **feature boundaries**, pass `@ObservedObject` or `@Binding` down.

---

### Canonical architecture sketch

```swift
protocol HotelService {
    func searchHotels(query: HotelSearchQuery) async throws -> [Hotel]
}

final class LiveHotelService: HotelService { /* ... */ }

@MainActor
final class HotelSearchViewModel: ObservableObject {
    @Published var results: [Hotel] = []
    @Published var isLoading = false

    private let service: HotelService

    init(service: HotelService) {
        self.service = service
    }

    func search(query: HotelSearchQuery) async {
        isLoading = true
        defer { isLoading = false }
        do {
            results = try await service.searchHotels(query: query)
        } catch {
            // handle error
        }
    }
}

struct HotelSearchScreen: View {
    @StateObject private var viewModel: HotelSearchViewModel

    init(service: HotelService) {
        _viewModel = StateObject(wrappedValue: HotelSearchViewModel(service: service))
    }

    var body: some View {
        // use viewModel.results / viewModel.isLoading
    }
}
```

```kotlin
interface HotelService {
    suspend fun searchHotels(query: HotelSearchQuery): List<Hotel>
}

class LiveHotelService(
    private val api: ApiClient,
) : HotelService {
    override suspend fun searchHotels(query: HotelSearchQuery): List<Hotel> {
        return api.get("hotels/search")
    }
}

class HotelSearchViewModel(
    private val service: HotelService,
) : ViewModel() {
    private val _results = MutableStateFlow<List<Hotel>>(emptyList())
    val results: StateFlow<List<Hotel>> = _results.asStateFlow()

    private val _isLoading = MutableStateFlow(false)
    val isLoading: StateFlow<Boolean> = _isLoading.asStateFlow()

    fun search(query: HotelSearchQuery) {
        viewModelScope.launch {
            _isLoading.value = true
            try {
                _results.value = service.searchHotels(query)
            } finally {
                _isLoading.value = false
            }
        }
    }
}

@Composable
fun HotelSearchScreen(service: HotelService) {
    val viewModel: HotelSearchViewModel = viewModel(
        factory = HotelSearchViewModelFactory(service),
    )

    val results by viewModel.results.collectAsState()
    val isLoading by viewModel.isLoading.collectAsState()

    // use results / isLoading to render UI
}
```

Talking points:

- Clear separation of concerns (view vs view model vs service).
- Dependencies injected from the outside (e.g., in the app/root).

---

### Navigation & composition

- Use **small, focused views** composed into larger screens.
- For complex flows:
  - Keep navigation state in a dedicated **flow view model**.
  - Use `NavigationPath` to encode logical routes, not just raw views.

High‑level example: a **booking flow** with search → details → checkout.

---

### Advanced issues & tradeoffs

- **Deep‑linking and navigation state**
  - Deep links, push notifications, and in‑app routes all compete to control navigation. Model navigation state as **data** (routes, parameters) and have a single place that reconciles external intents into a canonical `NavigationPath`.
- **Module boundaries and shared state**
  - Over‑sharing `EnvironmentObject`s across modules leads to tight coupling. Prefer passing narrow view models or dependencies at module boundaries, and keep truly global state small, well‑documented, and versioned.
- **Interop with UIKit and existing coordinators**
  - Many real apps mix UIKit and SwiftUI. Be ready to discuss how you’d embed SwiftUI inside existing controllers or vice versa, while keeping ownership of navigation and dependencies clear.
- **Performance and view identity**
  - Mis‑managed identity (e.g., changing `id`s, rebuilding heavy view trees) shows up as jank or state resets. Use stable identifiers and isolate expensive work in smaller subviews or view models.
- **Testing complex flows**
  - Complex flows are easiest to test when navigation and side effects are funneled through a small number of **coordinator or flow view models**. Talk through how you’d inject fakes and assert on emitted routes/events rather than full UI trees.

---

### Senior / staff angle

- **Think in feature boundaries and ownership**: decide which modules own which state and APIs so multiple teams can contribute without stepping on each other.
- **Plan for migrations**: be ready to describe how you’d move a UIKit MVC app toward a modular SwiftUI architecture over time without halting feature work.
- **Handle cross‑cutting concerns**: explain where analytics, feature flags, and error reporting live so they don’t leak into every view.
- **Design for testability at scale**: articulate patterns that make it easy for other teams to test view models and flows without brittle UI tests.

---

### Interview Q&A

- **Q: How do you structure a medium‑sized SwiftUI app?**  
  **A:** Typically with **feature modules**. Each module has views, view models, and services. The root app composes modules and injects shared dependencies (e.g., networking, analytics).

- **Q: How do you avoid putting too much logic in SwiftUI views?**  
  **A:** Push business logic into view models and services. Views should primarily bind to `@Published` properties and handle presentation logic (layout, formatting).

- **Q: How do you pass dependencies into deep SwiftUI hierarchies?**  
  **A:** Prefer initializer injection down the tree. If something is truly global (e.g., `SessionManager`), use `@EnvironmentObject` or custom environment values.

- **Q: How do you test SwiftUI architectures?**  
  **A:** Unit test view models and services directly using mock dependencies; use snapshot or UI tests for view layout and flows.

---

### Practice prompts

- Describe how you would structure a **hotel booking feature** end‑to‑end in SwiftUI (screens, view models, services).
- Explain how you’d refactor a view with a bloated body into smaller, testable components.
- Sketch how you’d organize a multi‑module SwiftUI app so teams can work independently.
 - Walk through a plan for incrementally migrating a legacy UIKit feature to SwiftUI while keeping risk low and allowing quick rollback.
 - Describe how you’d align multiple teams on shared navigation, dependency injection, and design‑system patterns in a large iOS codebase.

