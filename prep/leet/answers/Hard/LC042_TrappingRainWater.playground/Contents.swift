import Foundation

/*
 42. Trapping Rain Water

 Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.

 Example 1:
 Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
 Output: 6
 Explanation: The elevation map is represented by array [0,1,0,2,1,0,1,3,2,1,2,1]. In this case, 6 units of rain water are being trapped.

 Example 2:
 Input: height = [4,2,0,3,2,5]
 Output: 9

 Constraints:
 - n == height.length
 - 1 <= n <= 2 * 10^4
 - 0 <= height[i] <= 3 * 10^4
 */

class Solution {
    func trap(_ height: [Int]) -> Int {
        /*
         Approach: Two Pointers
         - Use two pointers from both ends moving toward center
         - Keep track of max height seen from left and right
         - Water level at any point is min(leftMax, rightMax) - current height
         - Move the pointer with smaller max height

         Time Complexity: O(n) - single pass through array
         Space Complexity: O(1) - only using constant extra space
         */

        guard height.count > 2 else { return 0 }

        var left = 0
        var right = height.count - 1
        var leftMax = 0
        var rightMax = 0
        var waterTrapped = 0

        while left < right {
            if height[left] < height[right] {
                if height[left] >= leftMax {
                    leftMax = height[left]
                } else {
                    waterTrapped += leftMax - height[left]
                }
                left += 1
            } else {
                if height[right] >= rightMax {
                    rightMax = height[right]
                } else {
                    waterTrapped += rightMax - height[right]
                }
                right -= 1
            }
        }

        return waterTrapped
    }

    // Alternative DP approach (for comparison)
    func trapDP(_ height: [Int]) -> Int {
        guard height.count > 2 else { return 0 }

        let n = height.count
        var leftMax = Array(repeating: 0, count: n)
        var rightMax = Array(repeating: 0, count: n)

        // Fill leftMax array
        leftMax[0] = height[0]
        for i in 1..<n {
            leftMax[i] = max(leftMax[i - 1], height[i])
        }

        // Fill rightMax array
        rightMax[n - 1] = height[n - 1]
        for i in (0..<n - 1).reversed() {
            rightMax[i] = max(rightMax[i + 1], height[i])
        }

        // Calculate trapped water
        var waterTrapped = 0
        for i in 0..<n {
            waterTrapped += min(leftMax[i], rightMax[i]) - height[i]
        }

        return waterTrapped
    }
}

// Test Cases
let solution = Solution()

// Test Case 1
print("Test 1: \(solution.trap([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]))") // Expected: 6

// Test Case 2
print("Test 2: \(solution.trap([4, 2, 0, 3, 2, 5]))") // Expected: 9

// Test Case 3
print("Test 3: \(solution.trap([3, 0, 2, 0, 4]))") // Expected: 10

// Test DP approach
print("DP Test: \(solution.trapDP([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]))") // Expected: 6

/*
 Follow-up Questions:
 1. How would you solve this problem using a stack?
 2. What if the elevation map was 2D instead of 1D?
 3. How would you optimize for very sparse arrays (mostly zeros)?
 */