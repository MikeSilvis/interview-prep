import Foundation

/*
 76. Minimum Window Substring

 Given two strings s and t of lengths m and n respectively, return the minimum window substring
 of s such that every character in t (including duplicates) is included in the window.
 If there is no such substring, return the empty string "".

 Example 1:
 Input: s = "ADOBECODEBANC", t = "ABC"
 Output: "BANC"
 Explanation: The minimum window substring "BANC" includes 'A', 'B', and 'C' from string t.

 Example 2:
 Input: s = "a", t = "a"
 Output: "a"

 Example 3:
 Input: s = "a", t = "aa"
 Output: ""
 Explanation: Both 'a's from t must be included in the window. Since s only has one 'a', return "".

 Constraints:
 - m == s.length
 - n == t.length
 - 1 <= m, n <= 10^5
 - s and t consist of uppercase and lowercase English letters.
 */

class Solution {
    func minWindow(_ s: String, _ t: String) -> String {
        // TODO: Solve
        return ""
    }
}

// Test Cases
func check(_ label: String, _ actual: String, _ expected: String) {
    let pass = actual == expected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \"\(actual)\", expected \"\(expected)\"")
}

let solution = Solution()
check("Test 1", solution.minWindow("ADOBECODEBANC", "ABC"), "BANC")
check("Test 2", solution.minWindow("a", "a"), "a")
check("Test 3", solution.minWindow("a", "aa"), "")
check("Test 4", solution.minWindow("ab", "b"), "b")

/*
 Follow-up Questions:
 1. How does the sliding window with two pointers work here?
 2. How do you efficiently track when all characters in t are covered?
 3. What is the time complexity and can you do better than O(m + n)?
 */
