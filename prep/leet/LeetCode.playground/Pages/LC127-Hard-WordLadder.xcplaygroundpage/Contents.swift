import Foundation

/*
 127. Word Ladder

 A transformation sequence from word beginWord to word endWord using a dictionary wordList is a
 sequence of words beginWord -> s1 -> s2 -> ... -> sk such that:
 - Every adjacent pair of words differs by a single letter.
 - Every si for 1 <= i <= k is in wordList. Note that beginWord does not need to be in wordList.
 - sk == endWord

 Given two words, beginWord and endWord, and a dictionary wordList, return the number of words
 in the shortest transformation sequence from beginWord to endWord, or 0 if no such sequence exists.

 Example 1:
 Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
 Output: 5
 Explanation: One shortest transformation sequence is "hit" -> "hot" -> "dot" -> "dog" -> "cog", which is 5 words long.

 Example 2:
 Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log"]
 Output: 0
 Explanation: The endWord "cog" is not in wordList, therefore there is no valid transformation sequence.

 Constraints:
 - 1 <= beginWord.length <= 10
 - endWord.length == beginWord.length
 - 1 <= wordList.length <= 5000
 - wordList[i].length == beginWord.length
 - beginWord, endWord, and wordList[i] consist of lowercase English letters.
 - beginWord != endWord
 - All the words in wordList are unique.
 */

class Solution {
    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
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
check("Test 1", solution.ladderLength("hit", "cog", ["hot", "dot", "dog", "lot", "log", "cog"]), 5)
check("Test 2", solution.ladderLength("hit", "cog", ["hot", "dot", "dog", "lot", "log"]), 0)
check("Test 3", solution.ladderLength("a", "c", ["a", "b", "c"]), 2)

/*
 Follow-up Questions:
 1. Why is BFS preferred over DFS for finding shortest paths?
 2. How would you optimize with bidirectional BFS?
 3. How would you return the actual transformation sequence (LC 126)?
 */
