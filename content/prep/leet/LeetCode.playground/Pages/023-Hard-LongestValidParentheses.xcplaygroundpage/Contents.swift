import Foundation

/*
 32. Longest Valid Parentheses

 Given a string containing just the characters '(' and ')', return the length of the longest
 valid (well-formed) parentheses substring.

 Example 1:
 Input: s = "(()"
 Output: 2
 Explanation: The longest valid parentheses substring is "()".

 Example 2:
 Input: s = ")()())"
 Output: 4
 Explanation: The longest valid parentheses substring is "()()".

 Example 3:
 Input: s = ""
 Output: 0

 Constraints:
 - 0 <= s.length <= 3 * 10^4
 - s[i] is '(' or ')'.
 */

class Solution {
    func longestValidParentheses(_ s: String) -> Int {
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
check("Test 1", solution.longestValidParentheses("(()"), 2)
check("Test 2", solution.longestValidParentheses(")()())"), 4)
check("Test 3", solution.longestValidParentheses(""), 0)
check("Test 4", solution.longestValidParentheses("()(()"), 2)

/*
 Follow-up Questions:
 1. How would you solve this using a stack?
 2. How does the DP approach work here?
 3. Can you solve it in O(1) space with two passes (left-to-right, right-to-left)?
 */
