import Foundation

/*
 242. Valid Anagram

 Given two strings s and t, return true if t is an anagram of s, and false otherwise.
 */

class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        var charCount: [Character: Int] = [:]

        for char in s {
            charCount[char, default: 0] += 1
        }

        for char in t {
            charCount[char, default: 0] -= 1
        }

        return charCount.values.allSatisfy { $0 == 0 }
    }
}

// Test Cases
let solution = Solution()
print("Test 1: \(solution.isAnagram("anagram", "nagaram"))") // Expected: true
print("Test 2: \(solution.isAnagram("rat", "car"))") // Expected: false
