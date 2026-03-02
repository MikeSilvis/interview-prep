import Foundation

/*
 139. Word Break

 Given a string s and a dictionary of strings wordDict, return true if s can be
 segmented into a space-separated sequence of one or more dictionary words.

 Note that the same word in the dictionary may be reused multiple times in the
 segmentation.

 Example 1:
 Input: s = "leetcode", wordDict = ["leet","code"]
 Output: true
 Explanation: Return true because "leetcode" can be segmented as "leet code".

 Example 2:
 Input: s = "applepenapple", wordDict = ["apple","pen"]
 Output: true
 Explanation: Return true because "applepenapple" can be segmented as "apple pen apple".
 Note that you are allowed to reuse a dictionary word.

 Example 3:
 Input: s = "catsandog", wordDict = ["cats","dog","sand","and","cat"]
 Output: false

 Constraints:
 - 1 <= s.length <= 300
 - 1 <= wordDict.length <= 1000
 - 1 <= wordDict[i].length <= 20
 - s and wordDict[i] consist of only lowercase English letters.
 - All the strings of wordDict are unique.
 */

class Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
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
check("Test 1", solution.wordBreak("leetcode", ["leet", "code"]), true)
check("Test 2", solution.wordBreak("applepenapple", ["apple", "pen"]), true)
check("Test 3", solution.wordBreak("catsandog", ["cats", "dog", "sand", "and", "cat"]), false)

/*
 Follow-up Questions:
 1. How would you use dynamic programming to solve this problem?
 2. What is the time complexity of the DP approach?
 3. How would you modify this to return all possible segmentations (Word Break II)?
 4. Could you use BFS/DFS + memoization as an alternative approach?
 */
