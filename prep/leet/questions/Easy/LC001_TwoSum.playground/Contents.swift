import Foundation

/*
 1. Two Sum

 Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

 You may assume that each input would have exactly one solution, and you may not use the same element twice.

 You can return the answer in any order.

 Example 1:
 Input: nums = [2,7,11,15], target = 9
 Output: [0,1]
 Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

 Example 2:
 Input: nums = [3,2,4], target = 6
 Output: [1,2]

 Example 3:
 Input: nums = [3,3], target = 6
 Output: [0,1]

 Constraints:
 - 2 <= nums.length <= 10^4
 - -10^9 <= nums[i] <= 10^9
 - -10^9 <= target <= 10^9
 - Only one valid answer exists.
 */

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        for (index, num) in nums.enumerated() {
            for (nestedIndex, nestedNums) in nums.enumerated() {
                if index != nestedIndex, num + nestedNums == target {
                    return [index, nestedIndex]
                }
            }
        }
        
        fatalError()
    }
}

// Test Cases
let solution = Solution()
print("Test 1: \(solution.twoSum([2, 7, 11, 15], 9))") // Expected: [0, 1]
print("Test 2: \(solution.twoSum([3, 2, 4], 6))") // Expected: [1, 2]
print("Test 3: \(solution.twoSum([3, 3], 6))") // Expected: [0, 1]

/*
 Follow-up Questions:
 1. What if the array is sorted? Could we use two pointers approach?
 2. What if we need to return all pairs that sum to target (not just indices)?
 3. How would you handle the case where no solution exists?
 */
