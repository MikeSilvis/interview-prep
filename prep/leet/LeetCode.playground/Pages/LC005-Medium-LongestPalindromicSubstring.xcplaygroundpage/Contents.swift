import Foundation

/*
 5. Longest Palindromic Substring

 Given a string s, return the longest palindromic substring in s.

 Example 1:
 Input: s = "babad"
 Output: "bab"
 Explanation: "aba" is also a valid answer.

 Example 2:
 Input: s = "cbbd"
 Output: "bb"

 Constraints:
 - 1 <= s.length <= 1000
 - s consist of only digits and English letters.
 */

class Solution {
    func longestPalindrome(_ s: String) -> String {
        // TODO: Solve
        return ""
    }
}

// Test Cases
func check(_ label: String, _ actual: String, _ validAnswers: [String]) {
    let pass = validAnswers.contains(actual)
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \"\(actual)\", expected one of \(validAnswers)")
}

let solution = Solution()
check("Test 1", solution.longestPalindrome("babad"), ["bab", "aba"])
check("Test 2", solution.longestPalindrome("cbbd"), ["bb"])
check("Test 3", solution.longestPalindrome("a"), ["a"])
check("Test 4", solution.longestPalindrome("ac"), ["a", "c"])

/*
 Follow-up Questions:
 1. How does the "expand around center" approach work?
 2. What is Manacher's algorithm and when would you use it?
 3. What is the time complexity of the DP approach vs. expand around center?
 */
