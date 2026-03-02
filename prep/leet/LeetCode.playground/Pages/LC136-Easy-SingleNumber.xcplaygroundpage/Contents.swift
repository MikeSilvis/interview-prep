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
func check(_ label: String, _ actual: Int, _ expected: Int) {
    let pass = actual == expected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let solution = Solution()
check("Test 1", solution.singleNumber([2, 2, 1]), 1)
check("Test 2", solution.singleNumber([4, 1, 2, 1, 2]), 4)
check("Test 3", solution.singleNumber([1]), 1)

/*
 Follow-up Questions:
 1. What if every element appeared three times except one? (LC 137)
 2. What if there were two unique numbers instead of one? (LC 260)
 3. Why does XOR work here? Can you explain the bit manipulation?
 */
