/**
 * 4. Median of Two Sorted Arrays
 * https://leetcode.com/problems/median-of-two-sorted-arrays/
 *
 * For clarity in this study workbook, this implementation uses a simple merge
 * in O(m + n) time instead of the optimal O(log(min(m, n))) approach.
 */

class Solution021 {
    fun findMedianSortedArrays(nums1: IntArray, nums2: IntArray): Double {
        // TODO: Implement Median of Two Sorted Arrays
        return 0.0
    }
}

private fun checkMedian(label: String, actual: Double, expected: Double) {
    val pass = kotlin.math.abs(actual - expected) < 1e-5
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution021()
    checkMedian(
        "Median of Two Sorted Arrays – Test 1",
        solution.findMedianSortedArrays(intArrayOf(1, 3), intArrayOf(2)),
        2.0,
    )
    checkMedian(
        "Median of Two Sorted Arrays – Test 2",
        solution.findMedianSortedArrays(intArrayOf(1, 2), intArrayOf(3, 4)),
        2.5,
    )
}

