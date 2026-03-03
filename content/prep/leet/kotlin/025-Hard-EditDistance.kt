/**
 * 72. Edit Distance
 * https://leetcode.com/problems/edit-distance/
 */

class Solution025 {
    fun minDistance(word1: String, word2: String): Int {
        // TODO: Implement Edit Distance
        return 0
    }
}

private fun checkEditDistance(label: String, actual: Int, expected: Int) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution025()
    checkEditDistance("Edit Distance – Test 1", solution.minDistance("horse", "ros"), 3)
    checkEditDistance("Edit Distance – Test 2", solution.minDistance("intention", "execution"), 5)
}

