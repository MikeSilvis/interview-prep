/**
 * 139. Word Break
 * https://leetcode.com/problems/word-break/
 */

class Solution018 {
    fun wordBreak(s: String, wordDict: List<String>): Boolean {
        // TODO: Implement Word Break
        return false
    }
}

private fun checkWordBreak(label: String, actual: Boolean, expected: Boolean) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution018()
    checkWordBreak(
        "Word Break – Test 1",
        solution.wordBreak("leetcode", listOf("leet", "code")),
        true,
    )
    checkWordBreak(
        "Word Break – Test 2",
        solution.wordBreak("applepenapple", listOf("apple", "pen")),
        true,
    )
    checkWordBreak(
        "Word Break – Test 3",
        solution.wordBreak("catsandog", listOf("cats", "dog", "sand", "and", "cat")),
        false,
    )
}

