## Arrays & Strings

Use this chapter as a **recipe book** for common array and string problems. The goal isn’t to memorize every line of code, but to recognize patterns and know which “lens” to reach for under pressure.

---

### Why this matters in interviews

- **Most common topic** on LeetCode‑style platforms; many “easy/medium” questions live here.
- Tests your ability to reason about **indices, windows, and counts** under time and space constraints.
- Many harder problems reduce to **1–2 core templates**: sliding window, two pointers, prefix sums, and hashing.

---

### How to study this chapter

- **Skim the patterns first** (fixed/variable window, two pointers, prefix sums) and make sure you could explain when to use each in plain language.
- For each pattern, **hand‑trace** one or two examples on paper until the pointer or window movements feel automatic.
- When you practice problems, **label** which pattern you’re using (“variable window with hash map”, “two pointers from ends”) so your brain builds the mapping.
- After solving, spend 1–2 minutes asking: “Could this have been done with another pattern? Why is this one cleaner or more efficient?”

---

### Core concepts

- **Array vs string**
  - Arrays: random access \(O(1)\) by index, fixed or dynamic size.
  - Strings: often treated as read‑only arrays of characters; watch out for cost of copying when building new strings.
- **Big‑O basics**
  - Single pass over array/string: \(O(n)\).
  - Nested loops over entire length: \(O(n^2)\).
  - Hash map/set lookup: \(O(1)\) expected.
- **Common tools**
  - **Prefix sums**: precompute running sums for fast range queries.
  - **Frequency counts**: arrays or hash maps keyed by value/character.
  - **Two pointers**: move pointers from left/right to shrink or expand a range.
  - **Sliding window**: maintain a window `[l, r]` while tracking counts/conditions.

---

### Canonical patterns

#### Fixed‑size sliding window

Use when the window length `k` is fixed (e.g., max sum of subarray of size `k`).

Swift sketch:

```swift
func maxSubarraySum(of nums: [Int], windowSize k: Int) -> Int {
    guard k > 0, nums.count >= k else { return 0 }

    var best = Int.min
    var windowSum = 0

    for r in 0..<nums.count {
        windowSum += nums[r]

        if r >= k {
            windowSum -= nums[r - k]   // shrink from left
        }

        if r >= k - 1 {
            best = max(best, windowSum)
        }
    }

    return best
}
```

#### Variable‑size sliding window

Use when the window size depends on a condition (e.g., smallest window with sum ≥ target, longest substring with at most `k` distinct chars).

Swift sketch (longest substring without repeating characters):

```swift
func lengthOfLongestSubstring(_ s: String) -> Int {
    let chars = Array(s)
    var lastSeen: [Character: Int] = [:]
    var left = 0
    var best = 0

    for right in 0..<chars.count {
        let ch = chars[right]
        if let prev = lastSeen[ch], prev >= left {
            left = prev + 1
        }
        lastSeen[ch] = right
        best = max(best, right - left + 1)
    }

    return best
}
```

#### Two pointers from both ends

Use when you need to compare or combine values from **both sides** (e.g., checking palindrome, two‑sum in sorted array, trapping rain water variants).

Swift sketch (two‑sum in sorted array):

```swift
func twoSumSorted(_ nums: [Int], target: Int) -> (Int, Int)? {
    var left = 0
    var right = nums.count - 1

    while left < right {
        let sum = nums[left] + nums[right]
        if sum == target {
            return (left, right)
        } else if sum < target {
            left += 1
        } else {
            right -= 1
        }
    }

    return nil
}
```

#### Prefix sums

Use when you need **many range sum queries** or want to quickly compute sums of subarrays.

Swift sketch:

```swift
func prefixSums(_ nums: [Int]) -> [Int] {
    var prefix = Array(repeating: 0, count: nums.count + 1)
    for i in 0..<nums.count {
        prefix[i + 1] = prefix[i] + nums[i]
    }
    return prefix
}

// sum of nums[l...r] inclusive:
func rangeSum(_ prefix: [Int], from l: Int, to r: Int) -> Int {
    return prefix[r + 1] - prefix[l]
}
```

---

### Common gotchas & tradeoffs

- **Off‑by‑one and window boundaries**
  - Be explicit about whether your window is `[l, r]` or `[l, r)` and when it’s legal for `l == r + 1` (empty window). Many bugs come from updating `l` or `r` in the wrong order.
- **Infinite loops in sliding windows**
  - Make sure **both pointers move** in all code paths. If your condition fails and you neither expand nor shrink the window, you’ll spin forever.
- **Unicode and indexing semantics**
  - In production Swift, indexing into `String` by integer is invalid; be conscious of **grapheme clusters**. In interviews it’s usually fine to treat strings as arrays, but you can get bonus points by calling this out briefly.
- **Copying large strings or slices**
  - Repeated concatenation or building many substrings can silently turn an \(O(n)\) algorithm into \(O(n^2)\). Prefer working with indices, views, or appending to an array and joining at the end.
- **Choosing between hash maps and frequency arrays**
  - For small fixed alphabets (e.g., lowercase English letters), a plain array is faster and more memory‑efficient than a dictionary; for arbitrary Unicode or large ranges, a map is simpler and less error‑prone.
- **Very large inputs and streaming data**
  - Sliding window and two‑pointer patterns assume random access; for **streams** or data that doesn’t fit in memory, think in terms of **fixed‑size windows**, approximate statistics, or bounded buffers rather than exact answers.
- **Cache‑friendliness and memory layout**
  - Contiguous arrays are cache‑friendly; scattered data structures (linked lists, trees) have worse locality. For hot paths, prefer representations that keep data **packed and linear** even if they’re less “pure”.

---

### Interview Q&A

- **Q: When do you choose a sliding window vs two pointers?**  
  **A:** Sliding window is usually about maintaining a **contiguous subarray/substring** that satisfies a condition; two pointers can be more general and often involves **sorted data** or meeting in the middle (e.g., two‑sum in sorted array, merging).

- **Q: How do you handle Unicode or multi‑byte characters in string problems?**  
  **A:** In interviews, unless stated otherwise, treat strings as arrays of characters. If explicitly asked, mention that some platforms use UTF‑8/UTF‑16 and indexing by code unit can be tricky; many languages provide iterators over user‑perceived characters.

- **Q: What’s the complexity of checking if two strings are anagrams?**  
  **A:** \(O(n)\) time and \(O(1)\) or \(O(k)\) space depending on alphabet size (e.g., 26 for lowercase letters). Use a fixed‑size frequency array or hash map.

- **Q: Why might naive string concatenation in a loop be slow?**  
  **A:** Each concatenation may allocate a new string and copy contents; overall cost can become \(O(n^2)\). Prefer builders (e.g., arrays joined at the end, `StringBuilder`‑style types).

---

### Practice prompts

- Design a function that returns the **length of the longest substring** without repeating characters.
- Given a string and a set of characters, find the **minimum window substring** that contains all of them.
- Given an integer array, find the **maximum sum subarray** of size `k`.
- Given a sorted array, remove duplicates **in‑place** and return the new length.
- Given an array of 0s and 1s, find the longest subarray containing at most `k` zeros.

