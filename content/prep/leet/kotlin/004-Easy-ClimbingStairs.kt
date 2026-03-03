/**
 * 70. Climbing Stairs
 * https://leetcode.com/problems/climbing-stairs/
 */

class Solution004 {
    fun climbStairs(n: Int): Int {
        // TODO: Implement Climbing Stairs
        return 0
    }
}

private fun checkClimbStairs(label: String, actual: Int, expected: Int) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution004()
    checkClimbStairs("Climbing Stairs – Test 1", solution.climbStairs(2), 2)
    checkClimbStairs("Climbing Stairs – Test 2", solution.climbStairs(3), 3)
    checkClimbStairs("Climbing Stairs – Test 3", solution.climbStairs(4), 5)
}

