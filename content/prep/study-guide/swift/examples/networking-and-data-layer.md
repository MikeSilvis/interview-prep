## Networking & Data Layer

---

### Why this matters in interviews

- Most iOS apps are networked; TLs are expected to design **robust, testable networking layers**.
- Interviewers care about **error handling, retries, decoding, and separation of concerns**, not just “how to call URLSession”.

---

### Core concepts

- **Separation of concerns**
  - A small, focused **API client** that wraps URLSession.
  - Higher‑level services that map API models into domain models.
- **Codable**
  - Use `Decodable` to parse JSON into strongly typed models.
  - Be explicit about date formats, key strategies where needed.
- **Error handling**
  - Distinguish between **transport errors** (network down), **server errors** (5xx), **client errors** (4xx), and **parsing errors**.
- **Async APIs**
  - Prefer `async` functions returning domain models or results.
  - Wrap legacy callbacks with async/await.

---

### Canonical patterns

#### Simple API client with async/await

```swift
struct APIClient {
    let baseURL: URL
    let session: URLSession = .shared

    func get<T: Decodable>(_ path: String) async throws -> T {
        let url = baseURL.appendingPathComponent(path)
        let (data, response) = try await session.data(from: url)

        guard let http = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        guard (200..<300).contains(http.statusCode) else {
            throw APIError.httpStatus(http.statusCode)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
```

```kotlin
class ApiClient(
    private val baseUrl: String,
    private val httpClient: HttpClient,
) {
    suspend inline fun <reified T> get(path: String): T {
        val url = "$baseUrl/$path"
        val response = httpClient.get(url)

        if (!response.isSuccessful) {
            throw ApiError.HttpStatus(response.code)
        }

        val body = response.body ?: throw ApiError.InvalidResponse
        return json.decodeFromString(body)
    }
}
```

Then build **feature services** on top:

```swift
protocol HotelService {
    func searchHotels(city: String) async throws -> [Hotel]
}

struct LiveHotelService: HotelService {
    let api: APIClient

    func searchHotels(city: String) async throws -> [Hotel] {
        try await api.get("hotels?city=\(city)")
    }
}
```

```kotlin
interface HotelService {
    suspend fun searchHotels(city: String): List<Hotel>
}

class LiveHotelService(
    private val api: ApiClient,
) : HotelService {
    override suspend fun searchHotels(city: String): List<Hotel> {
        return api.get("hotels?city=$city")
    }
}
```

---

### Interview Q&A

- **Q: How do you design a testable networking layer?**  
  **A:** Introduce a protocol (e.g., `HotelService`) with a real implementation and mocks for tests. Avoid using `URLSession.shared` directly from view models; instead inject an abstraction.

- **Q: How do you handle retries and backoff?**  
  **A:** Implement retry logic at the **service** or **client** layer with exponential backoff for transient errors, being careful not to retry on non‑transient codes (like 4xx).

- **Q: How do you handle JSON decoding failures?**  
  **A:** Log sufficient context, surface a user‑friendly error, and consider schema evolution strategies (e.g., optional fields, default values, versioning).

---

### Practice prompts

- Describe how you’d design the networking layer for a hotel booking app: endpoints, client, services, and error handling.
- Explain how you’d mock network responses in unit tests for a SwiftUI view model.
- Discuss where you’d implement features like caching, offline support, and request deduplication.

