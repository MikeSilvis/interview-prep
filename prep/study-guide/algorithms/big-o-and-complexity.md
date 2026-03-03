## Big-O & Complexity

---

### Why this matters in interviews

- Interviewers expect you to estimate **time and space complexity** for your approaches.
- Big‑O helps compare algorithms at a high level and reason about feasibility under constraints like `n <= 10^5`.
- You don’t need to be perfect; you need to be **directionally correct** and able to justify your reasoning.

---

### Common complexity classes

- \(O(1)\) – constant time.
- \(O(\log n)\) – logarithmic (binary search, tree operations on balanced trees).
- \(O(n)\) – linear (single pass over array).
- \(O(n \log n)\) – typical for efficient sorting and many divide‑and‑conquer algorithms.
- \(O(n^2)\) – double nested loops over the same input.
- \(O(2^n), O(n!)\) – exponential; usually only feasible for small `n`.

---

### Cheatsheet by data structure

- **Array / String (length n)**
  - Read/write by index: \(O(1)\).
  - Insert/delete at end (dynamic array): amortized \(O(1)\).
  - Insert/delete at arbitrary position: \(O(n)\) (shift elements).
  - Scan / search linear: \(O(n)\).
- **Hash map / set (size n)**
  - Insert, lookup, delete: average \(O(1)\), worst‑case \(O(n)\) (rare with good hashing).
  - Iteration over all elements: \(O(n)\).
- **Linked list (length n)**
  - Insert/delete at head: \(O(1)\).
  - Search by value / access by position: \(O(n)\).
- **Binary search tree (n nodes)**
  - Balanced: search/insert/delete \(O(\log n)\).
  - Skewed: worst‑case \(O(n)\).
- **Heap (n elements)**
  - Insert: \(O(\log n)\).
  - Extract‑min/max: \(O(\log n)\).
  - Peek min/max: \(O(1)\).

---

### Typical LeetCode constraints intuition

- `n <= 10^3` → \(O(n^2)\) is usually fine.
- `n <= 10^5` → aim for \(O(n)\) or \(O(n \log n)\).
- `n <= 10^6` → \(O(n)\) only, careful with constants and memory.
- `n <= 20` → exponential \(O(2^n)\) backtracking / bitmask DP can be okay.

When in doubt, estimate **operations per second** (e.g., ~\(10^7\)–\(10^8\) basic operations).

---

### Senior / staff angle

- **Use complexity to make product decisions**, not just pass LeetCode: practice explaining to a PM why a given approach is or isn’t safe at your actual scale and latency budget.
- **Evaluate multiple designs quickly**: for each pattern, get comfortable comparing at least two data‑structure or algorithm choices and calling out when the “slower” but simpler option is still the right tradeoff.
- **Think like a reviewer**: pretend you’re reviewing a PR and need to flag hidden \(O(n^2)\) behavior in a loop, unexpected allocations, or unnecessary network chatter.
- **Connect runtime to cost and reliability**: tie complexity back to CPU usage, battery, server costs, and failure modes you’ve seen in production.

---

### Interview Q&A

- **Q: Why do we ignore constants in Big‑O notation?**  
  **A:** Big‑O focuses on growth rate as `n` becomes large; constant factors matter in practice but don’t change which term dominates asymptotically.

- **Q: How do you analyze nested loops?**  
  **A:** Multiply the sizes when loops are independent; add them when sequential. For a double loop both running `n`, you get \(O(n^2)\).

- **Q: Why is sorting often \(O(n \log n)\)?**  
  **A:** Comparison‑based sorting has a lower bound of \(O(n \log n)\) because you can model it as a decision tree with at least `n!` leaves.

- **Q: What’s the space complexity of recursion?**  
  **A:** Typically proportional to the **maximum call depth**, which often equals the height of a tree or length of sequence you recurse over.

---

### Practice prompts

- Given your solution to a problem, explain its **time and space complexity** and how they would change if input sizes doubled.
- Compare an \(O(n^2)\) algorithm on `n = 1000` to an \(O(n \log n)\) algorithm on `n = 10^5` in terms of rough operation counts.
- For each of your favorite patterns (sliding window, two pointers, BFS, DFS, DP), write down its typical complexity and memory usage.
 - Take two different designs for the same feature (e.g., client‑side vs server‑side filtering) and argue which one you’d ship given scale, latency, and team constraints.
 - Write down how you’d explain an algorithm choice and its complexity to a mid‑level engineer during a code review so they learn a reusable mental model.

