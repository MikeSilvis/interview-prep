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
        /*
         Approach: Hash Map (One Pass)
         - Use a dictionary to store number -> index mapping
         - For each number, check if (target - number) exists in the map
         - If found, return both indices; otherwise store current number

         Time Complexity: O(n) - single pass through array
         Space Complexity: O(n) - for the hash map
         */

        var numToIndex: [Int: Int] = [:]

        for (index, num) in nums.enumerated() {
            let complement = target - num

            if let complementIndex = numToIndex[complement] {
                return [complementIndex, index]
            }

            numToIndex[num] = index
        }

        return []
    }
}

// Test Cases
let solution = Solution()

// Test Case 1
print("Test 1: \(solution.twoSum([2, 7, 11, 15], 9))") // Expected: [0, 1]

// Test Case 2
print("Test 2: \(solution.twoSum([3, 2, 4], 6))") // Expected: [1, 2]

// Test Case 3
print("Test 3: \(solution.twoSum([3, 3], 6))") // Expected: [0, 1]

/*
 Follow-up Questions:
 1. What if the array is sorted? Could we use two pointers approach?
 2. What if we need to return all pairs that sum to target (not just indices)?
 3. How would you handle the case where no solution exists?
 */
