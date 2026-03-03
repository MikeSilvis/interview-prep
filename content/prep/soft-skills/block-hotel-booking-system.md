# Block Architecture Interview — Design a Hotel Booking System

This file is a **shared architecture interview template** for a common Block-style question.

- **Use this as an interviewer guide or study outline.**
- Do **not** add your own personalized answers here.
- If you want to write out a full take-home answer, do that in `users/<your-name>/architecture/` or a similar per-user path.

---

## Prompt

> In this interview, we'll focus on your **system design and architectural thinking**.  
>  
> **Question:** Design a **hotel booking system** that lets customers search for hotels and book rooms for specific dates.  
>  
> Assume this is a production system that real customers and hotels rely on (think: high traffic, real money, and lots of edge cases).

**Clarifying questions to expect / encourage:**
- **Business scope:** Single hotel chain vs. aggregator (many independent hotels)?
- **Inventory granularity:** Do we track **room types only** (e.g. "King, Non-smoking") or **individual rooms**?
- **Channel scope:** Web + mobile apps only, or also third-party channels (e.g. OTAs, partners)?
- **Payments:** Do we process payments ourselves or via a payment provider (card-on-file, refunds, partial payments)?
- **Consistency requirement:** Is it acceptable if search results are slightly stale, as long as the **actual booking** is strongly consistent?

---

## Core Requirements

**Functional:**
- **Search** for hotels by location, dates, number of guests, and basic filters (price range, rating, amenities).
- **View availability & pricing** for each hotel / room type for the selected dates.
- **Create a booking** (reserve room(s) for a date range and guest details).
- **Prevent double-booking** of the same room (or overselling a room type).
- **Cancel / modify bookings** within business rules.
- **Notifications** (email/SMS/push) on booking confirmation, changes, and cancellations.

**Non-functional:**
- **High availability:** downtime directly impacts revenue.
- **Search latency:** keep search responses low-latency (e.g. \< 200 ms p95 for typical queries).
- **Scalability:** handle a **read-heavy ratio** (search) vs. **write-light** (actual bookings).
- **Data integrity:** strong consistency for the **booking transaction** itself.
- **Observability:** logs/metrics/traces to debug failed or partial bookings.

---

## High-Level Architecture Discussion

Encourage the candidate to start from a **simple monolith** and then factor out services as scale/complexity emerges.

**Key components to expect:**
- **API Gateway / BFF** for web & mobile clients.
- **Search service** for querying hotels, availability, and pricing.
- **Inventory service** owning room/room-type availability and calendar state.
- **Booking service** orchestrating holds, confirmations, cancellations.
- **Payment service integration** (often delegated to an external provider).
- **Notification service** (email/SMS/push).
- **Data stores:**
  - A **relational DB** for bookings and core hotel data.
  - A **search index** (e.g. Elasticsearch/OpenSearch) for search & filtering.
  - **Caching layer** (e.g. Redis) for hot availability/pricing data.

Depth prompts:
- When/why would you **split search from booking**?
- Where do you need **strong consistency** vs. where is **eventual consistency** OK?
- How would you **cache search results** without breaking correctness for bookings?

---

## Data Modeling & Booking Flow

**Entities to listen for:**
- `Hotel`, `RoomType`, `Room` (if tracking individual rooms), `RatePlan`.
- `Booking` (status: pending, confirmed, cancelled, expired).
- `InventorySlot` or per-day availability buckets for room types.
- `User` / `Guest`, `PaymentMethod`, `Invoice` or `Charge`.

**Critical path: create booking (happy path):**
1. Client sends **book request** (hotel, room type, date range, guests, payment details).
2. Booking service:
   - Validates request and checks **current availability** with Inventory service.
   - Places a **short-lived hold** on the requested inventory (e.g. decrement available count or lock specific rooms).
3. Payment service:
   - Authorizes or charges payment.
4. If payment succeeds:
   - Booking is **confirmed** and persisted transactionally.
   - Inventory hold becomes a **permanent decrement** on availability.
   - Notification is sent.
5. If payment fails or times out:
   - Booking transitions to **failed/expired**.
   - Inventory hold is **released**.

**Depth prompts:**
- How do you **avoid double-booking** when multiple users try to book the last room?
- How do you model **holds** (TTL-based reservations that auto-expire)?
- What does the **transaction boundary** look like between booking, inventory, and payment?

---

## Concurrency, Consistency & Failure Modes

This is where strong candidates will lean into **trade-offs and edge cases**, not just boxes and arrows.

Topics to probe:
- **Race conditions / double-booking:**
  - Row-level locks, optimistic concurrency control, or atomic counters for availability.
  - Per-hotel or per-room-type partitions to avoid global locks.
- **Search vs. booking discrepancy:**
  - Accept **eventually consistent search**, but require **strongly consistent booking**.
  - How to handle "room was shown as available but is gone by the time you book".
- **Failure handling:**
  - Payment succeeds but booking write fails.
  - Booking persisted but notification fails.
  - Inventory updated but booking not visible to user yet.
- **Idempotency:**
  - Idempotent booking APIs to handle client retries.
  - Avoid double-charging cards on retries.

Good answers will:
- Explicitly call out **which operations must be atomic**, and how they’d implement that.
- Show awareness of **distributed transactions vs. local transactions + compensating actions**.

---

## Scaling & Performance

Expect discussion of:
- **Read-heavy traffic:** lots of search, relatively few bookings.
- **Horizontal scaling** of stateless services behind a load balancer.
- **Sharding/partitioning** strategies:
  - By hotel, geography, or time (e.g. year/month partitions for bookings).
- **Caching strategies:**
  - Location-level or hotel-level cached search results with short TTLs.
  - Avoid caching **per-user** mutable state (bookings) too aggressively.
- **Rate limiting** and abuse protection on search & booking endpoints.

Depth prompts:
- How does the design change during **peak events** (e.g. holiday weekends, big conferences)?
- How would you design **backpressure and graceful degradation** (e.g. simplified search results when backend is under heavy load)?

---

## Rubric Dimensions (Architecture Interview)

What to look for in a strong answer:
- **Problem understanding & scoping**
  - Asks clarifying questions.
  - Identifies core user journeys (search, book, modify, cancel).
- **Data modeling & correctness**
  - Models time-based inventory explicitly.
  - Has a coherent story for avoiding double-booking.
- **System design & scaling**
  - Proposes a reasonable high-level architecture and evolution path.
  - Understands read vs. write characteristics and designs accordingly.
- **Reliability & failure handling**
  - Addresses failures across payment, inventory, and booking.
  - Talks about idempotency, retries, monitoring/alerting.
- **Communication & trade-offs**
  - Explains why they chose certain patterns (e.g. eventual vs. strong consistency).
  - Can reason about what they’d do **now** vs. what they’d defer for later scale.

---

## Common Pitfalls to Listen For

- Treating availability as a simple **boolean flag** instead of **time-ranged inventory**.
- Assuming a single database and **hand-waving away race conditions**.
- Ignoring **idempotency and retries** on booking APIs.
- Over-indexing on microservices early without a clear scaling problem.
- Never talking about **failures, monitoring,** or **operational concerns**.

