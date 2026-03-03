/**
 * 127. Word Ladder
 * https://leetcode.com/problems/word-ladder/
 */

class Solution027 {
    fun ladderLength(beginWord: String, endWord: String, wordList: List<String>): Int {
        // TODO: Implement Word Ladder
        return 0
    }
}

private fun checkWordLadder(label: String, actual: Int, expected: Int) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution027()
    checkWordLadder(
        "Word Ladder – Test 1",
        solution.ladderLength(
            "hit",
            "cog",
            listOf("hot", "dot", "dog", "lot", "log", "cog"),
        ),
        5,
    )
    checkWordLadder(
        "Word Ladder – Test 2",
        solution.ladderLength(
            "hit",
            "cog",
            listOf("hot", "dot", "dog", "lot", "log"),
        ),
        0,
    )
}

