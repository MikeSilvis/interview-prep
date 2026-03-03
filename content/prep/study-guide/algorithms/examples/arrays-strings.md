## Arrays & Strings

<<<<<<< HEAD:content/prep/study-guide/algorithms/examples/arrays-strings.md
Use this chapter as a **recipe book** for common array and string problems. The goal isn’t to memorize every line of code, but to recognize patterns and know which “lens” to reach for under pressure.

||||||| parent of d51015a (update reuslts):prep/study-guide/algorithms/arrays-strings.md
=======
Use this chapter as a **recipe book** for common array and string problems. The goal isn’t to memorize every line of code, but to recognize **patterns** and know which “lens” to reach for under pressure.
>>>>>>> d51015a (update reuslts):prep/study-guide/algorithms/arrays-strings.md
---

### Why this matters in interviews

Arrays and strings look simple, but they’re where interviewers can quickly measure whether you can **reason precisely under constraints**.

- **Most common topic**
  - Many “easy/medium” questions on LeetCode‑style platforms are fundamentally array/string questions.
  - Even harder problems often reduce to “do something clever with indices and counts”.
- **Tests real engineering skills**
  - **Index arithmetic**: Can you manage `l`, `r`, `mid` without off‑by‑ones?
  - **Windows and counts**: Can you maintain a running state instead of recomputing from scratch?
  - **Time/space tradeoffs**: Are you willing to spend a little extra memory (e.g., a hash map) to get from \(O(n^2)\) to \(O(n)\)?
- **Mirror real systems**
  - Logs, metrics, clickstreams, and protocol parsing are often “arrays of records” or “streams of bytes/characters”.
  - Production bugs often come from **boundary conditions**: empty input, weird Unicode, very large arrays, partial windows.

Think of this chapter as learning a **small set of templates** (sliding window, two pointers, prefix sums, hashing) and how to adapt them.

---

<<<<<<< HEAD:content/prep/study-guide/algorithms/examples/arrays-strings.md
### How to study this chapter

- **Skim the patterns first** (fixed/variable window, two pointers, prefix sums) and make sure you could explain when to use each in plain language.
- For each pattern, **hand‑trace** one or two examples on paper until the pointer or window movements feel automatic.
- When you practice problems, **label** which pattern you’re using (“variable window with hash map”, “two pointers from ends”) so your brain builds the mapping.
- After solving, spend 1–2 minutes asking: “Could this have been done with another pattern? Why is this one cleaner or more efficient?”

---

||||||| parent of d51015a (update reuslts):prep/study-guide/algorithms/arrays-strings.md
=======
### How to study this chapter

Instead of grinding random problems, study **patterns and their triggers**.

- **Step 1: Learn the pattern vocabulary**
  - Be able to say, in plain language:
    - “A **fixed‑size sliding window** keeps a contiguous segment of length `k` and moves it across the array.”
    - “A **variable‑size window** grows/shrinks based on a condition (sum, distinct chars, etc.).”
    - “**Two pointers** can converge from ends or march in the same direction to avoid nested loops.”
    - “**Prefix sums** let me answer many range queries in \(O(1)\) after \(O(n)\) preprocessing.”
- **Step 2: Hand‑trace a few examples**
  - For each pattern, pick 1–2 canonical problems and trace them **by hand**:
    - Draw the array.
    - Write down `l`, `r`, any maps/counters, and update them step‑by‑step.
  - Stop when the pointer movements feel **predictable**, not mysterious.
- **Step 3: Label pattern usage during practice**
  - When solving, explicitly write at the top of your scratch:
    - “Pattern: variable window + hash map”
    - “Pattern: two pointers from both ends”
  - This builds a mental lookup table from problem phrases (“longest substring…”, “subarray with sum…”) to patterns.
- **Step 4: Compare alternative approaches**
  - After solving, ask:
    - Could I do this with a different pattern?
    - Would that be more complex or less efficient?
  - Example: Longest substring without repeats can be done with:
    - Nested loops (\(O(n^2)\)) — simpler but slow.
    - Variable window with hash map (\(O(n)\)) — more state but faster.
- **Step 5: Senior‑level reflection**
  - For each solved problem, briefly consider:
    - **Scaling**: What if `n` is \(10^7\)? Does my approach still work in time and memory?
    - **Streaming**: Could I adapt this if I only saw the data once in a stream?
    - **Production**: What extra checks or metrics would I add in real code?

---
>>>>>>> d51015a (update reuslts):prep/study-guide/algorithms/arrays-strings.md
### Core concepts

#### Arrays vs strings

- **Arrays**
  - Contiguous block of elements: \(O(1)\) random access by index.
  - Great for algorithms that jump around (`mid = (l + r)/2`, `i + k`, etc.).
  - Mutations (insert/delete in middle) are \(O(n)\) because elements shift.
- **Strings**
  - Often treated as read‑only arrays of characters **in interviews**.
  - In real Swift:
    - `String` is a collection of **grapheme clusters**, not raw bytes.
    - Indexing by `Int` is invalid; you use `String.Index`.
    - Many interview solutions simplify to `Array(s)` to get random access.

For interview speed, it’s fine to say: “I’ll treat the string as `[Character]` for clarity.”

#### Big‑O basics (and what they feel like)

- **Single pass over array/string**: \(O(n)\)
  - Feels like: one `for` loop, maybe moving two indices in lockstep.
- **Nested loops over entire length**: \(O(n^2)\)
  - Feels like: for each index, scan the entire suffix/prefix again.
  - Often acceptable for \(n \le 10^3\); risky for \(n \approx 10^5\).
- **Hash map/set lookup**: \(O(1)\) expected
  - Makes “have we seen this before?” checks cheap.
  - Extra memory cost is often worth the time savings.

#### Common tools

- **Prefix sums**
  - Build an array `prefix` where `prefix[i]` is the sum of the first `i` elements.
  - Range sum \([l, r]\) = `prefix[r + 1] - prefix[l]`.
- **Frequency counts**
  - Array or map from value/character to its count in the current window or whole array.
  - Enables “are these two strings anagrams?” or “does this window contain all required chars?”.
- **Two pointers**
  - Maintain one or two indices (`i`, `j`) to represent a state:
    - Merging sorted arrays.
    - Shrinking a range from both sides.
- **Sliding window**
  - Maintain a **contiguous** window `[l, r]` and expand/shrink while updating counts or sums.
  - Visual model:

    ```
    nums:  [2, 3, 1, 2, 4, 3]
            ^--------^
            l        r
    ```

#### Running example: log window

Keep this mental model as you read patterns:

> You have an array of log timestamps (sorted). You are asked for the **smallest time window** that contains at least `k` requests.

- That screams: **variable‑size sliding window**.
- Window condition: `count >= k`.
- You’ll grow `r` until you have `k` logs, then try to shrink `l` while keeping the count ≥ `k`.

---

### Canonical patterns

Each pattern here has:

- **When to reach for it**
- **Mental model / diagram**
- **Swift or pseudocode sketch**
- **Common variants**

---

### Fixed‑size sliding window

Use when the window length `k` is fixed (e.g., “maximum sum of subarray of size `k`”, “average temperature over last 7 days”).

#### When to reach for it

- Problem explicitly states **“subarray/substring of size `k`”**.
- You need to examine **all windows of fixed length** and compute a function (sum, max, count).

#### Mental model

You maintain sum/info for the current window and “slide” one step:

```
nums:  [1, 3, -1, 5, 4]
windows of size 3:

[1, 3, -1]    -> sum0
    [3, -1, 5]    -> sum1 = sum0 - 1 + 5
        [-1, 5, 4] -> sum2 = sum1 - 3 + 4
```

Instead of recomputing `sum` from scratch, you:
- **Add** the new right element.
- **Subtract** the old left element.

#### Swift sketch

```swift
func maxSubarraySum(of nums: [Int], windowSize k: Int) -> Int {
    guard k > 0, nums.count >= k else { return 0 }

    var best = Int.min
    var windowSum = 0

    for r in 0..<nums.count {
        windowSum += nums[r]

        // Shrink from the left once window is too big
        if r >= k {
            windowSum -= nums[r - k]
        }

        // Window [r - k + 1, r] is now valid
        if r >= k - 1 {
            best = max(best, windowSum)
        }
    }

    return best
}
```

#### Variants you’ll see

- Max/min **sum** over windows of size `k`.
- Max **average** over windows of size `k` (same logic, divide at the end).
- Count windows that satisfy a simple property (e.g., exactly `x` odd numbers) with an extra counter.

---

### Variable‑size sliding window

Use when the window length depends on a condition, typically:

- “Longest/shortest subarray/substring where condition holds.”
- “Minimum window substring containing all required characters.”
- “Longest subarray with at most `k` violations.”

#### When to reach for it

- **Condition phrased over a contiguous range**, not arbitrary positions.
- You can update that condition incrementally when you move `l` or `r`:
  - Adding/removing one element changes a sum/count in a simple way.

#### Mental model

You maintain `[l, r]` and some **state** (sum, counts, distinct characters) such that:

- You always know whether the **current window is valid**.
- You try to either:
  - **Grow** to become valid or optimize length.
  - **Shrink** while staying valid to improve the answer.

Example: longest substring without repeating characters:

```
s:   a  b  c  a  b  b
idx: 0  1  2  3  4  5

window moves:

[a] -> [a, b] -> [a, b, c] -> see 'a' again -> move left past previous 'a'
```

#### Swift sketch (longest substring without repeating characters)

```swift
func lengthOfLongestSubstring(_ s: String) -> Int {
    let chars = Array(s)
    var lastSeen: [Character: Int] = [:]
    var left = 0
    var best = 0

    for right in 0..<chars.count {
        let ch = chars[right]

        if let prev = lastSeen[ch], prev >= left {
            // Move left just past the last occurrence to avoid duplicate
            left = prev + 1
        }

        lastSeen[ch] = right
        best = max(best, right - left + 1)
    }

    return best
}
```

#### Common patterns within variable window

- **At most `k` something**
  - Grow `r`, track count of “bad” items (zeros, odd numbers, distinct chars).
  - While count > `k`, shrink from `l`.
  - Track **max window length**.
- **At least `k` something**
  - Grow `r` until condition holds (sum ≥ target, count ≥ k).
  - Then shrink from `l` while keeping condition true to get **minimum length**.
- **Contains all required chars**
  - Track frequency of required chars, and a “how many requirements are satisfied” counter.
  - Grow `r` to satisfy requirement, shrink `l` to minimize.

---

### Two pointers from both ends

Use when you need to compare or combine values from **both sides**:

- Checking palindrome.
- Two‑sum in a **sorted** array.
- Trapping rain water (more advanced).
- Partitioning arrays (e.g., move negatives to left, positives to right).

#### When to reach for it

- Data is **sorted** or you can reason about moving inwards from both ends.
- The relationship you care about involves **pairs** (`nums[left] + nums[right]`, `nums[left] vs nums[right]`).

#### Mental model

Two fingers walking inward:

```
nums: [1, 2, 3, 4, 6, 8]
       ^              ^
      left           right

If sum < target -> move left rightwards
If sum > target -> move right leftwards
If sum == target -> answer
```

#### Swift sketch (two‑sum in sorted array)

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

#### Variants

- **Check palindrome** (string or array):
  - Compare `s[left]` and `s[right]`, move inward.
- **Move zeros to end / partition array**:
  - Two pointers in the **same direction**: one for “scan”, one for “next write position”.
- **Three‑sum / k‑sum**:
  - Outer loop picks first element, inner two pointers find pairs that complete the sum.

---

### Two pointers in the same direction

A sibling pattern where both pointers move forward:

- **Merge** two sorted arrays:
  - `i` in `a`, `j` in `b`, build output in order.
- **Remove duplicates in place**:
  - `slow` points at last unique, `fast` scans forward.

Example: remove duplicates in sorted array (return new length):

```swift
func removeDuplicates(_ nums: inout [Int]) -> Int {
    guard !nums.isEmpty else { return 0 }

    var write = 1
    for read in 1..<nums.count {
        if nums[read] != nums[read - 1] {
            nums[write] = nums[read]
            write += 1
        }
    }
    return write
}
```

Mental model:

- `read` explores.
- `write` lags behind, marking where the next “kept” element should go.

---

### Prefix sums

Use when you need **many range sum queries** or want to quickly compute sums of subarrays.

#### When to reach for it

- Statement mentions “sum of subarray from `i` to `j`” repeatedly.
- You need to answer many queries over the same static array.
- You want to transform “brute force all subarrays” into a more efficient algorithm using math.

#### Swift sketch

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

#### Common variants

- **1D difference array**
  - Instead of updating a range `[l, r]` directly (which is \(O(n)\)), update:
    - `diff[l] += x`, `diff[r + 1] -= x`.
  - Then take prefix sums once at the end.
- **2D prefix sums** (grids, matrices)
  - Build a `prefix[row + 1][col + 1]` to answer submatrix sums.

---

<<<<<<< HEAD:content/prep/study-guide/algorithms/examples/arrays-strings.md
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

||||||| parent of d51015a (update reuslts):prep/study-guide/algorithms/arrays-strings.md
=======
### Hashing & frequency counts

Not a standalone pattern, but a **tool** used by others.

#### When to reach for it

- “Anagram”, “permutation”, “same multiset of letters”.
- “Have we seen this element/substring before?”
- Need to **count** occurrences per value/char within a window or whole array.

#### Example: Anagram check (simplified)

```swift
func areAnagrams(_ s: String, _ t: String) -> Bool {
    let a = Array(s), b = Array(t)
    guard a.count == b.count else { return false }

    var freq: [Character: Int] = [:]

    for ch in a {
        freq[ch, default: 0] += 1
    }

    for ch in b {
        guard let count = freq[ch] else { return false }
        if count == 1 {
            freq[ch] = nil
        } else {
            freq[ch] = count - 1
        }
    }

    return freq.isEmpty
}
```

You can replace the dictionary with a fixed array (e.g., `26` slots) when the alphabet is small and known.

---

### Common gotchas & tradeoffs

#### Off‑by‑one and window boundaries

- Decide and **write down** your convention:
  - Is your window `[l, r]` inclusive?
  - Or `[l, r)` half‑open?
- Examples:
  - Inclusive `[l, r]` length = `r - l + 1`.
  - Half‑open `[l, r)` length = `r - l`.
- Many bugs come from:
  - Updating `l`/`r` in the wrong order.
  - Using `while l <= r` when you meant `l < r`.

Tip: In code, add a comment like `// window is [left, right] inclusive`.

#### Infinite loops in sliding windows

- In variable windows, make sure that **in every branch**, either:
  - `left` moves, or
  - `right` moves.
- Bad pattern:

```swift
while left < right && conditionIsFalse {
    // forgot to move left or right in some branch
}
```

- Good pattern:
  - If window is “too small”, move `right`.
  - If window is “too big” or invalid, move `left`.

#### Unicode and indexing semantics

- In real Swift:
  - `String` is not indexable by `Int`; indexes are opaque.
  - `s.count` is not O(1) in all cases.
- In interviews:
  - It’s acceptable to convert to `[Character]` once and work with indices.
  - Bonus points for mentioning that real‑world production code must handle grapheme clusters and variable‑length encodings.

#### Copying large strings or slices

- Repeated string concatenation in a loop can lead to \(O(n^2)\) time:
  - Each `result += char` may allocate and copy.
- Safer pattern:
  - Collect into `[Character]` or `[String]`, then `String(resultArray)` or `joined()` once at the end.

#### Choosing between hash maps and frequency arrays

- **Small, fixed alphabet** (e.g., lowercase `a`–`z`):
  - Use `[Int](repeating: 0, count: 26)` and index by `Int(ch.asciiValue - Character("a").asciiValue)`.
- **Large or unknown alphabet**:
  - Use `[Character: Int]` or `[String: Int]`.
- Tradeoff:
  - Arrays are faster and more memory efficient but less flexible.
  - Maps are simpler to write and maintain.

#### Very large inputs and streaming data

- Patterns like sliding window typically assume random access to the array.
- For **streams** or data that doesn’t fit in memory:
  - Prefer fixed‑size windows and incremental statistics.
  - Accept approximations or limited history (e.g., last N events).

#### Cache‑friendliness and memory layout

- Contiguous arrays exhibit good cache locality.
- Linked lists and pointer‑heavy structures cause cache misses.
- In performance‑sensitive code, it’s often better to:
  - Flatten structures into arrays.
  - Use indices instead of pointers.

This is rarely tested explicitly in interviews but good to mention when justifying array‑heavy designs.

---
>>>>>>> d51015a (update reuslts):prep/study-guide/algorithms/arrays-strings.md
### Interview Q&A

#### Sliding window vs two pointers

- **Q:** When do you choose a sliding window vs two pointers?  
  **A:** Sliding window is about a **contiguous window** that must satisfy some property; you maintain and adjust that property as `l` and `r` move. Two pointers is broader: it often leverages **sorted data** or multiple arrays and focuses on **relationships** between positions (`nums[l] + nums[r]`, merging, partitioning). Many sliding windows are implemented with two pointers, but not all two‑pointer solutions are sliding windows.

#### Handling Unicode and multi‑byte characters

- **Q:** How do you handle Unicode or multi‑byte characters in string problems?  
  **A:** In many interviews, unless the problem states otherwise, you can treat strings as arrays of characters for simplicity. If pressed, explain that real strings are often UTF‑8 or UTF‑16; indexing by code unit can split grapheme clusters. Languages like Swift and modern Java provide iterators over user‑perceived characters to avoid this.

#### Complexity of anagram checking

- **Q:** What’s the complexity of checking if two strings are anagrams?  
  **A:** \(O(n)\) time to count and compare, and \(O(1)\) or \(O(k)\) extra space where `k` is alphabet size (e.g., 26 for lowercase letters). Implementation usually uses a frequency array or hash map.

#### Naive string concatenation

- **Q:** Why might naive string concatenation in a loop be slow?  
  **A:** Each concatenation can allocate a new string and copy the old content. Doing this `n` times leads to approximately \(1 + 2 + … + n = O(n^2)\) character copies. It’s more efficient to append to an array and build the final string once, or use a `StringBuilder`‑type abstraction.

#### Senior‑level discussion: choosing data structures

- **Q:** When would you avoid using a `String` or `[Int]` directly in a real system?  
  **A:** If I need to:
  - Represent **sparse** data, I might use a map instead of a huge mostly‑empty array.
  - Maintain a very long, incrementally built string (e.g., logs), I’d use a buffered writer or streaming interface.
  - Store millions of small strings, I might intern them or compress them to save memory.
  - For computation, I might keep data in a numeric array or `Data` buffer for performance, and only convert to `String` at the edges.

#### Recognizing pattern triggers quickly

- **Q:** How do you quickly identify which pattern to use?  
  **A:** I look for:
  - Words like “**subarray/substring**” → likely sliding window or prefix sums.
  - “**Sorted**” → two pointers or binary search.
  - “**Longest/shortest** X while condition holds” → variable window.
  - “**Anagram/permutation**” → frequency counts/hashing.
  - “**Many range queries**” → prefix sums or segment trees.

---

### Practice prompts

Use these to drill both the patterns and your ability to recognize them quickly.

#### Warm‑ups (arrays & indexing)

- Implement a function to **reverse an array in place**.
- Given an array, **rotate it right by `k` steps** in place.
- Given an array of integers, return a new array where each element is the **product of all other elements** (without using division).

#### Fixed‑size sliding window

- Given an integer array, find the **maximum sum subarray** of size `k`.
- Given a list of daily temperatures, compute the **maximum average temperature** over any `k`‑day span.
- Given a binary array and integer `k`, count how many **subarrays of length `k`** contain exactly `x` ones.

#### Variable‑size sliding window

- Design a function that returns the **length of the longest substring** without repeating characters.
- Given a string and a set of characters, find the **minimum window substring** that contains all of them.
- Given an array of positive integers and a target, find the **minimal length subarray** with sum ≥ target; return 0 if none exists.
- Given an array of 0s and 1s, find the **longest subarray containing at most `k` zeros**.
- Given a string, find the **length of the longest substring** that contains at most `k` distinct characters.

#### Two pointers (both ends and same direction)

- Given a sorted array, implement **two‑sum** that returns indices of two numbers adding up to the target, or `nil` if none.
- Given a string, determine if it is a **palindrome**, considering only alphanumeric characters and ignoring cases.
- Given a sorted array, **remove duplicates in‑place** and return the new length.
- Merge two **sorted arrays** into a single sorted array.
- Given a sorted array and a target, find the **first and last positions** of the target using pointers or binary search mix.

#### Prefix sums & range queries

- Build a data structure over an array that supports **range sum queries** in \(O(1)\) time after \(O(n)\) preprocessing.
- Given a binary array, count the number of **subarrays with sum exactly `k`** (hint: prefix sums + hash map).
- In a 2D grid of integers, preprocess to answer **submatrix sum queries** in \(O(1)\) time.
- For an array of daily net profits, compute for each day the **total profit over the last 7 days** using prefix sums.

#### Hashing & frequency‑based problems

- Check if two strings are **anagrams**.
- Given a string, find the **first non‑repeating character** and return its index.
- Given two strings, find the **smallest window** in the first string that contains all characters of the second (allowing duplicates).
- Group a list of strings into **anagram groups**.

#### Mixed / senior‑level prompts

- You receive a stream of user IDs representing requests. Design an algorithm to return, at any point, the **number of distinct users in the last 10 minutes**. Discuss tradeoffs in memory and latency.
- Given a massive log file represented as a string (or array of lines), find the **top `k` most frequent error messages**. How would your solution change if the data doesn’t fit in memory?
- In a rolling A/B test, each event is `(timestamp, variant, converted?)`. Design a function that computes the **conversion rate per variant over any time window** efficiently.
- Given a huge text file, design an algorithm to detect whether it contains **any permutation of a given short pattern string** (e.g., “abc”) as a substring.
- Implement a function that, given an array of integers, finds the **maximum length subarray with sum 0**. Discuss both \(O(n^2)\) and \(O(n)\) hash‑based solutions.
- Design a rate limiter that only allows **at most `k` requests per user within any rolling window of `t` seconds**. Show how sliding window or prefix ideas influence your design.

These prompts are intentionally varied; for each one, first write down which **core pattern** (or combination) you will use before you start coding.
