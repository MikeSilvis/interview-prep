/**
 * 136. Single Number
 * https://leetcode.com/problems/single-number/
 */

class Solution006 {
    fun singleNumber(nums: IntArray): Int {
        // TODO: Implement Single Number
        return 0
    }
}

private fun checkSingleNumber(label: String, actual: Int, expected: Int) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution006()
    checkSingleNumber("Single Number – Test 1", solution.singleNumber(intArrayOf(2, 2, 1)), 1)
    checkSingleNumber("Single Number – Test 2", solution.singleNumber(intArrayOf(4, 1, 2, 1, 2)), 4)
}

