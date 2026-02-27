import Foundation

/*
 3. Longest Substring Without Repeating Characters

 Given a string s, find the length of the longest substring without repeating characters.
 */

class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        let chars = Array(s)
        var charIndexMap: [Character: Int] = [:]
        var maxLength = 0
        var left = 0

        for right in 0..<chars.count {
            let currentChar = chars[right]

            if let lastIndex = charIndexMap[currentChar], lastIndex >= left {
                left = lastIndex + 1
            }

            charIndexMap[currentChar] = right
            maxLength = max(maxLength, right - left + 1)
        }

        return maxLength
    }
}

let solution = Solution()
print("Test 1: \(solution.lengthOfLongestSubstring("abcabcbb"))") // Expected: 3
