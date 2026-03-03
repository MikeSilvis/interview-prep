/**
 * 32. Longest Valid Parentheses
 * https://leetcode.com/problems/longest-valid-parentheses/
 */

class Solution023 {
    fun longestValidParentheses(s: String): Int {
        // TODO: Implement Longest Valid Parentheses
        return 0
    }
}

private fun checkLongestValidParentheses(label: String, actual: Int, expected: Int) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution023()
    checkLongestValidParentheses(
        "Longest Valid Parentheses – Test 1",
        solution.longestValidParentheses("(()"),
        2,
    )
    checkLongestValidParentheses(
        "Longest Valid Parentheses – Test 2",
        solution.longestValidParentheses(")()())"),
        4,
    )
}

