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
 */

class Solution {
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        /*
         Approach: Binary Search on Smaller Array
         - Ensure nums1 is the smaller array for efficiency
         - Use binary search to find the correct partition
         - Partition such that left half has same size as right half
         - Check if partition is valid and adjust accordingly

         Time Complexity: O(log(min(m, n))) - binary search on smaller array
         Space Complexity: O(1) - only using constant extra space
         */

        let A = nums1.count <= nums2.count ? nums1 : nums2
        let B = nums1.count <= nums2.count ? nums2 : nums1

        let m = A.count
        let n = B.count
        let total = m + n
        let half = (total + 1) / 2

        var left = 0
        var right = m

        while left <= right {
            let partitionA = (left + right) / 2
            let partitionB = half - partitionA

            let maxLeftA = partitionA == 0 ? Int.min : A[partitionA - 1]
            let minRightA = partitionA == m ? Int.max : A[partitionA]

            let maxLeftB = partitionB == 0 ? Int.min : B[partitionB - 1]
            let minRightB = partitionB == n ? Int.max : B[partitionB]

            if maxLeftA <= minRightB && maxLeftB <= minRightA {
                // Found correct partition
                if total % 2 == 1 {
                    return Double(max(maxLeftA, maxLeftB))
                } else {
                    return Double(max(maxLeftA, maxLeftB) + min(minRightA, minRightB)) / 2.0
                }
            } else if maxLeftA > minRightB {
                right = partitionA - 1
            } else {
                left = partitionA + 1
            }
        }

        return 0.0 // Should never reach here
    }
}

// Test Cases
let solution = Solution()

// Test Case 1
print("Test 1: \(solution.findMedianSortedArrays([1, 3], [2]))") // Expected: 2.0

// Test Case 2
print("Test 2: \(solution.findMedianSortedArrays([1, 2], [3, 4]))") // Expected: 2.5

// Test Case 3
print("Test 3: \(solution.findMedianSortedArrays([0, 0], [0, 0]))") // Expected: 0.0

/*
 Follow-up Questions:
 1. How would you handle the case where one array is much larger than the other?
 2. What if the arrays contained duplicate values?
 3. How would you modify this to find the kth smallest element instead?
 */