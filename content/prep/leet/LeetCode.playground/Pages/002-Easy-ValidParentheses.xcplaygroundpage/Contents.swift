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
    let checker = [
        "(" : ")",
        "[" : "]",
        "{" : "}"
    ]

    func isValid(_ s: String) -> Bool {
        let arrayOfS = Array(s)
        var desiredClosingCharacter: [String] = []

        for char in arrayOfS {
            // character is an opener
            if let closingCharactrerNeeded = checker[String(char)] {
                desiredClosingCharacter.append(closingCharactrerNeeded)
            }
            // character is a closer and has been seen
            else if desiredClosingCharacter.last == String(char) {
                desiredClosingCharacter.popLast()
            }
            // no matches
            else {
                return false
            }
        }

        return desiredClosingCharacter.count == 0
    }
}

// Test Cases
func check(_ label: String, _ actual: Bool, _ expected: Bool) {
    let pass = actual == expected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let solution = Solution()
check("Test 1", solution.isValid("()"), true)
check("Test 2", solution.isValid("()[]{}"), true)
check("Test 3", solution.isValid("(]"), false)
check("Test 4", solution.isValid("([)]"), false)
check("Test 5", solution.isValid("{[]}"), true)
check("Test 6", solution.isValid("]("), false)

/*
 Follow-up Questions:
 1. How would you modify this to handle nested parentheses with different rules?
 2. What if we also needed to validate mathematical expressions?
 3. How would you optimize for memory if the input string is very large?
 */
