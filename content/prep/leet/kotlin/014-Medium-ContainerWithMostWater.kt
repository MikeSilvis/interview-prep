/**
 * 11. Container With Most Water
 * https://leetcode.com/problems/container-with-most-water/
 */

class Solution014 {
    fun maxArea(height: IntArray): Int {
        // TODO: Implement Container With Most Water
        return 0
    }
}

private fun checkMaxArea(label: String, actual: Int, expected: Int) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution014()
    checkMaxArea(
        "Container With Most Water – Test 1",
        solution.maxArea(intArrayOf(1, 8, 6, 2, 5, 4, 8, 3, 7)),
        49,
    )
    checkMaxArea("Container With Most Water – Test 2", solution.maxArea(intArrayOf(1, 1)), 1)
}

