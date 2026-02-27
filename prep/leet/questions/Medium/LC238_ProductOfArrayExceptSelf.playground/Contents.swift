import Foundation

/*
 238. Product of Array Except Self

 Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].

 The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

 You must write an algorithm that runs in O(n) time and without using the division operation.

 Example 1:
 Input: nums = [1,2,3,4]
 Output: [24,12,8,6]

 Example 2:
 Input: nums = [-1,1,0,-3,3]
 Output: [0,0,9,0,0]

 Constraints:
 - 2 <= nums.length <= 10^5
 - -30 <= nums[i] <= 30
 - The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
 */

class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        // TODO: Solve
        return []
    }
}

// Test Cases
let solution = Solution()
print("Test 1: \(solution.productExceptSelf([1, 2, 3, 4]))") // Expected: [24, 12, 8, 6]
print("Test 2: \(solution.productExceptSelf([-1, 1, 0, -3, 3]))") // Expected: [0, 0, 9, 0, 0]
print("Test 3: \(solution.productExceptSelf([2, 3, 4, 5]))") // Expected: [60, 40, 30, 24]

/*
 Follow-up Questions:
 1. What if division was allowed? How would you solve it then?
 2. How would you handle the case with multiple zeros in the array?
 3. What if the array was very large and you needed to optimize for memory usage?
 */
