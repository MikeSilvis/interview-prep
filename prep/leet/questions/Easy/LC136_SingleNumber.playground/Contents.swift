import Foundation

/*
 136. Single Number

 Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.

 You must implement a solution with a linear runtime complexity and use only constant extra space.

 Example 1:
 Input: nums = [2,2,1]
 Output: 1

 Example 2:
 Input: nums = [4,1,2,1,2]
 Output: 4

 Example 3:
 Input: nums = [1]
 Output: 1

 Constraints:
 - 1 <= nums.length <= 3 * 10^4
 - -3 * 10^4 <= nums[i] <= 3 * 10^4
 - Each element appears twice except for one element which appears only once.
 */

class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        nums.reduce(0) { $0 ^ $1 }
    }
}

// Test Cases
let solution = Solution()
print("Test 1: \(solution.singleNumber([2, 2, 1]))") // Expected: 1
print("Test 2: \(solution.singleNumber([4, 1, 2, 1, 2]))") // Expected: 4
