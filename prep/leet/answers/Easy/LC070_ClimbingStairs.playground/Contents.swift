import Foundation

/*
 70. Climbing Stairs

 You are climbing a staircase. It takes n steps to reach the top.

 Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
 */

class Solution {
    func climbStairs(_ n: Int) -> Int {
        guard n > 1 else { return 1 }

        var first = 1  // ways to reach step 1
        var second = 2 // ways to reach step 2

        for _ in 3...n {
            let current = first + second
            first = second
            second = current
        }

        return second
    }
}

// Test Cases
let solution = Solution()
print("Test 1: \(solution.climbStairs(2))") // Expected: 2
print("Test 2: \(solution.climbStairs(3))") // Expected: 3
print("Test 3: \(solution.climbStairs(5))") // Expected: 8
