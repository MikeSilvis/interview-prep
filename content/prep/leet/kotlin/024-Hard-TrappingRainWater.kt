/**
 * 42. Trapping Rain Water
 * https://leetcode.com/problems/trapping-rain-water/
 */

class Solution024 {
    fun trap(height: IntArray): Int {
        // TODO: Implement Trapping Rain Water
        return 0
    }
}

private fun checkTrappingRainWater(label: String, actual: Int, expected: Int) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution024()
    checkTrappingRainWater(
        "Trapping Rain Water – Test 1",
        solution.trap(intArrayOf(0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1)),
        6,
    )
    checkTrappingRainWater(
        "Trapping Rain Water – Test 2",
        solution.trap(intArrayOf(4, 2, 0, 3, 2, 5)),
        9,
    )
}

