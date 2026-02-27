import Foundation

/*
 2. Add Two Numbers

 You are given two non-empty linked lists representing two non-negative integers.
 The digits are stored in reverse order, and each of their nodes contains a single digit.
 Add the two numbers and return the sum as a linked list.

 Example 1:
 Input: l1 = [2,4,3], l2 = [5,6,4]
 Output: [7,0,8]
 Explanation: 342 + 465 = 807.

 Example 2:
 Input: l1 = [0], l2 = [0]
 Output: [0]

 Example 3:
 Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
 Output: [8,9,9,9,0,0,0,1]

 Constraints:
 - The number of nodes in each linked list is in the range [1, 100].
 - 0 <= Node.val <= 9
 - It is guaranteed that the list represents a number that does not have leading zeros.
 */

class ListNode {
    var val: Int
    var next: ListNode?
    init() { self.val = 0; self.next = nil }
    init(_ val: Int) { self.val = val; self.next = nil }
    init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next }
}

class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // TODO: Solve
        return nil
    }
}

// Helper functions
func createLinkedList(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }
    let head = ListNode(values[0])
    var current = head
    for i in 1..<values.count {
        current.next = ListNode(values[i])
        current = current.next!
    }
    return head
}

func linkedListToArray(_ head: ListNode?) -> [Int] {
    var result: [Int] = []
    var current = head
    while current != nil {
        result.append(current!.val)
        current = current!.next
    }
    return result
}

// Test Cases
let solution = Solution()
let result1 = solution.addTwoNumbers(createLinkedList([2, 4, 3]), createLinkedList([5, 6, 4]))
print("Test 1: \(linkedListToArray(result1))") // Expected: [7, 0, 8]
