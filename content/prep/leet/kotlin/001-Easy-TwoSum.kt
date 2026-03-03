/**
 * 1. Two Sum
 * https://leetcode.com/problems/two-sum/
 */

class Solution001 {
    fun twoSum(nums: IntArray, target: Int): IntArray {
        // TODO: Implement Two Sum
        return intArrayOf()
    }
}

private fun check(label: String, actual: IntArray, expected: IntArray) {
    val pass = actual.toSet() == expected.toSet()
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=${actual.toList()}, expected=${expected.toList()}")
}

fun main() {
    val solution = Solution001()
    check("Two Sum – Test 1", solution.twoSum(intArrayOf(2, 7, 11, 15), 9), intArrayOf(0, 1))
    check("Two Sum – Test 2", solution.twoSum(intArrayOf(3, 2, 4), 6), intArrayOf(1, 2))
    check("Two Sum – Test 3", solution.twoSum(intArrayOf(3, 3), 6), intArrayOf(0, 1))
}

