# Swift LeetCode Interview Prep

A comprehensive Swift workbook for software engineering interview preparation, featuring high-frequency LeetCode problems organized as pages in a single Xcode Playground. Perfect for FAANG/MAANG interview prep.

## How to Use

1. **Open the playground:**
   Open `prep/leet/LeetCode.playground` in Xcode.

2. **Navigate problems:**
   Use the sidebar (View > Navigators > Show Project Navigator) to browse all 28 problems. Pages are sorted numerically and tagged by difficulty.

3. **Run a page:**
   Select a page and press ⌘+Shift+Return to execute. Test results print as PASS/FAIL in the console.

4. **Optional: Study workflow with an AI skill**

   If you wire this playground to an AI skill, you can use slash commands like:

   - `/leet:help 016` — get a hint for a problem
   - `/leet:help 016 approach` — get a step-by-step algorithm
   - `/leet:help 016 solve` — get the full solution written into the file
   - `/leet:reset 016` — reset a problem back to its TODO stub

   To create your own version:
   - Define a skill under `.cursor/skills/` (see the repo `README.md` for the pattern).
   - Choose whatever prefix you like (for example, `/prep:help 016`).

## Pairing with the study guides

- For algorithms refreshers and patterns, use the **Algorithms & Data Structures Study Guide** under `prep/study-guide/algorithms/`.
- A simple workflow:
  - Skim the relevant topic file (for example, arrays/strings or dynamic programming).
  - Pick a matching problem from this playground and implement it in Swift.
  - After solving, map your solution back to the patterns described in the guide.

## Naming Convention

Each page follows the format: `{number}-{Difficulty}-{Name}`

This ensures Finder and Xcode sort problems numerically, while the difficulty tag makes it easy to filter at a glance.

## Problem List

### Easy (10)
| # | Problem | Page |
|---|---------|------|
| 1 | [Two Sum](https://leetcode.com/problems/two-sum/) | `001-Easy-TwoSum` |
| 2 | [Valid Parentheses](https://leetcode.com/problems/valid-parentheses/) | `002-Easy-ValidParentheses` |
| 3 | [Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/) | `003-Easy-MergeTwoSortedLists` |
| 4 | [Climbing Stairs](https://leetcode.com/problems/climbing-stairs/) | `004-Easy-ClimbingStairs` |
| 5 | [Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/) | `005-Easy-BestTimeToBuyAndSellStock` |
| 6 | [Single Number](https://leetcode.com/problems/single-number/) | `006-Easy-SingleNumber` |
| 7 | [Linked List Cycle](https://leetcode.com/problems/linked-list-cycle/) | `007-Easy-LinkedListCycle` |
| 8 | [Invert Binary Tree](https://leetcode.com/problems/invert-binary-tree/) | `008-Easy-InvertBinaryTree` |
| 9 | [Valid Anagram](https://leetcode.com/problems/valid-anagram/) | `009-Easy-ValidAnagram` |
| 10 | [Move Zeroes](https://leetcode.com/problems/move-zeroes/) | `010-Easy-MoveZeroes` |

### Medium (10)
| # | Problem | Page |
|---|---------|------|
| 11 | [Add Two Numbers](https://leetcode.com/problems/add-two-numbers/) | `011-Medium-AddTwoNumbers` |
| 12 | [Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/) | `012-Medium-LongestSubstringWithoutRepeatingCharacters` |
| 13 | [Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/) | `013-Medium-LongestPalindromicSubstring` |
| 14 | [Container With Most Water](https://leetcode.com/problems/container-with-most-water/) | `014-Medium-ContainerWithMostWater` |
| 15 | [3Sum](https://leetcode.com/problems/3sum/) | `015-Medium-3Sum` |
| 16 | [Group Anagrams](https://leetcode.com/problems/group-anagrams/) | `016-Medium-GroupAnagrams` |
| 17 | [Binary Tree Inorder Traversal](https://leetcode.com/problems/binary-tree-inorder-traversal/) | `017-Medium-BinaryTreeInorderTraversal` |
| 18 | [Word Break](https://leetcode.com/problems/word-break/) | `018-Medium-WordBreak` |
| 19 | [LRU Cache](https://leetcode.com/problems/lru-cache/) | `019-Medium-LRUCache` |
| 20 | [Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self/) | `020-Medium-ProductOfArrayExceptSelf` |

### Hard (8)
| # | Problem | Page |
|---|---------|------|
| 21 | [Median of Two Sorted Arrays](https://leetcode.com/problems/median-of-two-sorted-arrays/) | `021-Hard-MedianOfTwoSortedArrays` |
| 22 | [Merge k Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/) | `022-Hard-MergeKSortedLists` |
| 23 | [Longest Valid Parentheses](https://leetcode.com/problems/longest-valid-parentheses/) | `023-Hard-LongestValidParentheses` |
| 24 | [Trapping Rain Water](https://leetcode.com/problems/trapping-rain-water/) | `024-Hard-TrappingRainWater` |
| 25 | [Edit Distance](https://leetcode.com/problems/edit-distance/) | `025-Hard-EditDistance` |
| 26 | [Minimum Window Substring](https://leetcode.com/problems/minimum-window-substring/) | `026-Hard-MinimumWindowSubstring` |
| 27 | [Word Ladder](https://leetcode.com/problems/word-ladder/) | `027-Hard-WordLadder` |
| 28 | [Serialize and Deserialize Binary Tree](https://leetcode.com/problems/serialize-and-deserialize-binary-tree/) | `028-Hard-SerializeAndDeserializeBinaryTree` |

## Each Page Includes

- Complete problem statement with constraints
- Solution class with method stub (or completed solution)
- Test cases with PASS/FAIL output
- Follow-up questions for deeper understanding

## Adding New Problems

1. Create a new `.xcplaygroundpage` directory under `LeetCode.playground/Pages/`
2. Name it `{XXX}-{Difficulty}-{Name}.xcplaygroundpage`
3. Add a `Contents.swift` following the existing template
4. Add a `<page name='...'/>` entry to `contents.xcplayground`
