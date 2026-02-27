import Foundation

/*
 15. 3Sum

 Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

 Notice that the solution set must not contain duplicate triplets.

 Example 1:
 Input: nums = [-1,0,1,2,-1,-4]
 Output: [[-1,-1,2],[-1,0,1]]

 Example 2:
 Input: nums = [0,1,1]
 Output: []

 Example 3:
 Input: nums = [0,0,0]
 Output: [[0,0,0]]

 Constraints:
 - 3 <= nums.length <= 3000
 - -10^5 <= nums[i] <= 10^5
 */

class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        // TODO: Solve
        return []
    }
}

// Test Cases
let solution = Solution()
print("Test 1: \(solution.threeSum([-1, 0, 1, 2, -1, -4]))") // Expected: [[-1, -1, 2], [-1, 0, 1]]
print("Test 2: \(solution.threeSum([0, 1, 1]))") // Expected: []
print("Test 3: \(solution.threeSum([0, 0, 0]))") // Expected: [[0, 0, 0]]

/*
 Follow-up Questions:
 1. How would you solve 4Sum with the same approach?
 2. What if the target sum was not zero but a given value k?
 3. How would you optimize for the case where many elements are the same?
 */
