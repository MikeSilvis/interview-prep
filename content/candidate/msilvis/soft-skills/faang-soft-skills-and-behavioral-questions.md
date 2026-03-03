# Mike Silvis — FAANG+ Soft Skills & Behavioral Answers

This document mirrors the shared FAANG+ behavioral template and anchors answers in concrete stories from my work at Square/Block.

---

## Meta — Product Sense, Execution, Leadership

### Product Sense — Improving an Existing Product

**Story: Device Profiles v2 — Making POS configuration sane at scale**

- **Situation:** By 2023, Square POS had accumulated years of ad-hoc, per-app device configuration. Store managers had to manually align security, tipping, store-and-forward, and other settings across dozens of devices. It was easy to get into inconsistent, even dangerous, states (e.g., one register allowing offline payments with high limits while another didn’t).
- **Task:** Design and ship Device Profiles v2 — a single, coherent model for per-device configuration across six POS apps — without breaking existing behavior for millions of devices.
- **Actions:**
  - Worked with server and dashboard teams to define a proto-based configuration model that captured all the nuance of existing settings while being forward-compatible.
  - Pushed for a **profile-as-source-of-truth** mental model: mobile devices should treat local toggles as views over a profile, not independent state. This meant designing explicit precedence rules and migration paths from the legacy `SquareAccount` settings.
  - Drove UX decisions with our design partners around how “managed by Device Profile” should surface in the app: banners, disabled toggles, and inline explanations to keep sellers oriented.
  - Introduced a `DeviceProfileMigrator` module to migrate existing device-level settings into the new system in a way that preserved seller intent and minimized surprises.
- **Results:**
  - Shipped DPv2 as the default mechanism for device configuration across all verticals.
  - Reduced configuration drift and support burden by centralizing settings in profiles and exposing clear, in-product explanations when a setting was profile-managed.
  - Established a reusable pattern — profile-based configuration plus migration module plus fakes layer — that other teams could follow for similar “unify legacy settings” efforts.

**How I’d talk about it at Meta:** This is an example of taking a messy, high-scale product surface (device configuration) and designing a model that is understandable to both users and engineers, with explicit trade-offs between flexibility, safety, and backward compatibility. I’d highlight how we defined success (fewer misconfigured devices, stable conversion metrics, no spike in support tickets) and iterated with design and partner teams to get there.

---

### Execution & Leadership — Driving an Ambiguous Project to Launch

**Story: Cash Management Ground-Up Rewrite & Sync Hub Migration (2025)**

- **Situation:** Cash Management (tracking physical cash drawers) was a critical feature with aging architecture: tightly coupled UI/data layers, ReactiveSwift everywhere, and a brittle persistence story. At the same time, the business wanted to move cash drawer data onto a new Sync Hub backend.
- **Task:** Lead a ground-up architectural rewrite of Cash Management — including a new UI framework, dual-coordinator persistence, GRDB-based local storage, and Sync Hub integration — while preserving data integrity for live cash drawers.
- **Actions:**
  - Broke the effort into **six explicit phases** (data layer foundation, UI separation, async/await migration, Sync Hub commands, GRDB persistence, test infrastructure) with “ship or rollback” decision points at each phase instead of a single big-bang launch.
  - Designed a **dual-coordinator** persistence architecture so that Core Data and the new store could run side-by-side, ensuring **zero-data-loss** migration and a safe rollback path.
  - Migrated key workers from ReactiveSwift to async/await, reducing code size and making error handling explicit and reviewable.
  - Built Sync Hub commands and a GRDB schema that matched the business’s audit and reporting needs, including round-trip tests to validate proto conversions.
  - Invested in XCUITest and KIF coverage for both old and new flows to catch regressions across six app verticals.
- **Results:**
  - Landed the rewrite with no data-loss incidents, despite multiple subtle bugs found during testing (e.g., double-emission from Core Data, missing proto fields).
  - Reduced technical complexity and lines of code in the core workers while preserving behavior, making future features significantly easier to add.
  - Created a template for how to run multi-phase, high-risk migrations in the monorepo: clear phases, explicit rollback, and test infrastructure baked in from the start.

**How I’d talk about it at Meta:** This is a classic “Execution” story: ambiguous requirements, competing priorities (shipping Sync Hub vs. protecting cash data), and a need to structure the work so the company can learn and adjust. I’d emphasize how I created intermediate milestones, defended quality in the face of schedule pressure, and used metrics and test signals to decide when to ship.

---

## Google — GCA, Googleyness, Leadership

### General Cognitive Ability — Tackling a Complex, Unfamiliar Problem

**Story: PaymentEngine ControllerProtocol Refactor (2022)**

- **Situation:** The `R2PaymentEngine` state machine was a large, monolithic enum representing every possible payment state. It was difficult to extend without regressions and nearly impossible for new engineers to reason about.
- **Task:** Redesign the payment engine around a `ControllerProtocol` architecture where each lifecycle state had its own controller, while preserving existing behavior and avoiding regressions across dozens of edge cases.
- **Actions:**
  - Started with a small, well-understood state (`WaitingForCardInput`) as the first controller implementation, using it as a template for the rest of the migration.
  - Systematically migrated each state (`AttemptingCancellation`, `ApprovedStatus`, `RetriableNetworkError`, etc.) into its own controller, adding focused unit tests and snapshot coverage along the way.
  - Introduced a dedicated `Fake` module and snapshot test suite to make it easy to visualize and validate behaviors for each state without diving into internals.
  - Kept a running map of invariants and cross-state behaviors (e.g., cancellation semantics, retry rules) so that refactors didn’t accidentally weaken guarantees.
- **Results:**
  - Reduced complexity in the core engine, making it easier to onboard new engineers and safer to add new states.
  - Increased test coverage and observability — regressions became visible as broken snapshots or failing controller tests rather than subtle runtime issues.
  - Turned a “big scary ball of state” into a collection of understandable, testable components with clear contracts.

**GCA framing:** I’d walk through how I decomposed a large, unfamiliar problem into tractable chunks, how I validated each step with tests and snapshots, and how I updated the plan as I learned more about the edge cases buried in the old implementation.

---

### Googleyness & Leadership — Creating an Inclusive, Effective Team Environment

**Story: Test Tooling as Mentorship (PaymentEngine & Device Profiles)**

- **Situation:** Colleagues were struggling to write tests for complex systems like the payment engine and Device Profiles. The mental model and setup overhead were high, which discouraged thorough testing.
- **Task:** Make it easier for any engineer — including new hires — to write realistic, high-value tests without needing to understand every internal detail.
- **Actions:**
  - Created the `R2PaymentEngineFakes` framework with factories for engine states and payments, paired with snapshot tests covering all major states.
  - Built a full fakes layer for `SquareDeviceProfile` models so engineers could write tests for device profiles without learning every proto field upfront.
  - Wrote clear READMEs and patterns, and used code review to coach others into these patterns instead of ad-hoc test scaffolding.
- **Results:**
  - Lowered the barrier to entry for meaningful tests, especially for new engineers or those outside the core teams.
  - Caught multiple regressions through the snapshot suite and fakes-based tests.
  - Shifted the culture toward “testability as a first-class design concern,” not an afterthought.

**Googleyness framing:** I’d emphasize making others successful (through tools and documentation), being open to feedback on the patterns, and how this approach raised the whole team’s bar rather than just my individual contributions.

---

## Amazon — Leadership Principles

### Ownership / Bias for Action / Deliver Results

**Story: Device Profiles v2 GA & Performance Fix (2023–2025)**

- **Situation:** After shipping DPv2, we saw a production app hang reported via Bugsnag. It was subtle, load-dependent, and not tied to a single obvious crash log.
- **Task:** Own the problem end-to-end — from root cause analysis through fix and validation — even though the failure pattern crossed multiple modules (Device Profiles, interceptors, networking).
- **Actions:**
  - Dug into the reports and traced the issue to `DeviceSettingsContainerClientInterceptor`, which was reading `deviceProfileController.state` (a ReactiveSwift `MutableProperty`) on every request.
  - Realized that under load, thread pools were being exhausted due to lock contention, leading to hangs without clean stack traces.
  - Designed a fix that **memoized** `deviceProfileID` and `modeId` at interceptor allocation time and updated them only when the underlying properties changed, eliminating per-request lock contention.
  - Added a synthetic load test to reproduce the behavior locally, and codified the guideline: “interceptors must not hold live references to reactive properties.”
  - Audited other interceptors for the same anti-pattern and fixed two lower-risk instances proactively.
- **Results:**
  - Eliminated the production hang and made the behavior robust under high load.
  - Documented the pattern so future interceptors avoided the same trap.
  - Demonstrated ownership beyond “my module” by fixing similar issues elsewhere.

**Amazon framing:** This maps directly to Ownership and Dive Deep — picking up a vague, cross-cutting failure, tracing it through multiple abstractions, and not stopping at the first fix but addressing the underlying class of problems.

---

### Dive Deep / Learn and Be Curious / Earn Trust

**Story: Proto Conversion Audit for Cash Management (2026)**

- **Situation:** As part of Sync Hub integration, we serialized `CashDrawerShift` and `CashDrawerShiftEvent` into proto messages. Early tests passed, but there were hints that some data wasn’t surfacing correctly downstream.
- **Task:** Verify that our proto conversions were correct and that no critical fields were being silently dropped.
- **Actions:**
  - Manually walked the `toProto()` implementations against the proto schema instead of trusting existing tests.
  - Discovered two silent data-loss bugs: `employee` was missing from `CashDrawerShiftEvent.toProto()`, and `endingDeviceInfo` / `closingDeviceInfo` were missing from `CashDrawerShift.toProto()`.
  - Added explicit round-trip tests that validated against the proto contract, not just internal Swift models.
  - Communicated the issue clearly to the team, framing it as “our tests are testing consistency, not correctness; here’s how we fix that.”
- **Results:**
  - Prevented subtle, long-lived data gaps that would have impacted reconciliation and debugging.
  - Increased trust in the Cash Management integration because we could demonstrate round-trip correctness.

**Amazon framing:** This is a Dive Deep + Earn Trust example: not accepting a “green” test suite at face value, digging until the behavior aligned with the real contract, and improving tests and communication so others could rely on the system.

---

## Apple — Craft, Collaboration, Product Quality

### Craft & Quality — Knowing When Not to Ship

**Story: Dual-Coordinator Architecture for Cash Management**

- **Situation:** The business wanted Sync Hub-backed cash drawers quickly, but the straightforward approach (single coordinator migration) had real risk: a bug could silently lose cash drawer history.
- **Task:** Design an architecture that balanced the desire to move to Sync Hub with an uncompromising stance on data correctness and auditability.
- **Actions:**
  - Proposed and implemented a **dual-coordinator** model: Core Data remained active alongside the new store, with explicit, testable migration paths and rollback support.
  - Documented the design in `COORDINATOR_DESIGN.md` to make the trade-offs clear to engineers, PMs, and stakeholders.
  - Added XCUI and integration tests that simulated mid-migration failures, verifying that data remained consistent and recoverable.
  - Pushed back on attempts to “simplify” by removing rollback paths before we had sufficient confidence from tests and staged rollouts.
- **Results:**
  - Shipped Sync Hub-backed cash drawers without data-loss incidents.
  - Created a reusable migration pattern that other teams could adopt when moving critical state to new backends.

**Apple framing:** This story shows a high bar for quality and user trust: shipping later with the right architecture instead of earlier with hidden risk, and treating real-world data (cash in a drawer) as sacred.

---

### Cross-Functional Collaboration — Balancing Design, Technical, and Product Constraints

**Story: Device Profiles v2 UX Across Dashboard and Mobile**

- **Situation:** Device Profiles spanned three major surfaces: web dashboard (configuration), mobile apps (behavior and messaging), and server APIs (source of truth). Each team had different constraints and intuitions about how the system should behave.
- **Task:** Align design, PM, and engineering across these surfaces so that sellers experienced a coherent, predictable system.
- **Actions:**
  - Co-ran working sessions with design and PM where we walked through concrete scenarios (e.g., “What happens when a profile changes while a device is offline?”) and aligned on the expected UX and technical behavior.
  - Advocated for small but important UX touches on mobile — banners, disabled toggles with clear text, and consistent wording for “managed by profile” — so sellers weren’t surprised by behavior they couldn’t locally override.
  - Translated design intent into precise technical semantics for server and dashboard teams, using structured doc examples instead of informal descriptions.
- **Results:**
  - A system where the web and mobile experiences told the same story about who controlled what, reducing confusion and support escalations.
  - Stronger cross-functional relationships built on a shared mental model of the system’s constraints and behavior.

**Apple framing:** This illustrates collaborating deeply with design and PM, holding the line on coherence and clarity, and making sure the final product feels intentional end-to-end.

---

## Netflix — Culture, Freedom & Responsibility

### Freedom & Responsibility — High-Autonomy, High-Impact Decisions

**Story: Removing Legacy Singletons and Introducing Mint DI (2024–2025)**

- **Situation:** Large parts of the POS codebase still relied on singletons and global state, which made testing, reasoning, and future features (like Modes) harder. There was no central “go rewrite this” directive; it was a pain experienced by many teams.
- **Task:** Systematically reduce singleton usage and move critical infrastructure (settings providers, hardware services, auth flows) to dependency injection using the Mint pattern, without destabilizing production.
- **Actions:**
  - Identified high-value candidates (SecuritySettings, TextMessageMarketing, HardwareService, Employee/Items services) where DI would unlock reliability and future features.
  - Designed and implemented `*Mint` containers and provider patterns that could be adopted incrementally, keeping old and new paths compatible during migration.
  - Created infrastructure like `LegacyDeviceSettingsProviderLifecycleManager` to manage initialization order and avoid subtle bugs during the transition.
  - Communicated the vision and patterns through PRs, docs, and code review, helping other teams adopt Mint in their areas.
- **Results:**
  - Substantially reduced reliance on global state, improving testability and enabling features like SuperPOS Modes.
  - Demonstrated that we could make deep architectural improvements without blocking product work or destabilizing the apps.

**Netflix framing:** This is a good example of operating with high autonomy and accountability: seeing a systemic problem, designing a path to fix it, and owning both the benefits and the risks of changing fundamental infrastructure.

---

## Ladder Mapping & Interview Talking Points

### Closest Level & Target Level

Based on my Square history and current answers:

- **Closest current level:** **L6 IC — A team leader**
  - I lead medium-to-large, multi-year initiatives (Device Profiles v2, Cash Management rewrite, SuperPOS/Modes platform) that cross multiple teams and disciplines.
  - I own design, implementation, rollout, and long-term health for significant subsystems, and I’m a go-to source of expertise in areas like settings architecture and device configuration.
- **Target / partial level:** **L7 IC — An organizational leader**
  - I have multiple examples of org-level technical leadership (e.g., DI/singleton elimination, AI tooling, migration patterns), but fewer stories where I’m accountable for entire organizational roadmaps or company-level bets end-to-end.

---

### Behaviors I Already Demonstrate (to Lean Into in Interviews)

- **Ownership & Scope (L6+):**
  - End-to-end leadership of Device Profiles v2 from design through GA, including migration and cross-team coordination.
  - Architecting and delivering the Cash Management rewrite with a dual-coordinator persistence model and Sync Hub integration.
- **Technical Contributions & Judgment:**
  - Deep refactors of core payment infrastructure (ControllerProtocol, async/await migrations) with strong test coverage and reliability improvements.
  - Careful treatment of data integrity (e.g., proto conversion audits, dual-coordinator for cash drawers, remote drawer closure deletion when the product direction changed).
- **Collaboration & Cross-Functional Leadership:**
  - Running structured working sessions with server, dashboard, and design to align on Device Profiles semantics.
  - Building long-term relationships with partners (e.g., Apple Tap to Pay collaboration) and internal teams around shared APIs and patterns.
- **Mentorship & Team Building:**
  - Creating reusable fakes, test infrastructure, and patterns so other engineers can contribute safely to complex systems.
  - Writing internal docs and architecture guides that help new engineers ramp faster.

---

### Behaviors to Emphasize or Grow Toward L7

- **Organizational Technical Direction:**
  - Tell more stories where I drive **multi-team technical strategy** (e.g., settings provider architecture, DI patterns, AI tooling) and explicitly tie them to organization-wide outcomes, not just local wins.
- **Multi-Org / Company-Level Impact:**
  - Highlight cross-org projects like SuperPOS/Modes and ReportsAppletV2 in a way that shows how they changed how multiple teams build and ship features.
- **Scaling Mentorship & Culture:**
  - Frame tooling and patterns work as **culture-shaping** (e.g., testability standards, “no Task.sleep in tests,” PR description tooling) that changes how entire groups work, not just a single team.
- **Strategic Storytelling:**
  - Practice telling a few “big arc” stories (e.g., Device Profiles from inception → rollout → hardening; Cash Management from legacy → rewrite → Sync Hub stabilization) that clearly show L7-ish scope and time horizon.

These talking points give me a small set of **go-to stories** I can reuse across Meta, Google, Amazon, Apple, and Netflix behavioral interviews, adapting framing but keeping the same underlying evidence of scope, ownership, and impact.

