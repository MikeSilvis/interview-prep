/**
 * 283. Move Zeroes
 * https://leetcode.com/problems/move-zeroes/
 */

class Solution010 {
    fun moveZeroes(nums: IntArray) {
        // TODO: Implement Move Zeroes (in-place)
    }
}

private fun checkMoveZeroes(label: String, nums: IntArray, expected: IntArray) {
    val pass = nums.contentEquals(expected)
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=${nums.toList()}, expected=${expected.toList()}")
}

fun main() {
    val solution = Solution010()
    val a = intArrayOf(0, 1, 0, 3, 12)
    solution.moveZeroes(a)
    checkMoveZeroes("Move Zeroes – Test 1", a, intArrayOf(1, 3, 12, 0, 0))

    val b = intArrayOf(0)
    solution.moveZeroes(b)
    checkMoveZeroes("Move Zeroes – Test 2", b, intArrayOf(0))
}

