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
 */

class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        /*
         Approach: Sort + Two Pointers
         - Sort the array to enable two-pointer technique
         - For each element, use two pointers to find pairs that sum to target
         - Skip duplicates to avoid duplicate triplets

         Time Complexity: O(n²) - nested loops with two pointers
         Space Complexity: O(1) - not counting output array
         */

        guard nums.count >= 3 else { return [] }

        let sortedNums = nums.sorted()
        var result: [[Int]] = []

        for i in 0..<sortedNums.count - 2 {
            // Skip duplicate values for first element
            if i > 0 && sortedNums[i] == sortedNums[i - 1] {
                continue
            }

            let target = -sortedNums[i]
            var left = i + 1
            var right = sortedNums.count - 1

            while left < right {
                let sum = sortedNums[left] + sortedNums[right]

                if sum == target {
                    result.append([sortedNums[i], sortedNums[left], sortedNums[right]])

                    // Skip duplicates for second element
                    while left < right && sortedNums[left] == sortedNums[left + 1] {
                        left += 1
                    }
                    // Skip duplicates for third element
                    while left < right && sortedNums[right] == sortedNums[right - 1] {
                        right -= 1
                    }

                    left += 1
                    right -= 1
                } else if sum < target {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }

        return result
    }
}

// Test Cases
let solution = Solution()

// Test Case 1
print("Test 1: \(solution.threeSum([-1, 0, 1, 2, -1, -4]))") // Expected: [[-1, -1, 2], [-1, 0, 1]]

// Test Case 2
print("Test 2: \(solution.threeSum([0, 1, 1]))") // Expected: []

// Test Case 3
print("Test 3: \(solution.threeSum([0, 0, 0]))") // Expected: [[0, 0, 0]]

/*
 Follow-up Questions:
 1. How would you solve 4Sum with the same approach?
 2. What if the target sum was not zero but a given value k?
 3. How would you optimize for the case where many elements are the same?
 */