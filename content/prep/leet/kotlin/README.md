## Kotlin LeetCode Interview Prep

This folder mirrors the Swift `LeetCode.playground` workbook, but implemented in **Kotlin** so you can practice the same problems in a JVM-friendly environment (IntelliJ IDEA, Android Studio, or the Kotlin CLI).

### Layout

- `Structures.kt` — shared data structures such as `ListNode` and `TreeNode`.
- `001-Easy-TwoSum.kt` → `028-Hard-SerializeAndDeserializeBinaryTree.kt` — one Kotlin file per problem, matching the numbering, difficulty, and naming from the Swift playground.

Each problem file includes:

- A short problem description and LeetCode link.
- A `SolutionNNN` class (for example, `Solution001` for problem 1) with an idiomatic Kotlin implementation or method stub.
- A `main` function with simple test cases that print results to the console.

### How to Run

You can use any Kotlin runtime. One simple option is the Kotlin command-line compiler:

1. Install the Kotlin compiler (for example, via `brew install kotlin` on macOS).
2. From the repository root, run something like:

   ```bash
   kotlinc content/prep/leet/kotlin/*.kt -include-runtime -d leet-kotlin.jar
   java -jar leet-kotlin.jar
   ```

   This will execute every `main` function defined across the files. You can also compile and run individual files from your IDE.

### Problem List (same as Swift)

The problem set is identical to the Swift playground:

- 10 Easy problems (001–010)
- 10 Medium problems (011–020)
- 8 Hard problems (021–028)

Refer to `content/prep/leet/README.md` for the full table of problems and links; the page names there map directly to the Kotlin filenames here.

