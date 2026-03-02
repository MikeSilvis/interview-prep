import Foundation

/*
 49. Group Anagrams

 Given an array of strings strs, group the anagrams together. You can return the answer in any order.

 An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

 Example 1:
 Input: strs = ["eat","tea","tan","ate","nat","bat"]
 Output: [["bat"],["nat","tan"],["ate","eat","tea"]]

 Example 2:
 Input: strs = [""]
 Output: [[""]]

 Example 3:
 Input: strs = ["a"]
 Output: [["a"]]

 Constraints:
 - 1 <= strs.length <= 10^4
 - 0 <= strs[i].length <= 100
 - strs[i] consists of lowercase English letters.
 */

class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        // TODO: Solve
        return []
    }
}

// Test Cases
func check(_ label: String, _ actual: [[String]], _ expected: [[String]]) {
    let sortedActual = Set(actual.map { Set($0) })
    let sortedExpected = Set(expected.map { Set($0) })
    let pass = sortedActual == sortedExpected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let solution = Solution()
check("Test 1", solution.groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]), [["bat"], ["nat", "tan"], ["ate", "eat", "tea"]])
check("Test 2", solution.groupAnagrams([""]), [[""]])
check("Test 3", solution.groupAnagrams(["a"]), [["a"]])

/*
 Follow-up Questions:
 1. How would you optimize for very long strings?
 2. What if the strings contained Unicode characters?
 3. How would you handle the case where anagrams need to be sorted within groups?
 */
