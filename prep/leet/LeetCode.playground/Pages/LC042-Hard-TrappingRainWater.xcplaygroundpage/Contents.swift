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
func check(_ label: String, _ actual: Int, _ expected: Int) {
    let pass = actual == expected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let solution = Solution()
check("Test 1", solution.trap([0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]), 6)
check("Test 2", solution.trap([4, 2, 0, 3, 2, 5]), 9)
check("Test 3", solution.trap([3, 0, 2, 0, 4]), 7)
check("Test 4", solution.trap([1, 2, 3, 4, 5]), 0)

/*
 Follow-up Questions:
 1. How would you solve this problem using a stack?
 2. What if the elevation map was 2D instead of 1D?
 3. How would you optimize for very sparse arrays (mostly zeros)?
 */
