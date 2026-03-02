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
        var result = Array(repeating: 1, count: nums.count)

        var leftProduct = 1
        for i in 0..<nums.count {
            result[i] = leftProduct
            leftProduct *= nums[i]
        }

        var rightProduct = 1
        for i in stride(from: nums.count - 1, through: 0, by: -1) {
            result[i] *= rightProduct
            rightProduct *= nums[i]
        }

        return result
    }
}

// Test Cases
func check(_ label: String, _ actual: [Int], _ expected: [Int]) {
    let pass = actual == expected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let solution = Solution()
check("Test 1", solution.productExceptSelf([1, 2, 3, 4]), [24, 12, 8, 6])
check("Test 2", solution.productExceptSelf([-1, 1, 0, -3, 3]), [0, 0, 9, 0, 0])
check("Test 3", solution.productExceptSelf([2, 3, 4, 5]), [60, 40, 30, 24])

/*
 Follow-up Questions:
 1. Can you solve it with O(1) extra space (excluding the output array)?
 2. How would you handle this if division was allowed?
 3. What happens with multiple zeros in the array?
 */
