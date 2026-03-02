import Foundation

/*
 70. Climbing Stairs

 You are climbing a staircase. It takes n steps to reach the top.

 Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

 Example 1:
 Input: n = 2
 Output: 2
 Explanation: There are two ways to climb to the top.
 1. 1 step + 1 step
 2. 2 steps

 Example 2:
 Input: n = 3
 Output: 3
 Explanation: There are three ways to climb to the top.
 1. 1 step + 1 step + 1 step
 2. 1 step + 2 steps
 3. 2 steps + 1 step

 Constraints:
 - 1 <= n <= 45
 */

class Solution {
    static let oneStair = 1
    static let twoSteps = 2
    
    func climbStairs(_ target: Int) -> Int {
        compositions(target: target, using: [1,2]).count
    }
    
     func compositions(target: Int, using parts: [Int]) -> [[Int]] {
          if target == 0 { return [[]] }
          if target < 0 { return [] }

          var results: [[Int]] = []
         
          for part in parts {
              let subResults = compositions(target: target - part, using: parts)
              for combo in subResults {
                  results.append([part] + combo)
              }
          }
          return results
      }
}

// Test Cases
let solution = Solution()
//print("Test 1: \(solution.climbStairs(2))") // Expected: 2
//print("Test 2: \(solution.climbStairs(3))") // Expected: 3

// 1 1 1 1 1
// 2 2 2 2
// 2 1 1 1 1 1 1
// 2 2 1 1 1
// 2 2 2 1 1
print("Test 3: \(solution.climbStairs(5))") // Expected: 8
