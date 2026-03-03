/**
 * 20. Valid Parentheses
 * https://leetcode.com/problems/valid-parentheses/
 */

class Solution002 {
    fun isValid(s: String): Boolean {
        // TODO: Implement Valid Parentheses
        return false
    }
}

private fun checkValidParentheses(label: String, actual: Boolean, expected: Boolean) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution002()
    checkValidParentheses("Valid Parentheses – Test 1", solution.isValid("()"), true)
    checkValidParentheses("Valid Parentheses – Test 2", solution.isValid("()[]{}"), true)
    checkValidParentheses("Valid Parentheses – Test 3", solution.isValid("(]"), false)
    checkValidParentheses("Valid Parentheses – Test 4", solution.isValid("([)]"), false)
    checkValidParentheses("Valid Parentheses – Test 5", solution.isValid("{[]}"), true)
}

