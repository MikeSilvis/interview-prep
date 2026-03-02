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
        var writeIndex = 0

        for i in 0..<nums.count {
            let currentNumber = nums[i]

            if currentNumber != 0 {
                nums[writeIndex] = currentNumber
                writeIndex = writeIndex + 1
            }
        }

        for i in writeIndex..<nums.count {
            nums[i] = 0
        }
    }
}

// Test Cases
func check(_ label: String, _ actual: [Int], _ expected: [Int]) {
    let pass = actual == expected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

func testMoveZeroes(_ input: [Int]) -> [Int] {
    var nums = input
    let solution = Solution()
    solution.moveZeroes(&nums)
    return nums
}

check("Test 1", testMoveZeroes([0, 1, 0, 3, 12]), [1, 3, 12, 0, 0])
check("Test 2", testMoveZeroes([0]), [0])
check("Test 3", testMoveZeroes([1, 2, 3]), [1, 2, 3])
check("Test 4", testMoveZeroes([0, 0, 1]), [1, 0, 0])

/*
 Follow-up Questions:
 1. Can you do this with a single pass using swaps?
 2. What if you needed to minimize the number of write operations?
 3. How would this change if you needed to move a different value (not zero)?
 */
