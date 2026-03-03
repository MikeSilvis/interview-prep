import Foundation

/*
 11. Container With Most Water

 You are given an integer array height of length n. There are n vertical lines drawn such that
 the two endpoints of the ith line are (i, 0) and (i, height[i]).

 Find two lines that together with the x-axis form a container, such that the container
 contains the most water.

 Return the maximum amount of water a container can store.

 Notice that you may not slant the container.

 Example 1:
 Input: height = [1,8,6,2,5,4,8,3,7]
 Output: 49
 Explanation: The max area is between index 1 (height 8) and index 8 (height 7) = min(8,7) * (8-1) = 49.

 Example 2:
 Input: height = [1,1]
 Output: 1

 Constraints:
 - n == height.length
 - 2 <= n <= 10^5
 - 0 <= height[i] <= 10^4
 */

class Solution {
    func maxArea(_ height: [Int]) -> Int {
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
check("Test 1", solution.maxArea([1, 8, 6, 2, 5, 4, 8, 3, 7]), 49)
check("Test 2", solution.maxArea([1, 1]), 1)
check("Test 3", solution.maxArea([4, 3, 2, 1, 4]), 16)
check("Test 4", solution.maxArea([1, 2, 1]), 2)

/*
 Follow-up Questions:
 1. Why does moving the shorter pointer inward work?
 2. How is this different from the Trapping Rain Water problem?
 3. What is the brute force time complexity vs. two-pointer approach?
 */
