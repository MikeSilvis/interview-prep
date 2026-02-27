import Foundation

/*
 3. Longest Substring Without Repeating Characters

 Given a string s, find the length of the longest substring without repeating characters.

 Example 1:
 Input: s = "abcabcbb"
 Output: 3
 Explanation: The answer is "abc", with the length of 3.

 Example 2:
 Input: s = "bbbbb"
 Output: 1
 Explanation: The answer is "b", with the length of 1.

 Example 3:
 Input: s = "pwwkew"
 Output: 3
 Explanation: The answer is "wke", with the length of 3.

 Constraints:
 - 0 <= s.length <= 5 * 10^4
 - s consists of English letters, digits, symbols and spaces.
 */

class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        // TODO: Solve
        return 0
    }
}

// Test Cases
let solution = Solution()
print("Test 1: \(solution.lengthOfLongestSubstring("abcabcbb"))") // Expected: 3
print("Test 2: \(solution.lengthOfLongestSubstring("bbbbb"))") // Expected: 1
print("Test 3: \(solution.lengthOfLongestSubstring("pwwkew"))") // Expected: 3
