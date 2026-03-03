## System Design Lite for iOS

---

### Why this matters in interviews

- TL interviews often include **system design** or “app architecture” rounds.
- As an iOS TL, you’re expected to bridge **mobile and backend** concerns, even if you’re not the backend owner.
- At senior/staff levels, you are also expected to **shape cross‑team APIs, reliability posture, and long‑term evolution** of mobile + backend systems, not just your app’s internals.

---

### Core concepts

- **Client–server boundaries**
  - Mobile apps talk to backend APIs over HTTP/HTTPS or WebSockets.
  - Clear contracts: request/response shapes, auth, error codes.
- **Offline‑first considerations**
  - Local persistence (e.g., Core Data, SQLite, Realm).
  - Sync strategies (last‑write wins, conflict resolution).
- **Feature flags and configuration**
  - Remote config to control rollout without app releases.
- **Modularization**
  - Split app into **feature modules** with clear responsibilities.
  - Shared core modules for networking, analytics, and design system.

---

### Talking about a hotel booking system (lite)

When asked to “design a hotel booking system”, cover:

- **Backend components (at a high level)**
  - Search service (filter hotels by location, dates, price).
  - Booking service (create/modify/cancel reservations).
  - Inventory service (keeps room availability accurate).
  - Payments and notifications.
- **iOS app responsibilities**
  - Present search UI, results, details, and booking flows.
  - Cache recent searches and bookings locally.
  - Handle network failures gracefully with retries and user messaging.

Key iOS TL talking points:

- You’d define **clear APIs** with backend teams for search, availability checks, and bookings.
- You’d design the app to keep **local state** (e.g., current cart/booking) resilient to transient network issues.

---

### Interview Q&A

- **Q: How would you design the iOS architecture for a hotel booking app?**  
  **A:** Use a modular SwiftUI app with feature modules (Search, Details, Booking, Profile). Each feature has MVVM + services. Shared networking and session modules handle auth and global concerns. Navigation is orchestrated by a coordinator/root to manage flows.

- **Q: How do you handle offline mode?**  
  **A:** Cache recent searches and bookings locally, show last known data when offline, queue non‑critical writes for later where appropriate, and clearly communicate to users when actions can’t be completed until network returns.

- **Q: How do you plan for scalability and change?**  
  **A:** Keep **API contracts** versioned and stable, design view models and services with protocols for swapping implementations, and modularize code so adding new flows (e.g., loyalty program) doesn’t tangle with existing ones.

- **Q: What responsibilities does a staff iOS engineer have in system design discussions?**  
  **A:** Define and socialize patterns for mobile–backend boundaries, push for observability and clear SLAs, anticipate future product directions, and ensure the architecture lets multiple teams move quickly without compromising reliability.

---

### Practice prompts

- Walk through, at a whiteboard, how your iOS app would integrate with a hotel booking backend: key endpoints, flows, and error cases.
- Describe how you’d roll out a new booking feature to 10% of users using feature flags and remote config.
- Explain how you’d structure caching (in‑memory vs persistent) for search results and user bookings.
 - Describe how you would lead a cross‑team design review for a new major feature touching iOS, Android, and backend, and how you’d reflect that in the iOS architecture.
 - Walk through how you’d improve reliability of an existing app that frequently times out on search requests (what you’d measure, what design or UX changes you’d propose).

