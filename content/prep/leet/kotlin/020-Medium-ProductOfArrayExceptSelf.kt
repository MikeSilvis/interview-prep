/**
 * 238. Product of Array Except Self
 * https://leetcode.com/problems/product-of-array-except-self/
 */

class Solution020 {
    fun productExceptSelf(nums: IntArray): IntArray {
        // TODO: Implement Product of Array Except Self
        return IntArray(nums.size)
    }
}

private fun checkProductExceptSelf(label: String, actual: IntArray, expected: IntArray) {
    val pass = actual.contentEquals(expected)
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=${actual.toList()}, expected=${expected.toList()}")
}

fun main() {
    val solution = Solution020()
    checkProductExceptSelf(
        "Product of Array Except Self – Test 1",
        solution.productExceptSelf(intArrayOf(1, 2, 3, 4)),
        intArrayOf(24, 12, 8, 6),
    )
    checkProductExceptSelf(
        "Product of Array Except Self – Test 2",
        solution.productExceptSelf(intArrayOf(-1, 1, 0, -3, 3)),
        intArrayOf(0, 0, 9, 0, 0),
    )
}

