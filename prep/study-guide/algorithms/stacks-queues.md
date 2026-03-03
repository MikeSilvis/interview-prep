## Stacks & Queues

---

### Why this matters in interviews

- Many problems reduce to a **stack or queue** once you notice the pattern.
- Core to **BFS** (queues) and to parsing / expression evaluation / backtracking (stacks).
- Monotonic stacks are a standard pattern for “**next greater/smaller**” and range problems.

---

### Core concepts

- **Stack**
  - LIFO (last‑in, first‑out).
  - Operations: `push`, `pop`, `peek` all \(O(1)\).
  - Typical uses: undo history, DFS, parentheses validation, expression evaluation.
- **Queue**
  - FIFO (first‑in, first‑out).
  - Operations: `enqueue`, `dequeue`, `front` all \(O(1)\) with proper implementation.
  - Typical uses: BFS, scheduling, rate limiting.
- **Deque**
  - Double‑ended queue: push/pop at both front and back in \(O(1)\).
  - Used in sliding‑window maximum/minimum with a **monotonic deque**.

---

### Canonical patterns

#### Parentheses / bracket validation (stack)

Swift sketch:

```swift
func isValidBrackets(_ s: String) -> Bool {
    var stack: [Character] = []

    for ch in s {
        switch ch {
        case "(", "[", "{":
            stack.append(ch)
        case ")", "]", "}":
            guard let last = stack.popLast() else { return false }
            if (last == "(" && ch != ")") ||
               (last == "[" && ch != "]") ||
               (last == "{" && ch != "}") {
                return false
            }
        default:
            continue
        }
    }

    return stack.isEmpty
}
```

#### Monotonic stack – next greater element

Use when you need, for each index, the **next greater (or smaller) element to the right**.

Swift sketch:

```swift
func nextGreaterElements(_ nums: [Int]) -> [Int] {
    var result = Array(repeating: -1, count: nums.count)
    var stack: [Int] = []   // store indices with decreasing values

    for i in 0..<nums.count {
        while let last = stack.last, nums[i] > nums[last] {
            let j = stack.removeLast()
            result[j] = nums[i]
        }
        stack.append(i)
    }

    return result
}
```

#### BFS using queue

Use for shortest‑path in **unweighted graphs** or **minimum steps** problems.

Swift sketch:

```swift
func bfsShortestPath(from start: Int, graph: [[Int]]) -> [Int] {
    var dist = Array(repeating: -1, count: graph.count)
    var queue: [Int] = []
    var head = 0

    dist[start] = 0
    queue.append(start)

    while head < queue.count {
        let node = queue[head]
        head += 1

        for nei in graph[node] {
            if dist[nei] == -1 {
                dist[nei] = dist[node] + 1
                queue.append(nei)
            }
        }
    }

    return dist
}
```

#### Sliding‑window max (monotonic deque)

Maintain a deque of indices whose values are **decreasing**; front is always the max.

Swift sketch:

```swift
func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
    guard k > 0, nums.count >= k else { return [] }

    var deque: [Int] = []   // stores indices
    var result: [Int] = []

    for i in 0..<nums.count {
        // drop indices out of window
        if let first = deque.first, first <= i - k {
            deque.removeFirst()
        }

        // maintain decreasing order
        while let last = deque.last, nums[i] >= nums[last] {
            deque.removeLast()
        }

        deque.append(i)

        if i >= k - 1 {
            if let first = deque.first {
                result.append(nums[first])
            }
        }
    }

    return result
}
```

---

### Interview Q&A

- **Q: When should you suspect a monotonic stack/deque solution?**  
  **A:** When the problem asks about **next greater/smaller elements**, or sliding window **max/min**, especially with \(O(n)\) time constraint.

- **Q: Why is a queue natural for BFS?**  
  **A:** BFS explores nodes in order of **distance from the start**; a queue ensures you visit all nodes at distance `d` before nodes at `d+1`.

- **Q: What’s the complexity of stack and queue operations?**  
  **A:** Push/pop/peek/enqueue/dequeue are all \(O(1)\) amortized when implemented with proper backing storage.

---

### Practice prompts

- Validate a string of parentheses/brackets (`()[]{}`).
- Compute the **next greater element** for each element in an array.
- Given a list of daily temperatures, return how many days until a **warmer** temperature for each day.
- Given an array and `k`, find the **maximum** for each sliding window of size `k`.
- Given a grid of 0s and 1s, use BFS to find the length of the **shortest path** from top‑left to bottom‑right.

