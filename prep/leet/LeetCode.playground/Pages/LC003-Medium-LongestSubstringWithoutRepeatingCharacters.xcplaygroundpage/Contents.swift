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
func check(_ label: String, _ actual: Int, _ expected: Int) {
    let pass = actual == expected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let solution = Solution()
check("Test 1", solution.lengthOfLongestSubstring("abcabcbb"), 3)
check("Test 2", solution.lengthOfLongestSubstring("bbbbb"), 1)
check("Test 3", solution.lengthOfLongestSubstring("pwwkew"), 3)
check("Test 4", solution.lengthOfLongestSubstring(""), 0)
check("Test 5", solution.lengthOfLongestSubstring(" "), 1)

/*
 Follow-up Questions:
 1. How does the sliding window technique apply here?
 2. What data structure do you use to track characters in the current window?
 3. What is the time/space complexity of your solution?
 */
