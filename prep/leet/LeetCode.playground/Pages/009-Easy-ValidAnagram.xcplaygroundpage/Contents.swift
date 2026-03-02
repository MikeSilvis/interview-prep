import Foundation

/*
 242. Valid Anagram

 Given two strings s and t, return true if t is an anagram of s, and false otherwise.

 An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase,
 typically using all the original letters exactly once.

 Example 1:
 Input: s = "anagram", t = "nagaram"
 Output: true

 Example 2:
 Input: s = "rat", t = "car"
 Output: false

 Constraints:
 - 1 <= s.length, t.length <= 5 * 10^4
 - s and t consist of lowercase English letters.
 */

class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        // TODO: Solve
        return false
    }
}

// Test Cases
func check(_ label: String, _ actual: Bool, _ expected: Bool) {
    let pass = actual == expected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let solution = Solution()
check("Test 1", solution.isAnagram("anagram", "nagaram"), true)
check("Test 2", solution.isAnagram("rat", "car"), false)
check("Test 3", solution.isAnagram("a", "a"), true)
check("Test 4", solution.isAnagram("ab", "a"), false)

/*
 Follow-up Questions:
 1. What if the inputs contain Unicode characters?
 2. How would you solve this using a frequency count instead of sorting?
 3. What is the time complexity of each approach?
 */
