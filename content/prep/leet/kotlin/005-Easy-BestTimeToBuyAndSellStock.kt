/**
 * 121. Best Time to Buy and Sell Stock
 * https://leetcode.com/problems/best-time-to-buy-and-sell-stock/
 */

class Solution005 {
    fun maxProfit(prices: IntArray): Int {
        // TODO: Implement Best Time to Buy and Sell Stock
        return 0
    }
}

private fun checkMaxProfit(label: String, actual: Int, expected: Int) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution005()
    checkMaxProfit("Best Time to Buy and Sell Stock – Test 1", solution.maxProfit(intArrayOf(7, 1, 5, 3, 6, 4)), 5)
    checkMaxProfit("Best Time to Buy and Sell Stock – Test 2", solution.maxProfit(intArrayOf(7, 6, 4, 3, 1)), 0)
}

