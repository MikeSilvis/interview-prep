/**
 * 76. Minimum Window Substring
 * https://leetcode.com/problems/minimum-window-substring/
 */

class Solution026 {
    fun minWindow(s: String, t: String): String {
        // TODO: Implement Minimum Window Substring
        return ""
    }
}

private fun checkMinWindow(label: String, actual: String, expected: String) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution026()
    checkMinWindow("Minimum Window Substring – Test 1", solution.minWindow("ADOBECODEBANC", "ABC"), "BANC")
    checkMinWindow("Minimum Window Substring – Test 2", solution.minWindow("a", "a"), "a")
    checkMinWindow("Minimum Window Substring – Test 3", solution.minWindow("a", "aa"), "")
}

