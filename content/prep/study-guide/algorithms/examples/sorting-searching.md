## Sorting & Searching

---

### Why this matters in interviews

- Sorting and binary search show up **everywhere**: arrays, strings, intervals, and even in higher‑level problems.
- Many optimized solutions reduce to **“sort + linear scan”** or **“binary search on answer space”**.
- You don’t need to memorize all sort implementations, but you should know **core ideas and complexities**.

---

### Core concepts

- **Common sorts (conceptual)**
  - Quick sort: average \(O(n \log n)\), worst \(O(n^2)\), in‑place, divide‑and‑conquer.
  - Merge sort: \(O(n \log n)\) worst‑case, stable, \(O(n)\) extra space.
  - Heap sort: \(O(n \log n)\), in‑place, uses heap.
  - Many languages use hybrid algorithms (e.g., TimSort) optimized for real‑world data.
- **Binary search basics**
  - Requires **monotonic** (sorted or otherwise monotone) property.
  - Repeatedly halve the search interval until you find the target or determine absence.
- **Search on answer space**
  - When the answer is a number (e.g., minimum capacity, minimum days) and the **feasibility** of that answer is monotone, binary search on that answer.

---

### Canonical patterns

#### Classic binary search (index of target)

Swift sketch:

```swift
func binarySearch(_ nums: [Int], target: Int) -> Int {
    var left = 0
    var right = nums.count - 1

    while left <= right {
        let mid = left + (right - left) / 2
        if nums[mid] == target {
            return mid
        } else if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    return -1
}
```

#### Lower bound / first position ≥ target

Swift sketch:

```swift
func lowerBound(_ nums: [Int], target: Int) -> Int {
    var left = 0
    var right = nums.count   // exclusive

    while left < right {
        let mid = left + (right - left) / 2
        if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid
        }
    }

    return left // first index with nums[left] >= target, or nums.count
}
```

#### Binary search on answer space

Example: **minimum capacity** such that you can ship all packages within `D` days.

Swift sketch:

```swift
func canShip(_ weights: [Int], capacity: Int, days: Int) -> Bool {
    var usedDays = 1
    var current = 0

    for w in weights {
        if w > capacity { return false }
        if current + w > capacity {
            usedDays += 1
            current = 0
        }
        current += w
    }

    return usedDays <= days
}

func shipWithinDays(_ weights: [Int], _ days: Int) -> Int {
    var low = weights.max() ?? 0
    var high = weights.reduce(0, +)

    while low < high {
        let mid = low + (high - low) / 2
        if canShip(weights, capacity: mid, days: days) {
            high = mid       // mid might still be answer
        } else {
            low = mid + 1
        }
    }

    return low
}
```

Key: `canShip` (or equivalent) must be **monotone**: `true` for all values ≥ some threshold.

---

### Interview Q&A

- **Q: Why is binary search \(O(\log n)\)?**  
  **A:** Each step halves the remaining search space; after \(k\) steps you have at most \(n / 2^k\) elements left. Solving \(n / 2^k = 1\) gives \(k = \log_2 n\).

- **Q: When should you “sort then scan” rather than using a hash map?**  
  **A:** When order matters (e.g., interval merging), when you need nearest neighbors, or when you want predictable memory usage and access patterns. Hash maps are better for pure membership/counting checks with no order.

- **Q: What’s the time complexity of sorting?**  
  **A:** Comparison‑based sorts have a lower bound of \(O(n \log n)\). Counting/radix sorts can do better for restricted key domains at the cost of extra space.

- **Q: When does binary search apply to unsorted input?**  
  **A:** When you’re not searching over the input itself but over a **monotonic function of a numeric answer** (binary search on answer space).

---

### Practice prompts

- Given a sorted array, implement binary search to find a target element or return `-1`.
- Find the **first and last position** of a target value in a sorted array.
- Given an array of intervals, **merge overlapping intervals** (sort + linear scan).
- Given an array of weights and a number of days, find the **least capacity of a ship** to ship all weights within that many days.
- Given a sorted array and a target, find the **closest value** to the target.

