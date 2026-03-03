/**
 * 15. 3Sum
 * https://leetcode.com/problems/3sum/
 */

class Solution015 {
    fun threeSum(nums: IntArray): List<List<Int>> {
        // TODO: Implement 3Sum
        return emptyList()
    }
}

private fun checkThreeSum(label: String, actual: List<List<Int>>, expected: Set<Set<Int>>) {
    val actualSet = actual.map { it.toSet() }.toSet()
    val pass = actualSet == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actualSet, expected=$expected")
}

fun main() {
    val solution = Solution015()
    checkThreeSum(
        "3Sum – Test 1",
        solution.threeSum(intArrayOf(-1, 0, 1, 2, -1, -4)),
        setOf(setOf(-1, -1, 2), setOf(-1, 0, 1)),
    )
    checkThreeSum(
        "3Sum – Test 2",
        solution.threeSum(intArrayOf(0, 1, 1)),
        emptySet(),
    )
}

