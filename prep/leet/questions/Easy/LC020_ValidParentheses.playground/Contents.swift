import Foundation

/*
 20. Valid Parentheses

 Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

 An input string is valid if:
 1. Open brackets must be closed by the same type of brackets.
 2. Open brackets must be closed in the correct order.
 3. Every close bracket has a corresponding open bracket of the same type.

 Example 1:
 Input: s = "()"
 Output: true

 Example 2:
 Input: s = "()[]{}"
 Output: true

 Example 3:
 Input: s = "(]"
 Output: false

 Constraints:
 - 1 <= s.length <= 10^4
 - s consists of parentheses only '()[]{}'.
 */

class Solution {
    func isValid(_ s: String) -> Bool {
        // TODO: Solve
        return false
    }
}

// Test Cases
let solution = Solution()
print("Test 1: \(solution.isValid("()"))") // Expected: true
print("Test 2: \(solution.isValid("()[]{}"))") // Expected: true
print("Test 3: \(solution.isValid("(]"))") // Expected: false
print("Test 4: \(solution.isValid("([)]"))") // Expected: false
print("Test 5: \(solution.isValid("{[]}"))") // Expected: true

/*
 Follow-up Questions:
 1. How would you modify this to handle nested parentheses with different rules?
 2. What if we also needed to validate mathematical expressions?
 3. How would you optimize for memory if the input string is very large?
 */
