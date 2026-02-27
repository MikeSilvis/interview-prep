# Mike Silvis — Engineering Work Archive
**Square / ios-register monorepo · 2019–2026**
**~2,600 commits across 8 years**

---

## Table of Contents
- [2019 — Reader SDK v1 & v2 Foundations](#2019)
- [2020 — R2 Architecture Refactor & IAP Modularization](#2020)
- [2021 — Payment Engine Overhaul & JWT Networking](#2021)
- [2022 — ControllerProtocol Refactor & 3DS Buyer Verification](#2022)
- [2023 — Device Profiles v2 & Settings Provider Architecture](#2023)
- [2024 — SuperPOS Modes Platform & Singleton Elimination](#2024)
- [2025 — Cash Management Rewrite & DPv2 Rollout](#2025)
- [2026 — ReportsAppletV2 & SecuritySettings Refactor](#2026)

---

<a name="2019"></a>
## 2019 — Reader SDK v1 & v2 Foundations

**135 commits**

### Overview
2019 was almost entirely focused on two major areas: (1) ongoing feature work on the publicly-shipped Reader SDK v1 (Objective-C), and (2) building Reader SDK v2 (Swift) from the ground up — a next-generation payment SDK targeting external/alpha developers. A smaller slice touched Point of Sale developer tooling.

---

### Reader SDK v1 — Public SDK Feature Work

**EMV-compliant receipt fields (April)**
Added `SQRDReceiptDetails` as a new public model class and surfaced new fields on `SQRDCard` and `SQRDTenderCardDetails`, giving external developers the data required to generate legally-compliant EMV card-present receipts. 14 files, +260/-11. Ticket: DPI-979.

**Delay Capture checkout parameter (April)**
Added `delayCapture` as a first-class `SQRDCheckoutParameters` property, wired through internal request models and the Commerce API adapter. Exposed Square's delayed-capture payment flow to SDK consumers. Ticket: DPI-980.

**Installation ID for cross-session tracking (January)**
Introduced `SQRDInstallationIdentifier` to generate and persist a stable device installation ID, sent with network requests for fraud/analytics. Included unit tests. Ticket: DPI-360.

**Bugsnag crash reporter enrichment (May)**
Added SDK version, environment, and bundle metadata to Bugsnag reports, and updated the CI release script to pipe the same metadata.

**Xcode 11 crash fix for `canOpenURL` (August)**
Fixed a production crash in `SIACInstalledApplicationsChecker` when the URL was nil under Xcode 11's stricter runtime.

**Podify ReaderSDK for `pod gen` (December)**
Major structural reorganization: created `SquareReaderSDK.podspec`, reorganized headers and sample app under a proper CocoaPods layout, enabling isolated development via `pod gen` without the full monorepo workspace. 89 files changed.

**iOS 13 sheet modal blocked in checkout flow (December)**
Set `modalPresentationStyle = .fullScreen` to prevent users from accidentally dismissing the payment flow with the iOS 13 swipe-down gesture. Oncall: ONCALL-95080.

---

### Reader SDK v2 — Built from Scratch in Swift

**`ReaderSDK2UI` framework created and populated (September)**
Extracted shared table view components into a new distributable `ReaderSDK2UI` CocoaPods framework. Moved reader pairing screens (`ReadersViewController`, `ReaderDetailViewController`, `ReaderPairingViewController`) into the framework from the sample app. Added a `Strings.swift` localization layer. 17 files, +686/-270. Tickets: R2-390, R2-391.

**Sample app redesigned around `UISplitViewController` (September)**
Replaced separate compact/full-size view controllers with a single `OrderEntrySplitViewController` that handles both compact and regular size classes, yielding a more robust iPad-native layout.

**Payment fields audit — missing parameters added (October)**
Comprehensive audit of `CreatePaymentRequest` against the Connect V2 API. Added missing fields to `PaymentParameters`, `Payment`, and the networking layer. Added `PaymentParametersTests`. Ticket: R2-478.

**`Card` and `CardPaymentDetails` public models (October)**
Introduced `Card.swift` and `CardPaymentDetails.swift` as first-class public models, giving developers structured access to card brand, last-four, entry method, and cardholder data. 11 files, +462/-106.

**Location permission enforcement before payment (October)**
Added `LocationPermission.swift` and wired it into `PaymentManager.startPayment()` so the SDK now fails fast with a descriptive `PaymentError` if location permission is not granted. Ticket: R2-59.

**Payment prompt UI moved to `ReaderSDK2UI` (October)**
Moved `PaymentPromptViewController` and `CurrencyFormatter` into the shared UI framework. Ticket: R2-392.

**Account observable in authorization lifecycle (October)**
Added `AccountObserver.swift` and threaded it through `AuthorizationManager`, `HardwareServiceContainer`, `PaymentManager`, and `ReaderSDK`, with comprehensive test updates.

**Comprehensive public API documentation (November)**
Added Swift doc comments across all 21 public-facing types in `ReaderSDK2`: `PaymentManager`, `ReaderManager`, `ReaderSDK`, `Card`, `CardPaymentDetails`, `Payment`, `PaymentParameters`, `Theme`, `Reader`, `ReaderState`, and more. +424/-41. Ticket: R2-436.

**Framework build & distribution pipeline (November)**
Created `Scripts/create_framework.sh` (93 lines) to compile and package ReaderSDK2 as a distributable `.xcframework`/`.framework` for external developers. Added a developer `setup` script and updated the README.

**Jazzy documentation site (November)**
Set up a complete Jazzy doc generation pipeline with a custom HTML/CSS theme (mustache templates, SCSS, JS). Created `jazzy-config.yaml` and `create_docs.sh`. +894 lines of theme scaffolding. This became the external-facing API reference site.

**Dark mode support for `ReaderSDK2UI` (November)**
Added dynamic color handling to all five custom cell types so the SDK UI renders correctly on iOS 13 dark mode devices.

**Unified theming: `ReaderSDK2.Theme` propagated into `ReaderSDK2UI` (November)**
Replaced the sample app's ad-hoc `Color.swift` with a single `ReaderSDK2.Theme` object threaded through all 38 UI files, establishing a single source of truth for theming.

**Geo-location data in `CreatePayment` requests (December)**
Introduced `GeoLocation.swift` and `LocationManager.swift` to capture device coordinates and include them in `CreatePaymentRequest`, satisfying card-network requirements for location data in mobile card-present payments. 17 files, +192/-49. Ticket: R2-478.

---

### Point of Sale Developer Experience

**Easy physical device deployment (February)**
Added a `hooks.rb` script and README section that automatically configures the POS project for one-command deployment to a connected physical device, reducing friction for internal engineers.

---

<a name="2020"></a>
## 2020 — R2 Architecture Refactor & IAP Modularization

**372 commits**

### Overview
2020 followed a clear arc: early months were deep architectural refactoring and monorepo migration; mid-year was new feature APIs and observability; late year was modularization, binary distribution improvements, and shipping a new standalone card-entry UI framework.

---

### ReaderSDK 2 — Architecture & Monorepo Migration (January–April)

**Protocol-driven architecture refactor (January)**
Major structural overhaul splitting the monolithic `AuthorizationManager`, `PaymentManager`, and `ReaderManager` into clean protocol/implementation pairs. Concrete implementations moved into `RealAuthorizationManager`, `RealPaymentManager`, and `RealReaderManager`. 983 insertions, 871 deletions across 28 files. Made the public API surface testable and injectable.

**International use gating (January)**
Enforced locale/region checking in `AuthorizationManager` to block use of ReaderSDK in unsupported international markets. Ticket: R2-77.

**Payment engine timeouts (February)**
Added configurable timeouts for the `.waitingForReader` and `.terminalError` states, preventing indefinite hangs. Ticket: R2-450.

**Background payment cancellation (February)**
Hooked into the `UIApplication` background lifecycle to cancel in-flight payments when the app goes to background, protecting against orphaned transactions. Ticket: R2-375.

**`statement_descriptor_identifier` support (February)**
Threaded a new optional field through `PaymentParameters`, `CreatePaymentRequest`, and the public API, letting merchants customize how charges appear on card statements. Ticket: R2-621.

**Reader pairing conflict detection (February)**
Added a guard in `RealReaderManager` to immediately fail a new pairing attempt if one was already in progress, preventing race-condition bugs. Ticket: R2-540.

**`MockCardReaderSupport` framework extracted (March)**
Extracted the `HQMockCardReader` family out of `PeripheralDebugging` into a standalone `MockCardReaderSupport` framework, giving R2 a clean, shareable mock reader dependency. Ticket: R2-958.

**ReaderSDK 1 monorepo migration (April)**
Landmark restructuring (319 files, 3,571 deletions) moving ReaderSDK 1 into the monorepo under `Verticals/ReaderSDK/`, replacing a hand-maintained Xcode project with a Podspec-driven dependency graph. Created dedicated `Public/`, `Testing/`, `SampleApp/`, and `KIFTests/` sub-pods. Tickets: R2-830/822/836.

---

### ReaderSDK 2 — Observability, Logging, and Error Handling (May–August)

**Session de-auth on invalid requests (May)**
Built a `NetworkServiceErrorProvider` that detects 401/invalid-credential errors and automatically triggers SDK de-authorization, preventing broken authenticated states. Ticket: R2-1054.

**`AuthorizationStateObserver` public API (May)**
Introduced a public `AuthorizationStateObserver` giving host applications an observable stream of SDK authorization state changes. Ticket: R2-1055.

**`R2Log` logging framework (May)**
Created a brand-new `R2Log` pod with a protocol-oriented `Loggable`/`Logger` abstraction. Extracted all in-SDK logging into this framework so that `MockReaderUI` and the SDK could share it without circular dependencies.

**Bluetooth reader generation in MockReaderUI (June)**
Implemented `RealContactlessAndChipReaderManager` with full support for generating a simulated Bluetooth contactless reader in the mock UI. Ticket: R2-991.

**Device details in `CreatePayments` requests (June)**
Added a `DeviceDetails` model and wired it into `RealPaymentManager`/`RealSDKManager` so every payment request carries device metadata automatically. Ticket: R2-902.

**`MockReaderUI` resource bundle (June)**
Added an `.xcassets` resource bundle and `UIImageExtensions` to `MockReaderUI`, enabling it to ship its own images without relying on the host app's assets.

**Developer-friendly error surface in MockReaderUI (July)**
Introduced a `MockReaderUIError` enum with descriptive error messages and a `Strings.swift` localization layer. Ticket: R2-1142.

**Request logger (July)**
Implemented a `RequestLogger` wired into `RealSDKManager` that traces every network request with its trace ID. Ticket: R2-1009.

**`ReaderSDK2UITableBuilder` pod (July)**
Split table-view layout utilities out of `ReaderSDK2UI` into a lighter-weight `ReaderSDK2UITableBuilder` pod, reducing the import footprint for `MockReaderUI`.

**Peripheral metadata in payments (July)**
Added a `PeripheralMetadata` model threaded through `PaymentParameters` → `CreatePaymentRequest`, so the payment backend receives hardware identity alongside each transaction. Ticket: R2-1150.

**Remove fatal errors from ReaderSDK2 (August)**
Replaced all `fatalError()` / `FatalErrorUtil` calls in `ReaderSDK2Impl` with proper error-recovery paths — a reliability milestone making the SDK safe in contexts where a crash is unacceptable. Ticket: R2-123.

---

### ReaderSDK 2 — Public API Completion (September–December)

**Card Not Present (CNP) API (September)**
Introduced the entire delegate-based API for Card Not Present (keyed-entry) payments — new `PaymentManagerDelegate`, `ReaderPairingDelegate`, `PairingHandle`, and `PaymentHandle` protocol types — and extended the `PaymentEngine` to support CNP as an initialization mode. Ticket: R2-1278.

**Delegate-only API migration (September)**
Completed migration away from closure/handler objects toward delegate protocols as the primary completion mechanism, making the API pattern consistent.

**Idempotency key threading (September)**
Passed the developer-supplied idempotency key all the way from `PaymentParameters` through `RealPaymentManager`, `ConnectV2APIService`, and into `CreatePaymentRequest`, enabling retry-safe payments.

**`connectionInfo` property (October)**
Added a full `ReaderConnectionState`/`ReaderConnectionInfo` type hierarchy to the public API (785 insertions), exposing detailed connection failure information through `ReaderInfo`. Ticket: R2-1293.

**MoMoney SwiftUI vertical (October)**
Brought `MoMoney` — a SwiftUI iOS 13 developer-facing POS API test app — into the monorepo under `Verticals/SPOS/MoMoney/`. 1,193 insertions, entirely new vertical.

**IAP multi-module decomposition (October)**
Decomposed the monolithic `SquareInAppPaymentsSDK` into five focused pods: `SQIPCore`, `SQIPCategories`, `SQIPAPI`, `SQIPLogger`, and `SQIPNetworking`. 583 insertions across 140 files.

**`SQIPCardEntryView` as a standalone module (November)**
Extracted the entire card-entry UI (form components, overlays, card face images, animations, validators, and a 268-file asset catalog) into a new `SQIPCardEntryView` pod. Enabled use in App Extensions that cannot load the full IAP SDK. Ticket: R2-1283.

**`SQIPTheme` as a protocol (November)**
Refactored `SQIPTheme` from a concrete object into a `SQIPThemableProtocol`, making the theming API more composable across `SQIPCardEntryView` and `SQIPCardEntryViewController`.

**Bitcode enablement for IAP (November)**
Enabled Bitcode for the IAP SDK, a requirement for App Store submission in certain configurations.

**App Extensions support for IAP (December)**
Marked `SquareInAppPaymentsSDK` and `SquareBuyerVerificationSDK` podspecs as App Extension safe, unblocking use inside iOS keyboard or share extensions. Ticket: R2-867.

**Developer retry API (November)**
Added a `retry()` method to `ReaderManager` and `ReaderConnectionState`, surfaced through `ReaderDetailViewController`, so host apps can programmatically request reconnect. Ticket: R2-1457.

**Reader re-enable after manual entry (December)**
Fixed a bug where hardware readers were not re-enabled after a CNP payment session ended, leaving them unable to accept tap/chip transactions. Ticket: R2-1486.

---

<a name="2021"></a>
## 2021 — Payment Engine Overhaul & JWT Networking

**348 commits**

### Overview
2021 was dominated by a systematic cleanup and extension of the `R2PaymentEngine` module, a new JWT/SquarePipes networking stack, offline payment infrastructure, new hardware support, and a new internal app (Furious8).

---

### Payment Engine — Architectural Refactoring

**PaymentCard object removal (June–July)**
A multi-PR effort spanning ~6 weeks removing the `PaymentCard` internal type from the public API surface of the payment engine. Touched `PaymentEngine.State`, the `Tender` enum, `CompleteRequestData`, `CreatingWithServer`, `ReaderMessenger`, and multiple charge paths to decouple internal card representation from public-facing engine states.

**Retryable payment state (March)**
Added a new `retryable` `PaymentEngineState`, enabling the UI to offer retry flows on network failures instead of terminal errors. ~349 line change across 39 files. Ticket: R2-1673.

**State machine refactor (September)**
Major refactor replacing state overloading with an explicit additional state for cancel flows. Abstracted all server-handling logic into a dedicated `ServerMessenger` extension. 285 lines across 26 files.

**`PaymentManager` returns `PaymentHandle` directly (May)**
Changed `PaymentManager` to return `PaymentHandle` directly instead of via delegate, matching Android parity. Ticket: R2-1705.

**Per-`sourceId` idempotency key generation (May)**
Sweeping 38-file change introducing per-`sourceId` idempotency key generation. Ticket: R2-1758.

**Disable swipes feature (February)**
Added `PaymentParameters` support to disable receiving swipes during a checkout flow, with comprehensive test coverage across `ReaderMessenger`, `PaymentEngine`, and `PaymentEngineState`. Ticket: ~350 line change.

**Buyer/Seller locale selection (May–July)**
Added API-level locale selection allowing separate buyer and seller locales in `PaymentParameters`. Migrated locale logic into `ScreenDataPresenter`. A large ~596-line addition. Tickets: R2-1825.

**S3 Stand Switch Support (April)**
Added handling for the new S3 stand hardware switch event, including `ReaderCodeName` additions and network bridge changes. Ticket: R2-1686.

**Reader timeout fix (September)**
Fixed a critical bug where reader disconnection timeouts could cancel a running payment. Ticket: R2-1902.

---

### SquarePipes Networking Library & JWT Service

**SquarePipes networking library (November)**
Generated a new internal Objective-C networking library (`SquarePipes`) used exclusively by `R2PaymentEngine` for network calls. Included real and mock service providers, protocol definitions, and test fixture layers.

**JWT network service integration (November–December)**
Renamed `PaymentEngineNetworkService` to `JWTNetworkService`. Built the ability to call the new JWT authentication service. Fully wired the JWT network service into `PaymentEngine`, including creation of a new `R2CertificateProvider` framework (Fake, Impl, ImplWiring, Public, Testing variants). End-to-end integration across 51 files, +645 lines.

---

### Offline Payments Infrastructure (Storage Provider)

**Storage Provider introduction (August–November)**
Introduced the `StorageProvider` protocol and implementation as the foundation for offline/store-and-forward payment support. Ticket: R2-1909.

**Offline mode parameters (September)**
Added `StoreAndForward` model and offline mode params to `PaymentParameters`. Ticket: R2-1905.

**Read API for pending payments (November)**
Added read API capability to retrieve pending stored payments. Ticket: R2-1908.

---

### New Hardware & Card Type Support

**S3 Reader support (July)**
Major refactor of `R2ReaderManager`'s `ReaderObservable` to support the S3 reader. ~700 line addition including `ReaderMap`, `Incrementing`, and a decomposed `ReaderObservable` class structure.

**EncryptedMCRCard tender type (November)**
Added a new `MCRCardPaymentSource` payment source type, `EMVInputType`, and separated card present protocols. Ticket: R2-2068.

**Card brand/last4 passthrough (January)**
Passed card brand and last4 from `SQIPEntryView` through to the API, introducing `SQIPCreditCardParameters` and `SQIPGiftCardParameters` as separate classes. Ticket: R2-1482.

---

### Test Infrastructure

**Snapshot test suite (July–August)**
Added a full `FullPaymentUISnapshotTests` suite covering all major `PaymentEngine` states: approved, declined, EMV processing, creating/completing with server, retryable network error, terminal error, unrecoverable error, and waiting for card input.

**`R2PaymentEngineFakes` framework (July)**
Created a dedicated fakes module with `PaymentEngineState+Fake` and `Payment+Fake` factory helpers to streamline unit test setup across the codebase.

---

### CI & SDK Distribution

**XCFramework distribution (January)**
Migrated third-party frameworks to XCFrameworks instead of fat frameworks. Replaced old release scripts with `build_xcframework.sh`, `upload_xcframework.rb`, and `upload_xcframework.sh`.

**Symbol upload automation (March–April)**
Added `upload_symbols.rb` and `upload_symbols.sh` to automate dSYM uploads to crash reporting infrastructure.

**R1 documentation generation in CI (January)**
Built automated Jazzy doc generation into the CI build job for Reader SDK 1.

**`cocoapods-fmwk` plugin to monorepo (February)**
Brought the `cocoapods-fmwk` CocoaPods plugin — a Ruby gem + Swift post-processor for framework name-shading and Mach-O manipulation — into the monorepo. Ticket: R2-1579. One of the largest single commits of the year: 78 files, 2,695 lines.

---

### Furious8 — New Internal App

**Added to monorepo (September–November)**
Added `Furious8` — a standalone internal application at `Verticals/ReaderSDK/Furious8/` — to the monorepo. Complete UI (permissions flow, meal quantity selection, start screen, done screen with animated star view, settings), a custom `SquareReader` downloader script, and its own podspec. 57 files, 2,447 lines.

---

### Logging & Observability (Q3–Q4)

Structured logging added across the R2 SDK stack:
- Auth manager status changes via `RealAuthorizationManager+LogExtensions`
- Reader connect/disconnect events via `RealReaderManager`
- Authorization status + connected readers logged at SDK startup
- `source_os_version` added to EventStream1 log events
- All payment failures including client-side validation failures

---

<a name="2022"></a>
## 2022 — ControllerProtocol Refactor & 3DS Buyer Verification

**371 commits**

### Overview
2022's dominant theme was a 9-month systematic dismantling of a monolithic `PaymentEngineState` enum into a `ControllerProtocol`-based architecture, where each payment lifecycle state became its own encapsulated, testable controller object. Late year brought 3DS Buyer Verification and a major new shared framework.

---

### ReaderSDK 2 — ControllerProtocol Architecture Refactor (January–September)

**Module restructuring — foundation (January)**
- Removed the `R2Core` module and merged its contents into `R2V2PaymentModels`, reducing unnecessary module indirection. 178 files.
- Stubbed the new `R2PaymentEngine` Impl/Public module split. 116 files.
- Broke `R2V2Payments` into a proper `Public`, `Impl`, and `ImplWiring` layer structure. Ticket: R2-2087.

**`CreatingPaymentWithServer` state migration — template commit (February)**
Migrated `CreatingPaymentWithServer` to a dependency enum — the first major state migration and the template for all subsequent ones. 615 insertions, 467 deletions.

**`R2PaymentEngine Fake` module (February)**
Generated a full `Fake` module consolidating all mock objects (`MockReaderMessenger`, `MockScreenMessenger`, `MockServerMessenger`, etc.) into a proper testability module. 104 files changed.

**`ControllerProtocol` introduced — `WaitingForCardInput` (April)**
The pivotal commit: introduced the `ControllerProtocol` concept with `WaitingForCardInput` as the first full controller implementation. Established the architectural pattern for the rest of the year. 539 insertions, 113 deletions, 21 files.

**`AttemptingCancellation` state added and migrated (April–May)**
Added a dedicated cancellation lifecycle state with its own `ScreenData`, then migrated it to a `ControllerProtocol`. 242 insertions, 110 deletions + tests.

**Cancellation unified across all payment methods (May)**
Unified cancellation behavior across swipe, EMV, card-on-file, and manual entry into a single handler.

**`Canceled` state migrated (May/June)**
**`StoringPayment` migrated (June)** — 114 new tests
**`EMVProcessing` migrated (June)** — 312 insertions, 156 deletions, 133 new tests
**`CompletingWithServer` migrated (June)** — 96 new tests. Ticket: R2-2378.
**`ApprovedStatus` migrated (July)** — Most complex migration: 347 insertions, 221 deletions, 97 new tests. Pulled all approval logic, tip handling, and screen messaging into one place.
**`AwaitingPin` migrated (July)** — 104 new tests.
**`RetriableNetworkError` migrated (July)** — Largest single-commit refactor: 713 insertions, 900 deletions (net -200 lines), 33 files, 159 new tests.
**`Declined` migrated (August)** — 487 insertions, 324 deletions.
**`AwaitingLanguageSelection` migrated (August)** — 88 new tests. Ticket: R2-2384.
**`EMVTerminalError` migrated (August)** — 154 new tests. Ticket: R2-2387.
**`AwaitingAccountSelection` migrated (August)** — New `SelectionOption` type. Ticket: R2-2383.
**`CancelPayment` migrated (August)** — 85 new tests. Ticket: R2-2386.

**Peripheral metadata sourced in `PaymentEngine` (September)**
Centralized device data used in payment requests. Added `ConnectedPeripheral` and `ConnectionType` models. Ticket: R2-2853.

---

### Security and Encryption

**Certificate provider centralization (March)**
Centralized all Bletch public key and certificate handling into a unified `CertificateProvider`, replacing scattered key logic across `R2Encrypter`, `StorageProvider`, and `PaymentEngine`. 28 files.

**`sourceId` encryption for store-and-forward (March)**
Encrypted the `sourceId` for `SwipeCardPaymentSource` when store-and-forward is enabled, adding encryption to the reader messenger layer. Ticket: R2-2341.

**Encryption layer moved into `StorageProvider` (March)**
Moved the encryption layer entirely into `StorageProvider` and introduced the `EncryptablePaymentSource` protocol, cleanly separating encryption concerns.

**Offline mode fallback (March)**
Added support for switching to offline mode when an online payment fails in a store-and-forward scenario.

**Signature verification removed (April)**
Removed client-side signature verification entirely, delegating to the `v2/payments` server endpoint instead. Deleted a large swath of client-side signature logic. Ticket: R2-2475.

---

### In-App Payments SDK — 3D Secure Buyer Verification (October)

**3DS feature (Netcetera SDK) — major feature addition**
Merged the `iOS-3DS` feature branch adding 3D Secure buyer verification support to `SquareBuyerVerificationSDK`. Included:
- `AuthenticationManager` (454 lines)
- `ThreeDSLogger` (136 lines)
- Certificate resources for Visa/Mastercard/Amex
- `ChallengeStatusReceiver` bridging
- 1,078 lines of `AuthenticationManagerTests`
**Total: 7,430 insertions, 612 deletions across 184 files.**

---

### ReaderSDK 2 — Authentication Fixes (October–November)

**Forced logout before login (November)**
Added forced logout before login to clear any stale active sessions. 118 new tests for `AuthenticationDataProvider`. Ticket: R2-2832.

**Location ID sourcing fix (October)**
Fixed location ID to use the accurate value from `AccountStatus` rather than a potentially stale default. Ticket: R2-3020.

**`SquareAccount` migration completion (November)**
Deleted the entire `SquareAccount` migration code path — `RealAccountStatusService`, `AccountStatusNetworkClient`, and all related tests. 721 lines removed.

---

### New Shared Framework

**`SquareUIModalAdditions` framework (August)**
Extracted `UIViewController` modal presentation helpers from `SquareUIKitAdditions` into a new dedicated `SquareUIModalAdditions` framework. Updated build dependencies across 61 files.

---

### Reader SDK 1 / Furious8

**KIF integration tests re-enabled (September)**
Re-enabled KIF integration tests for ReaderSDK1 after a period of disablement. Ticket: R2-2613.

**Sample app reorganization (December)**
Reorganized all Reader SDK 1 sample apps (`Furious8`, `SampleApp`) into a shared `Apps/` subdirectory with updated CI configuration.

**`SampleBreakfastApp` removed (December)**
Deleted the unused `SampleBreakfastApp` (3,454 lines deleted).

---

<a name="2023"></a>
## 2023 — Device Profiles v2 & Settings Provider Architecture

**380 commits**

### Overview
2023's work was dominated by two major, interlocking initiatives: (1) the full design and delivery of **Device Profiles v2 (DPv2)** — a system for per-device POS configuration — and (2) a sweeping **settings-provider architecture refactor** that decomposed a monolithic `SquareAccount`/`SquareCommonSettings` approach into dozens of isolated, independently injected, reactive provider modules.

---

### Device Profiles v2 — Full Feature Delivery

**Proto updates & controller architecture (March)**
Updated client-side code to use new Device Profile protos. Added `DeviceProfileType` directly to `DeviceProfileController`, reducing the surface area callers need to track.

**`DeviceProfileMigrator` module (April)**
Created the entire `DeviceProfileMigrator` module from scratch (~891 line insertion). Per-vertical migrators for APOS, Retail, and SPOS; ImplWiring factories; data source adapters for every settings type (Cash Management, Security, Signature, Store & Forward, Order Tickets, Text Message Marketing); full unit tests; and `DeviceProfileMigratorWiringFactory`. The backbone for migrating existing device settings into the new profile system.

**Fakes layer for all device profile models (May)**
Generated fakes for every `SquareDeviceProfile` model (payment types, quick amounts, loyalty, security, signature, store & forward, tipping, SPOS settings, customer management, etc.). 37 files. Enabled reliable unit testing throughout.

**Demo App for `SquareDeviceProfilesUI` (May)**
Added a dedicated demo app to iterate on UI independently of the full app stack.

**`DeviceProfileSettingsAssignButtonWorkflow` (June)**
Built the interactive workflow letting users assign a device profile from within the Settings app. 42-file change. Wired into SPOS, Appointments, Invoices, Retail, and Restaurant.

**Animation jitter fix in assignment workflow (July)**
Introduced a `DeviceProfileSetupScreen`, `DeviceProfileSelectionNavigationItem`, and split loading/selection/linking into clean sub-workflows, eliminating jitter during loading transitions.

**Device Profile Management Banners (August)**
Added banners to Tipping, Store & Forward, Signature, Customer Management, Payments, Order Tickets, Quick Amounts, and Offline Mode screens informing users that settings are managed by a Device Profile. Multiple PRs across all affected screens.

**SearchDeviceProfiles API (September)**
Replaced `ReadDeviceProfilesMetadata` API with the new `SearchDeviceProfiles` API end-to-end. Added full request/response model, updated `SquarePipesBridge`, and added mock/stub coverage.

**Profile selection workflow refactor (September)**
Collapsed a separate `DeviceProfilesLoadingWorkflow` into the selection flow. 1,002-line test expansion.

**`DeviceProfileElementModelProtocol` (September)**
Decoupled the assignment workflow from concrete UI rendering.

**Engineering metrics / analytics (September–October)**
Logged Device Profile settings changes; added client-side success events; added device identifier to CDP events.

**Remove `AddOnEnablementWatcher` (October)**
Removed the `AddOnEnablementWatcher` subsystem in favor of each `AddOnDescribing` provider returning a reactive signal directly. 81 files, -483/+413 lines. Significant architectural cleanup.

**`DeviceProfileControllerStateAdapter` integration (October)**
Integrated state adapter into Team Management and Quick Amounts providers.

**Full GA feature flag (November)**
Added the Full GA feature flag for Device Profiles general availability launch. Wired into `DeviceProfileController`, `SQSquareAccount`, and the banner container workflow.

**Fallback provider pattern for `SecuritySettings` (November)**
Moved `SecuritySettings` to a fallback provider pattern. 49-file change.

**Settings provider injection into individual providers (December)**
Migrated all settings providers (RST and non-RST: OrderTickets, Signature, Loyalty, StoreAndForward, Tipping) to use the `AccountProvider` injection pattern. 120+ files. Deleted redundant `SettingsProviderContainer` infrastructure.

---

### Settings Provider Architecture — Modularization

**`SquareOpenTicketsSettings` module (January)**
Created from scratch (401 lines) — Public/Impl/ImplWiring/Fake layers — and wired into all four app verticals to prevent Open Tickets from showing when the add-on is uninstalled.

**Online Checkout Settings Provider (January)**
Added `OnlineCheckoutSettingsProvider` with enable/disable support and full test coverage.

**TextMessageMarketing settings provider refactor (February)**
Migrated `TextMessageMarketing` settings reads from `SquareAccount` to a dedicated `TextMessageSettingsProvider`. Restructured into a properly layered module with `Program`, `ProgramControlling`, `SettingsProviding`, and `AccountDatasource` protocols. 42 files.

**`SettingsProviderContainer` test suite (March)**
Added comprehensive tests ensuring downstream provider wiring is correct. 877-line test addition.

**New settings modules extracted (March–April)**
Moved `SquareOnlineSettingsProvider`, `TextMessageMarketingSettingsProvider`, `TippingSettings`, `StoreAndForwardSettings`, `OrderTicketsSettings`, `SecuritySettings`, and `SignatureSettings` each into their own standalone modules (each with Public/Impl/ImplWiring/Fake/OWNERS/README structure).

**`SquareAccount` decoupled from `SquareCommonSettings` (April)**
60-file change removing direct coupling between `SquareAccount` and `SquareCommonSettings`.

**Add-on enablement checks migrated (October)**
Migrated all add-on enablement checks from `AddOnDescribing` to reading directly from the relevant settings provider. Removed 95 lines of tests testing the wrong abstraction. 39 files.

**`AccountProvider` pattern completion (December)**
Completed migration of Team Management, Payment Types, Customer Management, Loyalty, Text Message Marketing providers — replacing `SquareAccount` direct reads with properly injected data sources. 79 files.

---

### Notable Bug Fixes

- Fixed crash when accessing Open Tickets on iPhone (March, RI-43459)
- Fixed Open Tickets Settings becoming unresponsive due to stale adapter reference (February)
- Fixed `show_receipt_screen` and `signatureSettingsSkipReceiptScreen` being inverted (December)
- Fixed incorrect quick amounts object being applied (December)
- Fixed Store & Forward enablement value being sent incorrectly (December)

---

<a name="2024"></a>
## 2024 — SuperPOS Modes Platform & Singleton Elimination

**471 commits**

### Overview
2024 was highly productive, focused on two overarching themes: (1) building the **SuperPOS / Modes architecture** enabling multi-mode POS switching on a single device without re-authentication, and (2) a sustained **DI / singleton elimination campaign** across settings providers.

---

### Device Profiles v2 — Hardening & Mintification (Q1)

**Mintify `DeviceProfileController` (January)**
Converted `DeviceProfileController` from a wiring-factory pattern to the Mint DI pattern. Removed `DeviceProfilesDataService`, `DeviceProfilesServiceWiringFactory`, and `DevicesProfilesDependencyContainerMintDependencies`. Touched every vertical: APOS, Kiosk, Invoices, Restaurant, Retail, SPOS. Ticket: #97888.

**Auto-generate `+Diffable` Swift extensions from protos (January)**
Created a Kotlin-based Bazel code generator (`SettingsUpdateTrackerGenSchemaHandlerFactory.kt`) that auto-generates `+Diffable` Swift extensions from protos, eliminating ~200 lines of hand-written differ code across all verticals. Ticket: #98578.

**Integrate UnifiedLogging / Datadog (January)**
Wired Datadog log access into DeviceProfiles analytics, substantially expanding the logging coverage of settings events.

**DPv2 GA cleanup (March)**
Cleaned up dead code and flags from DPv2 GA. Removed `TestDeviceProfileController` and state adapter fallback paths. Multiple PRs.

**`UserAgentProvider` framework (January–February)**
Created a new `SquareUserAgent` framework with `UserAgentProvider`, `UserAgentProviderFake`, and `UserAgentProviderMint`, allowing in-memory user agent updates without relying on a static global. Wired into `SquareEventLogging`, `SquarePipes`, `SquareCheckoutFlow`, and ~50 files. Ticket: #99817.

---

### SuperPOS / Modes — Core Platform Build-out (April–September)

**`GatekeeperHandlerProtocol` (April)**
Introduced a new protocol that inverts the business logic of sign-out gating. Instead of hardcoding cases in a central `SignoutGatekeeperWorkflow`, individual features can now inject their own `Keeper` objects. Ticket: #103201.

**`CFBundleIdentifier` linter rule (April)**
Added a `.squinter/regex.yml` rule to enforce use of engine-specific bundle IDs rather than `mainBundle.bundleIdentifier`, which would return the wrong bundle ID during mode switching. Ticket: #102811.

**Signout Gatekeeper extended for mode switches (April)**
Extended to block mode switches when unsafe, introducing `SignOutGatekeeperIntent`. Ticket: #102712.

**`ModesController` public API stub (April)**
First major stub of the `ModesController` public API — the central stateful object for mode management. Ticket: #104918.

**Shared state machine via generics (May)**
Used Swift generics to share state machine logic between `DeviceProfileController` and the new `ModesController`, eliminating duplicate state management code. Ticket: #105130.

**`DeviceProfileIDClientInterceptor` (May)**
Created a network client interceptor appending `X-Device-Profile-ID` to every request header. Required for Add-on Library enablement and SuperPOS. Included unit + E2E tests with screenshots. Ticket: #104891.

**`DeviceSettingsContainer` — unified DPC and Modes (May)**
Created a unified container holding both `ModesController` and `DeviceProfileController`, introduced via a new Mint, removing per-vertical wiring of these objects. Tickets: #105377, #105376.

**`ModeManagementNetworkService` (May)**
Built the full network layer for Modes — `FetchModeForDeviceRequest`, `SetModeForDevice`, `UpdateModeForDevice` — bridging the Modes proto model to SquarePipes network calls. Ticket: #105666.

**Real production API calls for Modes (May)**
Replaced stub/fake network calls with real production API calls. Tickets: #105978, #106186.

**Action-based architecture with file persistence (May)**
Built the action-based architecture for managing state transitions safely across both device profiles and modes, with file-based persistence. Tickets: #106062, #106246, #106254.

**`ReactiveLogin` Mintified (June)**
Extracted `ReactiveLogin` into its own Mint so `ModesController` can trigger re-authentication during a mode switch without coupling to a specific vertical. Created `ReactiveLoginFake`, `ReactiveLoginMintImpl`. Ticket: #107121.

**Re-auth on mode switches using device code (June)**
Implemented behind-the-scenes re-authentication on mode switches using a device code credential flow. Ticket: #107228.

**`DeviceSettingsUpdateManager` (June)**
Constructed the `DeviceSettingsUpdateManager` and associated test infrastructure. Ticket: #107834.

**`LoggedInInterceptor` abstraction (June)**
Introduced an abstraction allowing interceptors to be automatically added/removed on login/logout, enabling clean allocation/deallocation of per-session network state. Ticket: #108259.

**Device Profile Preloader + postload workflow (July)**
Built `DeviceProfilePostLoadUIWorkflow` and `DeviceProfilePreloader` — a blocking UI shown at launch ensuring device profile is loaded before the app proceeds. Critical for preventing stale-state first-use. Ticket: #108497.

**`DeviceSettingsContainer` moved to LoggedIn scope (July)**
Migrated from the app-level container to the logged-in scope, enabling proper deallocation/reallocation on login/logout. Architectural milestone enabling SuperPOS to switch modes cleanly. Included an inline screen-recorded demo in the PR. Ticket: #108319.

**Unified update/fetch pipeline (July)**
Major refactor pushing all DeviceProfile network requests through a single unified `SignalProducer` stream shared by both `FetchManager` and `UpdateManager`. Split `DeviceProfileController.swift` into `+Fetch` and `+Update` extensions. Ticket: #109903.

**Full Mode update requests (July)**
Completed the update path for Modes — sending full `CachedMode` update objects over the network. Ticket: #109238.

**Stale detection on init from persistence (August)**
Solved a mode-switch issue where freshly-allocated containers incorrectly considered themselves stale, triggering unnecessary network fetches. Reads last-persisted timestamp from disk at init. Ticket: #110675.

**Action serialization / request queue (August–September)**
Introduced `DeviceSettingsActionManagerActions` enum to serialize fetch and update actions, preventing concurrent conflicting requests. Global `mode_id` tracking registered to all ES1/ES2 events. Tickets: #111275, #111754, #112727.

---

### Settings Applet — Mintification & Cleanup (September–October)

**Minted settings applet builder (September)**
Removed legacy wiring factories from the Settings Applet in favor of the Mint-based builder. Tickets: #112474, #112477, #112500.

**Prevent auto-fetching until Preloaders call `fetch()` (October)**
Changed `DeviceSettingsContainer` to not auto-fetch on init/account change, requiring the `Preloader` to explicitly call `fetch()`. Prevents double-fetches at login. Ticket: #114375.

**Merchant Token ownership enforcement at init time (October)**
Fixed a Kiosk-specific bug where device profiles weren't persisted correctly on second launch due to scope differences between Kiosk and other verticals. Ticket: #114481.

---

### Settings Provider DI Campaign — Eliminating Singletons (Q4)

**`LegacyDeviceSettingsProviderLifecycleManager` (November)**
Created to force-initialize certain settings providers early in the app lifecycle, solving initialization ordering bugs during singleton migration. Ticket: #116175.

**`SettingsProvidingCheckoutContainer` (November)**
Created a single injectable container bundling all settings providers needed by checkout flow, replacing one-by-one injection which caused ripple changes. Ticket: #116383.

**Customer Management Settings moved out of `SquareAccount` (November)**
Removed `customerManagementSettingsProvider` from `SQSquareAccount` (~280 lines ObjC + 141 lines of tests deleted), replacing with DI. Tickets: #116094, #116534.

**`EmployeeServiceMint` and `ItemsServiceMint` extracted (November)**
Extracted from the monolithic `APPLoggedInDataServiceProvider`, significantly reducing it. Ticket: #116691.

**`HardwareServiceMint` extracted (November)**
Created `HardwareServiceMint`, moving hardware service out of `APPDataServicesMint`. Ticket: #116955.

**TMM Singleton removed (November)**
Removed `TextMessageMarketingSettingsProviderSingleton` entirely, replacing with direct DI into checkout flow. Ticket: #117040.

**Legacy Signature Settings Singleton removed (December)**
Deleted `LegacySignatureSettingsProviderSingleton`, `SQPrintingSettings+SignatureSettings`, and `SQSquareAccount+SignatureSettings`. Replaced with direct provider injection. Ticket: #117195.

**Security Settings ObjC → Swift migration (December)**
Moved security settings computations out of `SQEmployeeManagementSettings` (collapsing ~500 lines ObjC) into a new Swift `SecuritySettingsProvider`. Added ~200 lines of new tests. Ticket: #118148.

**`KioskTeamSettingsProvider` introduced (December)**
Simplified settings provider injection pattern across 40+ dev-apps and modules. Ticket: #118159.

---

### Integration Test Work (May, August, December)

- Added `CashManagementIntegrationKIFIntegrationTests` for both Appointments and Retail verticals
- Re-enabled Kiosk KIF tests after Device Profile initialization race condition fixes
- Stabilized flaky Kiosk KIF tests from race conditions with Device Profile initialization

---

<a name="2025"></a>
## 2025 — Cash Management Rewrite & DPv2 Rollout

**448 commits**

### Overview
2025's overwhelming focus was a from-scratch **Cash Management architectural rewrite** — creating a new `CashManagementUI` framework, separating UI from data concerns, migrating from ReactiveSwift to async/await, building a dual-coordinator persistence architecture for zero-data-loss Sync Hub migration, implementing GRDB-based local persistence, and migrating tests from KIF to XCUITest. Alongside this, the year saw Device Profiles v2 fully rolled out across all verticals, and a Market Tab Bar rewrite.

---

### Device Profiles v2 — Completion & Rollout (January–June)

**Performance fix — app hang prevention (January)**
Every network request was hitting `deviceProfileController.state` — a `MutableProperty` guarded by ReactiveSwift thread locks — on every call, exhausting the thread pool under load. Resolved by memoizing `deviceProfileID` and `modeId` into `DeviceSettingsContainerClientInterceptor` once at allocation time. Targeted a Bugsnag-reported production app hang. Ticket: b5e9e7af.

**Security Settings DI overhaul (January)**
Removed the back-injection pattern of `SecuritySettingsProvider` into `SquareAccount` across 208 files. The single largest architectural cleanup PR of Q1.

**DPv2 enabled for all verticals (January–March)**
- Enabled DPv2 for Invoices (January)
- Enabled DPv2 for APOS (January)
- Enabled DPv2 migration for RST (February)
- Enabled DPv2 by default in development (February)

**Remove Valet from SquareAccount (April)**
Replaced Valet (Keychain wrapper library) with UserDefaults across `SecuritySettingsAccountDataSource` and `TeamBadgesAccountSettings`. Valet was unnecessary overhead since device-level encryption was sufficient.

**Settings provider DPv2 fallback removals (June)**
Removed DPv2 fallback branches from floor plan, security, kiosk, loyalty, FulfillmentType, and `shouldUseDeviceProfiles` — completing the rollout. DPv2 was now fully ramped.

**Signal producer refactor for Fetch/Update managers (April)**
Large refactor of `DeviceSettingsFetchManager` and `DeviceSettingsUpdateManager` into separate `SignalProducerProvider` types, reducing duplication across ~740 lines changed. Ticket: #4b8b9da.

---

### KIF Testing Infrastructure — Swift Migration (January–March)

**Swiftify `SquareAccount/KIFTesting` (January)**
Full 1:1 rewrite of `RKTAccount.m` + `RKTAccountSettingsRobot.m` + `RKTConstants.m` from Obj-C into Swift. ~1,106 lines added, ~1,893 lines deleted across 60 files.

**Device Profile KIF Robots extracted (February)**
Extracted `SecuritySettingsProviderRobot`, `SignatureSettingsProviderRobot`, `SquareCustomerManagementSettingsRobot`, and `StoreAndForwardSettingsRobot` into their own `KIFTesting` modules, decoupling DPv2 test helpers from the monolithic SquareAccount robot.

---

### Applet Switcher / Market Tab Bar Rewrite (May–December)

**Replace `TabbarScreen` with Market Tab Bar Container (May)**
Feature-flagged (`applet-market-tab-bar`) introduction of `AnyMarketTabBarContainer`. Introduced `AppletOverflowBuilder` for applets that aren't rendered in the tab bar. 456 lines added, 103 deleted across 33 files.

**Performance tracing (May)**
Instrumented raw render times for both old and new implementations. Measured: new tab bar ~102ms initial render vs 82ms legacy, but subsequent renders <2ms vs 14–46ms legacy.

**`AppletSwitcherRefreshDelegate` centralization (December)**
Added a centralized `AppletSwitcherRefreshDelegate` protocol and consolidated mock implementations across 35 files.

---

### MicJIT Gatekeeper (May–June)

**MicJIT gatekeeper (June)**
Added `MicJITGatekeeper.swift` (221 lines) that intelligently decides whether to prompt for microphone access based on the type of card reader connected. R12 readers don't need mic access. Prevents the mic permission prompt from appearing when unnecessary, reducing seller friction. 635 lines across 26 files, 154-line test class.

---

### Cash Management — Major Rewrite & Sync Hub Migration (August–December)

This was the largest body of work of the year — a complete ground-up rebuild of Cash Management's architecture.

**Phase 1: Data Layer Foundation (August–September)**
- Introduced `CashManagementDataStoreType` enum, cleanly abstracting in-memory vs on-disk Core Data stores
- Introduced type-safe `CashManagementFilterObject` for shift queries
- Added `OpeningDeviceInfo` to `CashDrawerShift` init to capture device identity at shift creation
- Added a callback to notify when `CashDrawerShift` successfully syncs

**Phase 2: Architectural Refactoring (October)**
- **New `CashManagementUI` framework created** — Decoupled UI workflows from the data layer `CashManagement/` framework
- **Model types promoted to `Public` module** — `CashDrawerShift`, `CashDrawerShiftEvent`, `DeviceInfo`, `EmployeeInfo` promoted from `Impl` to `Public`, enabling downstream consumers without implementation coupling
- **`CashManagementControlling` API consolidated** — Major refactor: 1,025 lines added, 860 lines deleted across 78 files. Cleaned up duplicate mocks and updated snapshot tests
- **Workflows fully abstracted into `CashManagementUI`** — Moved all workflow source files out of `CashManagement/Impl` into `CashManagementUI/Impl`. 417 files changed
- **Dual-coordinator architecture introduced** — `CashDrawerShiftPersistenceCoordinator` and `CashDrawerShiftFetchCoordinator` with a dual-coordinator pattern keeping Core Data always active for zero-data-loss rollback safety. 713 lines added, 349 deleted. Includes detailed `COORDINATOR_DESIGN.md`
- **Remote Cash Drawer Closure built** — Full workflow for responding to an RDM push closing a cash drawer: `RemoteCashDrawerClosureWorkflow`, `RemoteCashDrawerClosureScreen`, `RemoteCashDrawerClosureGatekeeper`. 953 lines added
- **Factory pattern rollout** — Replaced direct workflow instantiation with factory-based creation across all cash management workflows. 473 lines added

**Phase 3: Async/Await Migration (November)**
- Migrated all four major workers to async/await: `GetCurrentCashDrawerShiftsWorker`, `GetOtherDrawerShiftsWorker`, `CreateCashDrawerShiftWorker`, `GetCashDrawerShiftHistoryWorker`
- Removed the last ReactiveSwift usages from `Frameworks/CashManagement`. 296 lines added, 594 lines deleted (net -300 lines). Significant simplification of `SquarePipesBridge`

**Phase 4: Sync Hub Integration (November)**
- **Sync Hub Commands implemented** — `CreateShiftCashDrawerCommand`, `EndShiftCashDrawerCommand`, `CloseShiftCashDrawerCommand`, `AddShiftEventCashDrawerCommand`, `UpdateShiftDescriptionCashDrawerCommand`. 1,056 lines added, 99 deleted. 6 new test files
- **`MockSyncHubRepository` built** — GRDB abstractions for test verification
- **Migrated to canonical Sync Hub proto types** — 337 lines added, 151 deleted

**Phase 5: GRDB Persistence Layer (December)**
- **GRDB schema for `CashDrawerShift`** — Table schema, `CashDrawerMigrations`, and full persistence model for `CashDrawerShift` and `CashDrawerShiftEvent`. Added `SQMoney+GRDB.swift` to `GRDBFoundation`. 1,135 lines across 20 files, 3 new test files
- **Combine publisher for reactive shift observation** — `CashDrawerShiftQuerying` protocol with Combine-based publisher. 234 lines

**Phase 6: Test Infrastructure (December)**
- **Migrated all KIF-based Cash Management tests to XCUITest** — Added `CashManagementXCUITests.swift` and a full `XCUITesting` module with screen robots. 539 lines added, 103 deleted
- **Sync Hub UI tests enabled**

---

### Developer Tooling — AI Rules and Claude Commands (November)

**Cascading merge conflict resolver slash command (November)**
Created `.claude/commands/resolve-cascading-merge.md` (210 lines) — a Claude agent instruction file automating the repetitive process of resolving cascading merge conflict chains in the monorepo.

**Test sleep avoidance AI rule (November)**
Added AI rule files across multiple agent formats plus `squinter` regex patterns to prevent AI assistants from generating `Task.sleep` in tests, teaching correct async testing patterns using `await`.

---

<a name="2026"></a>
## 2026 — ReportsAppletV2 & SecuritySettings Refactor

**78 commits (January–February)**

### Overview
Despite being only two months in, 2026 already contains a major new cross-cutting framework, a significant architectural refactor affecting 63 files, multiple production bug fixes in Cash Management, and a full migration of all five report types to the new framework.

---

### ReportsAppletV2 — New Framework & Full Migration

**Core `ReportsAppletV2` framework built from scratch (Early February)**
Built the entire `ReportsAppletV2` framework:
- `ReportWorkflowProviding` protocol — contract each individual report must conform to
- `ReportsAppletV2RootWorkflow` — orchestrates the reports list
- `ReportsListView`/`ReportsListScreen` — SwiftUI-based reports list UI
- `ReportsAppletV2WorkflowBuilder` — registry aggregating all registered reports
- Standalone development app for isolated iteration
- Full `Fake` and `Public` modules for testability
- README and business-rationale doc

~1,191 lines of new code. Ticket: #143763.

**Foundational capabilities added (February 10)**
Three capabilities layered immediately after core framework:
- **Passcode protection** — Per-report passcode realm configuration in `ReportMetadata`; new `awaitingPasscode` state in root workflow state machine
- **Badge and visibility support** — `badgeCount` and `visibility` on `ReportWorkflowProviding`; `ReportsBadgeWorkflow`, `ReportBadgeCountWorker`, `ReportVisibilityWorker` for reactive badge aggregation and filtering
- **Deep linking** — `makeWorkflow` accepts a deep link parameter; `ReportsAppletV2WorkflowBuilder` implements `AppletDeepLinkProvider`; allows navigating directly to specific reports from anywhere in the app

**Wired into all VPOS apps with feature flag (February 11)**
Connected to `APPLoggedInMintContainer` and wired into all five vertical apps — SPOS, APOS (Appointments), IPOS (Invoices), Restaurant POS, and Retail — via their respective `LoggedInMintContainer`. Added `ReportsAppletV2FeatureFlags` to gate the rollout. Ticket: #144588.

**Cash Management Reports — first migration (Early February)**
Introduced `CashManagementCurrentDrawerReportsFactoryImpl` and `CashManagementDrawerHistoryReportsFactoryImpl` in `CashManagementUI`, each with Mint wiring and deep link support. First actual report migrated to the new applet. Ticket: RCP-83 area.

**Referral banner ported (February 17)**
Built a new `ReferralBannerView` in MarketSwiftUI, a `ReferralBannerActions` struct replacing legacy ObjC protocol, wired through the root workflow state. Ticket: RCP-86.

**Sales Report factory abstraction (February 20)**
Introduced `SalesReportViewControllerFactory` protocol in `SquareSalesReports` to decouple concrete VC construction from `ReportsAppletImpl`. Concrete implementation moved to wiring layer, reducing `ReportsAppletImpl`'s dependency surface by ~8 raw dependencies. Added `MockSalesReportViewControllerFactory` in a new Testing module. Ticket: RCP-82/RCP-139.

**Loyalty VC module reorganization (February 13)**
Moved 10 Obj-C source files, 1 test file, a `CalendarGlyph` asset, and 27 localized string entries (across 12 locales) from `ReportsAppletImpl` into `SquareLoyaltyUILegacy`. Prerequisite for the loyalty migration. Ticket: RCP-84 area.

**All five report types migrated to `ReportsAppletV2`:**

| Report | Ticket | Approach |
|---|---|---|
| Gift Cards Report | RCP-83 | Adapter workflow wrapping existing `GiftCardReportingWorkflow` |
| Loyalty Report | RCP-84 | `LegacyViewControllerScreen` bridge for ObjC `SQRALoyaltyReportViewController` |
| Payment Disputes | RCP-85 | `LegacyViewControllerScreen` bridge; full workflow stack with list + detail |
| Sales Report | RCP-82/RCP-139 | Adapter workflow wrapping `SalesReportContainerWorkflow`; share sheet and compare signals |
| Cash Management | RCP area | Factory implementations for current drawer and drawer history |

**Cash Drawer reactive visibility fix (February 26)**
Made cash drawer visibility fully reactive. Previously evaluated once at init and never updated. Added `isAddOnInstalledProperty: Property<Bool>` to `CashManagementSettingsProviding` and a new extension handling two cases: current drawer and drawer history, both gating correctly on add-on install state. Ticket: #146874.

---

### SecuritySettings Protocol Refactor (February 9)

**Split `SecuritySettingsProvider` into three distinct protocols (63 files)**
Solved a real API confusion problem: the existing `SecuritySettingsProvider` conflated computed (capability-gated) values with raw stored values under the same property name (confusing `raw*` prefix). The fix:
- `SecuritySettingsProvider` — read-only, computed values (capability-gated, no setters)
- `SecuritySettingsStorage` — direct storage access with `stored*` naming prefix
- `SecuritySettingsController: SecuritySettingsProvider & SecuritySettingsStorage` — combined interface for settings UI

Added `SecuritySettingsStorageFake` and `SecuritySettingsControllerFake` for test doubles. Updated all consumers across SPOS, APOS, IPOS, Retail, Restaurant, Kiosk, and Timecards. Ticket: #143424.

---

### Cash Management — SyncHub Stabilization (January–February)

**Explicit Close/End Drawer Sync (January 21)**
Replaced the previous "inspect previous state" pattern with three explicit protocol methods: `shiftEnded(_:)`, `shiftClosed(_:)`, `shiftEndedAndClosed(_:)`. Introduced a new `EndAndCloseShiftCashDrawerCommand` SyncHub command for combined end+close. Ticket: #141620.

**Proto conversion audit and bug fixes (January 27)**
Audited all proto conversions in Cash Management (oncall ONCALL-308673). Found and fixed two silent data-loss bugs:
- `CashDrawerShiftEvent.toProto()` was omitting the `employee` field
- `CashDrawerShift.toProto()` was omitting `endingDeviceInfo` and `closingDeviceInfo`

Added four new round-trip test files. Ticket: #142575.

**Core Data double-emission fix (February 10)**
Fixed a production bug (ONCALL-311434) where `currentShiftPublisher` emitted twice per sync because `clear → insert → save` were in separate `performAndWait` blocks. Solution: `clearAndReplace(with:)` batches all three operations into a single block. Also added `receive(on: DispatchQueue.main)` to relevant publishers. Ticket: #144512.

**Remote drawer closure feature removed (January 26)**
Deleted ~1,685 lines of dead code: the entire `RemoteCashDrawerClosure` RDM Action feature that was abandoned and not going to ramp. Ticket: #142391.

---

### SyncHub Testing Infrastructure (January–February)

**XCUI tests for SyncHub path (January)**
Re-enabled and expanded XCUI tests for the SyncHub path in the Cash Management demo app. Added `CashManagementSyncHubXCUITests` suite with supporting robots. Ticket: #140936.

**KIF integration tests for SyncHub across four verticals (February)**
721 lines of new KIF integration test coverage for the SyncHub path across general, Invoices, Retail, and Restaurant verticals. Ticket: #143227.

---

### Echo / Remote Debugging — AnyMessage Decoding (February 12)

**`google.protobuf.Any` fields decoded in Echo (February)**
`AnyMessage` fields previously appeared as opaque base64 blobs in the SyncHub network inspector. Introduced `WireAnyMessageTypeProvider` protocol and `WireAnyMessageTypeRegistry` that registers type decoders, recursively resolving `@type`/`value` pairs into human-readable JSON. Registered 11 types across CashManagement (8), KDS (2), and CLS (1). Ticket: #144786.

---

### AI Tooling

**`/describe-pr` slash command (February 19)**
Added a new `/describe-pr` AI command that generates or updates PR descriptions based on the repo's PR template. Updated the `pull-request-etiquette` skill. Switched PR body updates to use `--body-file` to avoid shell escaping issues. Ticket: MAIT-8.

---

## Cross-Cutting Themes Across All Years

| Theme | Years Active |
|---|---|
| Reader SDK v2 (Swift) — built from scratch, external SDK | 2019–2022 |
| In-App Payments SDK (SQIP) — modularization and distribution | 2020–2021 |
| PaymentEngine architecture — from monolithic to ControllerProtocol | 2021–2022 |
| 3DS Buyer Verification | 2022 |
| Device Profiles v2 — design, build, rollout | 2023–2025 |
| Settings Provider modularization — decoupling SquareAccount | 2023–2025 |
| SuperPOS / Modes platform | 2024 |
| Cash Management rewrite + Sync Hub migration | 2025–2026 |
| ReportsAppletV2 | 2026 |
| Singleton / global state elimination (Mint DI) | 2024–2025 |
| SDK distribution pipeline (XCFramework, Jazzy docs, CI) | 2019–2021 |
| Developer tooling (AI rules, Claude commands) | 2025–2026 |



