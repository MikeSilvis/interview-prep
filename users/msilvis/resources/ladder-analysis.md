# Ladder Analysis: Square History vs Resume vs Career Ladder

These are **personal notes for the `msilvis` profile**, mapping one engineer’s history to a specific public career ladder.

If you are reusing this workspace:

- Treat this file as an example of how to analyze your own history.
- Create your own ladder analysis under `users/<your-name>/resources/` rather than editing this one.

## Ladder Alignment: Where Your History Proves L6 (and Reaches Into L7)

### Scope & Impact

**L6:** *"Leads medium-to-large features, multi-person efforts that usually cross engineering team boundaries."*
**L7:** *"Track record of leading strategic or complex initiatives with clear impact on the organization."*

Your history has several **L7-grade** initiatives that your resume barely mentions or omits entirely:

| Initiative | Span | Scale | Resume Coverage |
|---|---|---|---|
| **Device Profiles v2** | 2023–2025 | Cross-team (Server, Dashboard, Mobile, Design), all 6 verticals, full lifecycle through GA | Mentioned indirectly as "RDM initiative" |
| **SuperPOS / Modes Platform** | 2024 | New platform architecture, re-auth flows, cross-team (Foundation + Modes) | One bullet ("Bridged communication...") |
| **Cash Management Rewrite** | 2025 | Ground-up rebuild: new framework, dual-coordinator persistence, async/await migration, GRDB, Sync Hub, KIF→XCUITest | **Not on resume at all** |
| **ReportsAppletV2** | 2026 | New cross-cutting framework, all 5 VPOS apps, all 5 report types migrated | **Not on resume at all** |
| **ControllerProtocol Refactor** | 2022 | 9-month systematic architecture overhaul of payment engine, ~1,000+ new tests | **Not on resume at all** |
| **Settings Provider Decomposition** | 2023–2024 | Dozens of modules extracted from monolithic SquareAccount, DI campaign | **Not on resume at all** |

---

### Design & Architecture

**L6:** *"Leads engineering designs, soliciting feedback and building consensus."*
**L7:** *"Guides architectural direction for their organization and helps evolve systems toward it."*

Key architectural patterns you **designed and drove** that aren't on the resume:

- **ControllerProtocol pattern** (2022) — replaced monolithic state enum with encapsulated, testable controller objects. Became the template for 14+ state migrations.
- **Settings Provider modularization** (2023) — Public/Impl/ImplWiring/Fake module structure adopted across 10+ settings domains.
- **Action-based state management with file persistence** (2024) — serialized fetch/update actions for Modes + Device Profiles.
- **Dual-coordinator persistence** (2025) — zero-data-loss Sync Hub migration design with Core Data always active as rollback safety.
- **SecuritySettings protocol split** (2026) — solved API confusion by separating computed vs stored vs combined interfaces across 63 files.
- **Protocol-driven SDK architecture** (2020) — split monolithic managers into injectable protocol/impl pairs, making the entire public API testable and injectable.

---

### Ownership (Full Lifecycle)

**L6:** *"Responsible for successful delivery including coordination, planning, design, development, testing, rollout, and maintenance."*

Your strongest full-lifecycle examples:

1. **DPv2**: Proto updates → migrator module → fakes → demo app → assignment workflow → banners → API migration → analytics → feature flag → GA rollout → DI cleanup → fallback removal. **3 years, start to finish.**
2. **Cash Management rewrite**: Data layer → architecture refactor → new UI framework → async/await migration → Sync Hub commands → GRDB persistence → Combine publishers → XCUITest migration. **6 phases in 5 months.**
3. **Reader SDK v2**: Built from scratch → architecture → public API → documentation → Jazzy site → distribution pipeline → dark mode → theming. **Full SDK lifecycle.**

---

### Mentorship & Team Building

**L6:** *"Lifts the skills and expertise of those around them."*

From your history (mostly absent from resume):
- Created **Jazzy documentation site** and comprehensive public API docs (21 types documented)
- Built **developer tooling**: cascading merge conflict resolver, test sleep avoidance AI rules
- Created **demo apps** for isolated iteration (DPv2 UI, ReportsAppletV2)
- Built **test infrastructure** used by the entire team: `R2PaymentEngineFakes`, snapshot test suite, KIF robots, XCUITest migration patterns

---

## Key Resume Gaps — What to Add

These are the highest-value items from your history that are **missing or underweight** on the resume, mapped to ladder language:

**For the Modes & Settings role (2023–Present):**

1. **"Architected and delivered the Cash Management ground-up rewrite"** — new framework, dual-coordinator persistence, async/await migration, GRDB local storage, and Sync Hub integration across 6 phases.
2. **"Designed and built ReportsAppletV2"** — a cross-cutting framework adopted by all 5 VPOS apps, migrating all report types to a unified architecture with passcode protection, badge aggregation, and deep linking.
3. **"Led a sustained DI/singleton elimination campaign"** — extracted 10+ settings providers from monolithic SquareAccount, removing singletons and establishing injectable patterns across checkout, security, and team management.
4. **"Designed the SuperPOS Modes platform architecture"** — action-based state management, file persistence, device code re-auth, and a shared generic state machine between DeviceProfileController and ModesController.

**For the Reader SDK role (2018–2023):**

5. **"Designed and executed the ControllerProtocol architecture"** — a 9-month refactor replacing a monolithic payment engine state enum with 14 encapsulated, testable controller objects, adding 1,000+ new tests.
6. **"Built the 3D Secure Buyer Verification feature"** — 7,430 insertions across 184 files, including AuthenticationManager, certificate resources, and 1,078 lines of tests.
7. **"Created the protocol-driven SDK architecture"** — split monolithic managers into injectable protocol/implementation pairs, established the testability pattern used for the SDK's entire lifespan.

---

## The Story Your History Tells

Your resume reads as a **coordination-focused tech lead**. Your actual history tells a much stronger story: you're an **architect who designs systems that last for years and then drives them through full delivery**. The ControllerProtocol pattern from 2022, the Settings Provider modules from 2023, and the Modes platform from 2024 are all still in active use. That's the L7 signal — *"designs with organizational impact that succeed long term"* — and it's almost invisible in your current resume.
