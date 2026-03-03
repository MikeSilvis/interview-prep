## Dynamic Programming

Treat this chapter like a **workshop on turning brute‑force recursion into something fast and structured**. The aim is to train your eye to spot DP problems and walk through a small set of repeatable steps: define state, write a recurrence, and choose top‑down or bottom‑up.

---

### Why this matters in interviews

- DP appears in many **medium/hard** questions: sequences, grids, subsets, and paths.
- Interviewers want to see if you recognize **overlapping subproblems** and can define a correct **state and transition**.
- You don’t need dozens of formulas; you need a **repeatable checklist**.

---

### How to study this chapter

- Start from a **naive recursive** solution and explicitly circle where it recomputes the same work; this makes the need for DP obvious instead of magical.
- Practice writing out, in words, “Let `dp[i]` mean …” or “Let `dp[r][c]` be …” before you ever touch code.
- For each pattern, write both a **top‑down** (memoized) and **bottom‑up** version once, so you feel the equivalence.
- After solving, ask yourself: “Could I have made the state **smaller**? Could I have made the explanation **simpler**?” This is exactly what senior interviewers are listening for.

---

### Core concepts

- **Overlapping subproblems**
  - The same smaller problem is solved multiple times in naive recursion.
- **Optimal substructure**
  - Optimal answer to the big problem can be built from optimal answers to subproblems.
- **State**
  - Minimal set of parameters that fully describe a subproblem (e.g., index `i`, remaining capacity `c`, or coordinates `(r, c)`).
- **Transition**
  - Recurrence relation that expresses `dp[state]` in terms of smaller states.
- **Top‑down vs bottom‑up**
  - Top‑down: recursion + memoization.
  - Bottom‑up: iterative filling of a table.

---

### DP recognition checklist

Ask:

1. Can I define the answer in terms of **smaller prefixes or suffixes** (e.g., first `i` elements)?
2. Do I see **choices** at each step (take/not take, go left/right/up/down)?
3. Are there **overlapping computations** in a naive recursive solution?
4. Is the problem asking for:
   - max/min value,
   - count of ways,
   - true/false feasibility,
   - or length of something?

If yes to several, DP is a strong candidate.

---

### Senior / staff angle

- **Focus on explanation and coaching**: practice describing your DP state and transition so that a mid‑level engineer could implement it from your explanation alone.
- **Prefer clarity over cleverness**: be ready to justify when you keep a slightly larger table or simpler state for readability, and when you’d tighten it for performance at scale.
- **Connect to real systems**: relate DP patterns to real problems you’ve worked on (pricing, scheduling, recommendations, capacity planning) rather than just toy examples.
- **Recognize when DP is the wrong tool**: be able to explain when greedy, graph algorithms, or pre‑computation are a better fit even if you could force a DP formulation.

---

### Canonical patterns

#### 1D DP on index (climbing stairs / Fibonacci)

```text
# ways to reach step i
dp[0] = 1
dp[1] = 1

for i in 2..<n+1:
  dp[i] = dp[i-1] + dp[i-2]

return dp[n]
```

Space can often be reduced to two variables.

#### 1D DP – house robber (no adjacent elements)

```text
dp[0] = nums[0]
dp[1] = max(nums[0], nums[1])

for i in 2..<n:
  dp[i] = max(dp[i-1], dp[i-2] + nums[i])

return dp[n-1]
```

#### 2D grid DP – unique paths / minimum path sum

```text
for r in 0..<rows:
  for c in 0..<cols:
    if (r, c) is start:
      dp[r][c] = base
    else:
      fromTop = dp[r-1][c] if r > 0 else base_for_missing
      fromLeft = dp[r][c-1] if c > 0 else base_for_missing
      dp[r][c] = combine(fromTop, fromLeft, grid[r][c])
```

#### Knapsack‑style (subset sum / partition)

Boolean DP: can we reach a sum?

```text
dp = boolean array of size target+1
dp[0] = true

for num in nums:
  for s in target downTo num:
    dp[s] = dp[s] or dp[s - num]
```

Iterate **backwards** to avoid reusing items multiple times.

---

### Common gotchas & tradeoffs

- **State that’s too big or too small**
  - If your state doesn’t contain enough information, your transitions will be wrong; if it contains too much, you’ll blow up time/space. Practice asking “What’s the **minimal information** this subproblem needs?”
- **Off‑by‑one in indices and bases**
  - Many DP bugs come from mis‑initialized base cases (`dp[0]`, `dp[1]`) or using `i` vs `i‑1` inconsistently. Write out a tiny example table and fill the first few cells by hand.
- **Double‑counting in subset/knapsack problems**
  - Iterating the `target` sum **forwards** instead of backwards will often let you reuse items multiple times by accident. Remember: 0/1 knapsack → iterate **downwards**.
- **Unbounded recursion depth**
  - A top‑down approach with deep recursion can hit stack limits. In languages without tail‑call optimization, mention this and be ready to show a bottom‑up alternative.
- **Over‑applying DP**
  - Some problems are much cleaner as greedy, BFS/DFS, or pre‑computation. Senior interviewers like hearing you say “We could force a DP here, but it’s more natural as a graph/greedy problem because …”.
- **Ignoring numerical growth**
  - Counting paths/ways can overflow typical integer types quickly. In real systems, you’d use modulo arithmetic, logs, or approximations; mentioning this is an easy way to sound reality‑grounded.
- **Space optimization vs readability**
  - Collapsing a 2D DP to 1D can save space but makes debugging harder. In interviews, prefer the **clear table** first, then explain how you’d compress it if memory mattered in production.

---

### Interview Q&A

- **Q: What’s the difference between memoization and tabulation?**  
  **A:** Memoization is **top‑down** (start from big problem, cache recursive results). Tabulation is **bottom‑up** (iteratively fill a table from smallest subproblems upward).

- **Q: How do you decide the DP state?**  
  **A:** Identify the **minimal information** needed to uniquely determine a subproblem’s answer (often an index, remaining capacity, or position in grid + remaining constraint like steps).

- **Q: How do you reduce DP space complexity?**  
  **A:** If a transition only depends on the previous row or previous few states, you can compress the DP table to fewer dimensions (e.g., 1D array for many 2D grids).

- **Q: Why are naive recursive solutions often TLE?**  
  **A:** They recompute the same subproblems exponentially many times; DP cuts this down to **number of states × transitions per state**.

---

### Practice prompts

- Climbing stairs with 1 or 2 steps at a time – count ways.
- House robber problem – maximum sum with no adjacent houses.
- 0/1 knapsack variant: can you reach exactly `target` sum with given numbers?
- Unique paths in a grid from top‑left to bottom‑right (with and without obstacles).
- Longest increasing subsequence (LIS) using \(O(n^2)\) DP first, then consider optimizing with binary search.
 - Take a DP problem you know well and write down how you’d teach it to a junior engineer in 10 minutes, including how to recognize it and avoid common bugs.
 - For a DP solution you’ve written, list concrete ways you could instrument or log it in production to debug correctness or performance issues at scale.

