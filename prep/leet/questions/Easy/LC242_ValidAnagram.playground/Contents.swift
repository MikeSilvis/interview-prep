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
let solution = Solution()
print("Test 1: \(solution.isAnagram("anagram", "nagaram"))") // Expected: true
print("Test 2: \(solution.isAnagram("rat", "car"))") // Expected: false
