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
 */

class Solution {
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        /*
         Approach: HashMap with Sorted String as Key
         - Sort each string to create a canonical key
         - Group strings with the same sorted key
         - Return all groups as arrays

         Time Complexity: O(n * k log k) - where n is number of strings, k is max length
         Space Complexity: O(n * k) - for storing the groups
         */

        var groups: [String: [String]] = [:]

        for str in strs {
            let sortedKey = String(str.sorted())
            groups[sortedKey, default: []].append(str)
        }

        return Array(groups.values)
    }

    // Alternative approach using character frequency
    func groupAnagramsFrequency(_ strs: [String]) -> [[String]] {
        var groups: [String: [String]] = [:]

        for str in strs {
            let key = getFrequencyKey(str)
            groups[key, default: []].append(str)
        }

        return Array(groups.values)
    }

    private func getFrequencyKey(_ str: String) -> String {
        var count = Array(repeating: 0, count: 26)
        for char in str {
            let index = Int(char.asciiValue! - Character("a").asciiValue!)
            count[index] += 1
        }
        return count.map(String.init).joined(separator: ",")
    }
}

// Test Cases
let solution = Solution()

// Test Case 1
print("Test 1: \(solution.groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]))")
// Expected: [["bat"], ["nat", "tan"], ["ate", "eat", "tea"]]

// Test Case 2
print("Test 2: \(solution.groupAnagrams([""]))") // Expected: [[""]]

// Test Case 3
print("Test 3: \(solution.groupAnagrams(["a"]))") // Expected: [["a"]]

/*
 Follow-up Questions:
 1. How would you optimize for very long strings?
 2. What if the strings contained Unicode characters?
 3. How would you handle the case where anagrams need to be sorted within groups?
 */