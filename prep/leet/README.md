# Swift LeetCode Interview Prep

A comprehensive Swift workbook for software engineering interview preparation, featuring high-frequency LeetCode problems organized as pages in a single Xcode Playground. Perfect for FAANG/MAANG interview prep.

## How to Use

1. **Open the playground:**
   Open `prep/leet/LeetCode.playground` in Xcode.

2. **Navigate problems:**
   Use the sidebar (View > Navigators > Show Project Navigator) to browse all 28 problems. Pages are sorted numerically and tagged by difficulty.

3. **Run a page:**
   Select a page and press ⌘+Shift+Return to execute. Test results print as PASS/FAIL in the console.

4. **Study workflow with Claude:**
   - `/msilvis:help LC049` — get a hint for a problem
   - `/msilvis:help LC049 approach` — get a step-by-step algorithm
   - `/msilvis:help LC049 solve` — get the full solution written into the file
   - `/msilvis:reset LC049` — reset a problem back to its TODO stub

## Naming Convention

Each page follows the format: `LC{number}-{Difficulty}-{Name}`

This ensures Finder and Xcode sort problems numerically, while the difficulty tag makes it easy to filter at a glance.

## Problem List

### Easy (10)
| # | Problem | Page |
|---|---------|------|
| 1 | [Two Sum](https://leetcode.com/problems/two-sum/) | `LC001-Easy-TwoSum` |
| 20 | [Valid Parentheses](https://leetcode.com/problems/valid-parentheses/) | `LC020-Easy-ValidParentheses` |
| 21 | [Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/) | `LC021-Easy-MergeTwoSortedLists` |
| 70 | [Climbing Stairs](https://leetcode.com/problems/climbing-stairs/) | `LC070-Easy-ClimbingStairs` |
| 121 | [Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/) | `LC121-Easy-BestTimeToBuyAndSellStock` |
| 136 | [Single Number](https://leetcode.com/problems/single-number/) | `LC136-Easy-SingleNumber` |
| 141 | [Linked List Cycle](https://leetcode.com/problems/linked-list-cycle/) | `LC141-Easy-LinkedListCycle` |
| 226 | [Invert Binary Tree](https://leetcode.com/problems/invert-binary-tree/) | `LC226-Easy-InvertBinaryTree` |
| 242 | [Valid Anagram](https://leetcode.com/problems/valid-anagram/) | `LC242-Easy-ValidAnagram` |
| 283 | [Move Zeroes](https://leetcode.com/problems/move-zeroes/) | `LC283-Easy-MoveZeroes` |

### Medium (10)
| # | Problem | Page |
|---|---------|------|
| 2 | [Add Two Numbers](https://leetcode.com/problems/add-two-numbers/) | `LC002-Medium-AddTwoNumbers` |
| 3 | [Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/) | `LC003-Medium-LongestSubstringWithoutRepeatingCharacters` |
| 5 | [Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/) | `LC005-Medium-LongestPalindromicSubstring` |
| 11 | [Container With Most Water](https://leetcode.com/problems/container-with-most-water/) | `LC011-Medium-ContainerWithMostWater` |
| 15 | [3Sum](https://leetcode.com/problems/3sum/) | `LC015-Medium-3Sum` |
| 49 | [Group Anagrams](https://leetcode.com/problems/group-anagrams/) | `LC049-Medium-GroupAnagrams` |
| 94 | [Binary Tree Inorder Traversal](https://leetcode.com/problems/binary-tree-inorder-traversal/) | `LC094-Medium-BinaryTreeInorderTraversal` |
| 139 | [Word Break](https://leetcode.com/problems/word-break/) | `LC139-Medium-WordBreak` |
| 146 | [LRU Cache](https://leetcode.com/problems/lru-cache/) | `LC146-Medium-LRUCache` |
| 238 | [Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self/) | `LC238-Medium-ProductOfArrayExceptSelf` |

### Hard (8)
| # | Problem | Page |
|---|---------|------|
| 4 | [Median of Two Sorted Arrays](https://leetcode.com/problems/median-of-two-sorted-arrays/) | `LC004-Hard-MedianOfTwoSortedArrays` |
| 23 | [Merge k Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/) | `LC023-Hard-MergeKSortedLists` |
| 32 | [Longest Valid Parentheses](https://leetcode.com/problems/longest-valid-parentheses/) | `LC032-Hard-LongestValidParentheses` |
| 42 | [Trapping Rain Water](https://leetcode.com/problems/trapping-rain-water/) | `LC042-Hard-TrappingRainWater` |
| 72 | [Edit Distance](https://leetcode.com/problems/edit-distance/) | `LC072-Hard-EditDistance` |
| 76 | [Minimum Window Substring](https://leetcode.com/problems/minimum-window-substring/) | `LC076-Hard-MinimumWindowSubstring` |
| 127 | [Word Ladder](https://leetcode.com/problems/word-ladder/) | `LC127-Hard-WordLadder` |
| 297 | [Serialize and Deserialize Binary Tree](https://leetcode.com/problems/serialize-and-deserialize-binary-tree/) | `LC297-Hard-SerializeAndDeserializeBinaryTree` |

## Each Page Includes

- Complete problem statement with constraints
- Solution class with method stub (or completed solution)
- Test cases with PASS/FAIL output
- Follow-up questions for deeper understanding

## Adding New Problems

1. Create a new `.xcplaygroundpage` directory under `LeetCode.playground/Pages/`
2. Name it `LC{XXX}-{Difficulty}-{Name}.xcplaygroundpage`
3. Add a `Contents.swift` following the existing template
4. Add a `<page name='...'/>` entry to `contents.xcplayground`
