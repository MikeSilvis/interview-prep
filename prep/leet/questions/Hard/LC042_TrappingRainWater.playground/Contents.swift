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
        // TODO: Solve
        return 0
    }
}

// Test Cases
let solution = Solution()
print("Test 1: \(solution.trap([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]))") // Expected: 6
print("Test 2: \(solution.trap([4, 2, 0, 3, 2, 5]))") // Expected: 9
print("Test 3: \(solution.trap([3, 0, 2, 0, 4]))") // Expected: 7

/*
 Follow-up Questions:
 1. How would you solve this problem using a stack?
 2. What if the elevation map was 2D instead of 1D?
 3. How would you optimize for very sparse arrays (mostly zeros)?
 */
