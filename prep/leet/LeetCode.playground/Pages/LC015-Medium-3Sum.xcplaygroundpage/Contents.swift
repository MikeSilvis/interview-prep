import Foundation

/*
 15. 3Sum

 Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]] such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

 Notice that the solution set must not contain duplicate triplets.

 Example 1:
 Input: nums = [-1,0,1,2,-1,-4]
 Output: [[-1,-1,2],[-1,0,1]]

 Example 2:
 Input: nums = [0,1,1]
 Output: []

 Example 3:
 Input: nums = [0,0,0]
 Output: [[0,0,0]]

 Constraints:
 - 3 <= nums.length <= 3000
 - -10^5 <= nums[i] <= 10^5
 */

class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        // TODO: Solve
        return []
    }
}

// Test Cases
func check(_ label: String, _ actual: [[Int]], _ expected: [[Int]]) {
    let sortedActual = actual.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }
    let sortedExpected = expected.map { $0.sorted() }.sorted { $0.lexicographicallyPrecedes($1) }
    let pass = sortedActual == sortedExpected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let solution = Solution()
check("Test 1", solution.threeSum([-1, 0, 1, 2, -1, -4]), [[-1, -1, 2], [-1, 0, 1]])
check("Test 2", solution.threeSum([0, 1, 1]), [])
check("Test 3", solution.threeSum([0, 0, 0]), [[0, 0, 0]])

/*
 Follow-up Questions:
 1. How would you solve 4Sum with the same approach?
 2. What if the target sum was not zero but a given value k?
 3. How would you optimize for the case where many elements are the same?
 */
