import Foundation

/*
 283. Move Zeroes

 Given an integer array nums, move all 0s to the end of it while maintaining the relative order of the non-zero elements.

 Note: You must do this in-place without making a copy of the array.

 Example 1:
 Input: nums = [0,1,0,3,12]
 Output: [1,3,12,0,0]

 Example 2:
 Input: nums = [0]
 Output: [0]

 Constraints:
 - 1 <= nums.length <= 10^4
 - -2^31 <= nums[i] <= 2^31 - 1
 */

class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        // TODO: Solve
    }
}

// Test Cases
func testMoveZeroes(_ input: [Int]) -> [Int] {
    var nums = input
    let solution = Solution()
    solution.moveZeroes(&nums)
    return nums
}

print("Test 1: \(testMoveZeroes([0, 1, 0, 3, 12]))") // Expected: [1, 3, 12, 0, 0]
print("Test 2: \(testMoveZeroes([0]))") // Expected: [0]
