import Foundation

/*
 4. Median of Two Sorted Arrays

 Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.

 The overall run time complexity should be O(log (m+n)).

 Example 1:
 Input: nums1 = [1,3], nums2 = [2]
 Output: 2.00000
 Explanation: merged array = [1,2,3] and median is 2.

 Example 2:
 Input: nums1 = [1,2], nums2 = [3,4]
 Output: 2.50000
 Explanation: merged array = [1,2,3,4] and median is (2 + 3) / 2 = 2.5.

 Constraints:
 - nums1.length == m
 - nums2.length == n
 - 0 <= m <= 1000
 - 0 <= n <= 1000
 - 1 <= m + n <= 2000
 - -10^6 <= nums1[i], nums2[i] <= 10^6
 */

class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        // TODO: Solve
        return 0.0
    }
}

// Test Cases
let solution = Solution()
print("Test 1: \(solution.findMedianSortedArrays([1, 3], [2]))") // Expected: 2.0
print("Test 2: \(solution.findMedianSortedArrays([1, 2], [3, 4]))") // Expected: 2.5
print("Test 3: \(solution.findMedianSortedArrays([0, 0], [0, 0]))") // Expected: 0.0

/*
 Follow-up Questions:
 1. How would you handle the case where one array is much larger than the other?
 2. What if the arrays contained duplicate values?
 3. How would you modify this to find the kth smallest element instead?
 */
