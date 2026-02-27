import Foundation

/*
 136. Single Number

 Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.
 */

class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var result = 0
        for num in nums {
            result ^= num
        }
        return result
    }
}

// Test Cases
let solution = Solution()
print("Test 1: \(solution.singleNumber([2, 2, 1]))") // Expected: 1
print("Test 2: \(solution.singleNumber([4, 1, 2, 1, 2]))") // Expected: 4
