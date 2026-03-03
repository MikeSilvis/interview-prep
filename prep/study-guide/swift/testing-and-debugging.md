## Testing & Debugging

---

### Why this matters in interviews

- TLs are expected to care about **quality, regression prevention, and debugging discipline**.
- Interviewers often ask **“How would you test this?”** after you propose designs or code.

---

### Core concepts

- **XCTest basics**
  - `XCTestCase` subclasses, `setUp` / `tearDown`.
  - `XCTAssertEqual`, `XCTAssertTrue`, `XCTAssertThrowsError`, etc.
- **Testing async code**
  - Async test methods: `func testSomething() async throws`.
  - Use `await` directly in tests with async/await APIs.
- **Testing SwiftUI**
  - Prefer testing **view models and services** directly.
  - Optionally use snapshot or UI tests for critical flows.
- **Debugging tools**
  - Breakpoints, LLDB, `po`, memory graph debugger, instruments (Time Profiler, Allocations, Leaks).

---

### Canonical patterns

#### Testing a view model with async method

```swift
final class UserViewModelTests: XCTestCase {
    func test_load_setsUser() async throws {
        let service = MockUserService(user: User(id: "1", name: "Mike"))
        let viewModel = UserViewModel(service: service)

        await viewModel.load()

        XCTAssertEqual(viewModel.user?.name, "Mike")
    }
}
```

Key ideas:

- Inject a **mock service**.
- Use `async` test functions to await view model methods.

#### Debugging a crash or hang

- Reproduce with a **minimal test case** or scenario.
- Use **breakpoints** to narrow down where invariants break.
- Use the **memory graph debugger** to find leaks/retain cycles.
- Use **Instruments** (Time Profiler) for performance hotspots.

---

### Interview Q&A

- **Q: How do you test async/await code?**  
  **A:** Mark tests as `async` and `throws` where appropriate, await async functions directly, inject mock dependencies, and ensure tests don’t rely on real network or global state.

- **Q: How do you test SwiftUI views?**  
  **A:** Keep business logic in view models and services so most behavior can be covered with traditional unit tests; use UI tests/snapshots for key user flows and visual regressions.

- **Q: How do you debug a retain cycle?**  
  **A:** Look for deinit not being called, open the memory graph debugger, inspect strong reference chains, and fix by introducing `weak` references or breaking cycles in closures.

- **Q: How do you ensure a new feature is testable before you implement it?**  
  **A:** Design with **injection points** for dependencies, avoid singletons where possible, and separate side effects from pure logic.

---

### Practice prompts

- Take a feature (e.g., hotel search) and outline a test plan: unit tests, integration tests, and any UI tests you’d add.
- Explain how you’d debug a flaky crash that only happens in production, not in development builds.
- Discuss how you’d introduce tests into an existing untested Swift/SwiftUI codebase incrementally.

