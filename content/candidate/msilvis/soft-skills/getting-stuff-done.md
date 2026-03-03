# Mike Silvis — Getting Stuff Done: Interview Prep

---

## Focus Area 1 - Collaboration & Communication

### Question 1 — Complex cross-functional project with engineers in other disciplines

**Story: Remote Device Management / Device Profiles v2 (2023–2025)**

Device Profiles v2 was a 3-year end-to-end initiative I owned that required sustained coordination across four engineering disciplines: Server (API and proto design), Dashboard (web UI for profile management), Mobile iOS (the six Square POS apps), and Design.

**What made it complex:**
- The server team owned the proto contract and API surface. Every change on my side — adding new settings types, changing field names, introducing fallback behavior — required tight coordination with their release cycles. We couldn't ship mobile changes until the API was stable, but they needed mobile signal to validate the schema.
- The Dashboard team was building the management UI in parallel. I had to communicate the exact semantics of each settings field — which were computed, which were stored, what cascading behavior looked like — without them being able to run the iOS app.
- Design owned the end-state UX but didn't always have context on mobile constraints. I learned to front-load that conversation: flagging what was technically ambiguous or risky before a design was finalized rather than after.

**Resolving gaps:**
I established a shared proto document as the source of truth and insisted every team's changes were reflected there before any implementation started. When we hit ambiguities — like what "managed by Device Profile" actually meant for a setting that was also editable locally — I drove an explicit decision meeting rather than letting each team interpret it independently.

**An engineer I especially enjoyed working with:**
One of the server engineers and I fell into a good rhythm where I'd write up mobile-side edge cases as structured scenarios ("if server returns X, mobile should do Y — does this match your intent?"), and they'd validate or correct them before I coded anything. That pattern eliminated an entire class of late-stage integration bugs.

**Rubric Dimensions:** Collaboration, Communication, Team Effectiveness

---

### Question 2 — Working with a PM/designer to plan & scope a complex feature

**Story: Cash Management Ground-Up Rewrite (2025)**

The Cash Management rewrite was the highest-stakes scoping exercise I've been through — a complete architectural rebuild of a live, revenue-affecting feature across six phases.

**How we determined timeline:**
I worked with our PM to break the rewrite into phases with explicit "ship or rollback" decision points at each one. Rather than committing to an end date upfront, we defined each phase as independently shippable: Phase 1 (data layer), Phase 2 (UI framework), Phase 3 (async/await migration), and so on. That framing let us adjust scope at phase boundaries based on what we'd learned.

**Balancing speed vs. quality:**
The Sync Hub migration was where this tension was most acute. The PM wanted to unblock the SyncHub team quickly. I pushed back on a single-coordinator approach because a mid-migration failure would silently lose cash drawer data — that's real money. I designed a dual-coordinator architecture that kept Core Data always active as a rollback safety net. It added two weeks to the phase, but when we hit bugs during XCUI testing, we had zero data loss. That tradeoff turned out to be the right call.

**What I took away:**
Our PM was excellent at forcing prioritization decisions. When I'd present three equally important concerns, they'd ask: "If you could only fix one before launch, which is it?" That discipline — making the trade-off explicit rather than deferring it — changed how I now frame design decisions to stakeholders.

**Rubric Dimensions:** Collaboration, Communication, Team Effectiveness

---

## Focus Area 2 - Quality & Technical Decision-Making

### Question 3 — Most difficult bug you've encountered

**Story: Production App Hang — DeviceProfileController Thread Pool Exhaustion (2025)**

We had a Bugsnag-reported production hang that was hard to reproduce locally and had no obvious stack trace.

**Investigation:**
After ruling out the usual suspects (deadlocks, main thread blocking), I traced it to `DeviceSettingsContainerClientInterceptor` — a network interceptor that was called on every single outgoing request. On every call, it read `deviceProfileController.state`, a `MutableProperty` from ReactiveSwift. What I didn't fully appreciate initially was that `MutableProperty` uses internal thread locks, and under load — particularly during app launch when many requests fire simultaneously — threads were piling up waiting for the lock. The thread pool was being exhausted.

**The fix:**
The root cause was unnecessary live reads of state that only changed on login/logout. I memoized `deviceProfileID` and `modeId` into the interceptor at allocation time, updating them only when the underlying property changed. One property observation, zero per-request lock contention.

**Reproduction:**
I couldn't reliably reproduce the hang locally in development, but I wrote a synthetic load test that fired 50 concurrent requests at startup, which eventually triggered the behavior.

**What happened after:**
I added this pattern — "interceptors should never hold live references to reactive properties" — to our internal architecture docs. It also prompted a broader audit of all network interceptors, which found two other low-risk instances of the same pattern.

**Rubric Dimensions:** Awareness, Analysis, Troubleshooting

---

### Question 4 — Improving someone's work during a code review

**Story: Code Review on Cash Management Proto Conversion**

During a review of our Cash Management SyncHub integration, I noticed a PR that serialized `CashDrawerShift` to proto for the Sync Hub commands. The code looked straightforward and the tests passed.

**What I caught:**
I manually traced the `toProto()` path against the proto schema. Two fields — `employee` on `CashDrawerShiftEvent` and `endingDeviceInfo`/`closingDeviceInfo` on `CashDrawerShift` — were silently being dropped. The tests hadn't caught it because the test assertions were written against the same conversion code, not against the expected proto structure. The tests were testing internal consistency, not correctness.

**How I handled it:**
I left a detailed comment showing the expected proto structure, the actual output of the current code, and a concrete failing scenario ("if a shift is closed remotely, the dashboard will never know which device closed it"). I didn't frame it as a bug the author missed — I framed it as "here's the gap between what the proto expects and what we're generating." We then added four round-trip test files specifically designed to validate against the proto contract, not the Swift model.

**What I look for in code reviews, ranked:**
1. Correctness — does it do what it claims?
2. Data integrity — can it silently drop or corrupt data?
3. Test quality — are tests verifying the right things?
4. Maintainability — will the next person understand the intent?

**Improving my own work from feedback:**
A reviewer once pushed back on my use of nested closures in a settings provider, pointing out it made the error path impossible to follow. I rewrote it as explicit state transitions. I now treat "hard to follow" as a correctness issue, not just a style issue.

**Rubric Dimensions:** Awareness, Analysis, Troubleshooting

---

## Focus Area 3 - Learning and Growing

### Question 5 — Something important you've learned in the past year

**Learning: async/await and the limits of reactive programming**

The Cash Management rewrite was the first time I did a systematic migration away from ReactiveSwift toward Swift's native async/await, and it changed how I think about asynchronous code.

**What I learned:**
ReactiveSwift is powerful but it makes the error path almost invisible — errors often just disappear into the void unless you're explicit about them. Async/await forces you to handle the error path at the call site. When I migrated the four major workers (`GetCurrentCashDrawerShiftsWorker`, `CreateCashDrawerShiftWorker`, etc.), the async versions were 30–40% fewer lines and the error handling was explicit and readable.

**Why it mattered:**
We deleted 594 lines of ReactiveSwift from Cash Management and replaced it with 296 lines of async/await — net -300 lines — and the result was easier to review, easier to test, and caught more errors at compile time.

**How it changed my approach:**
I now push back when ReactiveSwift is proposed for new code in our codebase. The learning cost is high for new engineers, the error handling is implicit, and Swift concurrency does the same job with better tooling support. I've started making that case explicitly in design discussions.

**Rubric Dimensions:** Inventing & Learning, Curiosity, Empathy

---

### Question 6 — A major technical mistake

**Story: The RemoteCashDrawerClosure Feature (2025)**

In late 2025 I built and shipped a feature called `RemoteCashDrawerClosure` — a workflow that responded to an RDM push by closing a cash drawer remotely. Full implementation: `RemoteCashDrawerClosureWorkflow`, `RemoteCashDrawerClosureScreen`, `RemoteCashDrawerClosureGatekeeper`. ~953 lines of production code.

**Why it was a mistake:**
The feature was built against a product direction that was still being validated. We hadn't confirmed with the PM and business stakeholders that it would actually ramp. I moved forward on implementation because the technical design was clear and I was already deep in the Cash Management rewrite. The feature was never ramped and was deleted entirely in January 2026 — 1,685 lines removed.

**The real issue:**
I treated technical clarity as sufficient signal to build. It wasn't. I didn't have a confirmed go/no-go from the product side before investing significant engineering time.

**What I communicated:**
I flagged the deletion to the team directly. I didn't bury it — deleting 1,600 lines of code that was built a few months earlier is a visible event and deserves a clear explanation.

**What changed:**
I now require an explicit PM sign-off on "build vs. spike" before beginning implementation on features that depend on unvalidated product bets. A spike or prototype is fine; a full production implementation is not.

**Rubric Dimensions:** Inventing & Learning, Curiosity, Empathy, Awareness

---

## Focus Area 4 - Mentorship

### Question 7 — Helping a co-worker level up

**Story: Test Infrastructure and Patterns for the Team**

When I was deep in the PaymentEngine ControllerProtocol refactor (2022), I noticed that engineers writing tests against the payment engine were spending as much time setting up state as they were writing the actual test assertions. The test setup was complex, fragile, and required deep knowledge of engine internals.

**How I saw the opportunity:**
I was writing extensive tests myself for every controller migration (the `RetriableNetworkError` migration alone added 159 tests). I kept having to build ad-hoc setup helpers that would be useful to others but lived inside my PRs.

**What I did:**
I created the `R2PaymentEngineFakes` framework — a dedicated module with `PaymentEngineState+Fake` and `Payment+Fake` factory helpers — and documented the patterns in a README. Instead of PR-by-PR helpers, there was now a shared, versioned module any engineer could depend on. I also added a full snapshot test suite covering every major engine state, which gave the team a visual regression baseline.

**Outcome:**
New engineers could write payment engine tests without reading the internals. The snapshot suite caught two regressions in subsequent quarters that would have shipped.

**What I learned from it:**
Tooling is mentorship at scale. Instead of teaching one person how to write a test, I built something that taught everyone and kept teaching.

**Rubric Dimensions:** Mentorship, Team Effectiveness

---

### Question 8 — Person you've learned the most from

**Story: Working with the Apple Engineer on Tap to Pay**

When Square partnered with Apple on Tap to Pay, I was the iOS lead for the integration from prototype through production. This put me in direct collaboration with Apple engineers — a different engineering culture than anything I'd experienced.

**What was different:**
Apple engineers operate with an extremely high bar for API clarity and backward compatibility. When I proposed an approach that would have worked but would have been difficult to evolve without breaking changes, the Apple engineer I was working with asked one question that reframed everything: "What does this look like in three years if the requirements change?"

I was used to shipping things that worked now and dealing with future requirements when they arrived. Their mindset was to design the API surface as a contract that must remain stable, and invest heavily upfront in making that contract future-proof.

**What I incorporated:**
That question — "what does this look like in three years?" — became a tool I use in my own design reviews. It's how I now evaluate protocol designs, public APIs, and module boundaries. It's part of why the Settings Provider modules I built in 2023 have a clear `Public/Impl/ImplWiring/Fake` structure — designing for changeability from the start.

**Rubric Dimensions:** Mentorship, Awareness, Curiosity
