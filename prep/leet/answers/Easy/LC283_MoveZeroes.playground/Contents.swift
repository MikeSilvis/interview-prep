import Foundation

/*
 283. Move Zeroes

 Given an integer array nums, move all 0s to the end of it while maintaining the relative order of the non-zero elements.
 */

class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        var writeIndex = 0

        for readIndex in 0..<nums.count {
            if nums[readIndex] != 0 {
                nums[writeIndex] = nums[readIndex]
                writeIndex += 1
            }
        }

        while writeIndex < nums.count {
            nums[writeIndex] = 0
            writeIndex += 1
        }
    }
}

func testMoveZeroes(_ input: [Int]) -> [Int] {
    var nums = input
    let solution = Solution()
    solution.moveZeroes(&nums)
    return nums
}

print("Test 1: \(testMoveZeroes([0, 1, 0, 3, 12]))") // Expected: [1, 3, 12, 0, 0]
