import Foundation

/*
 141. Linked List Cycle

 Given head, the head of a linked list, determine if the linked list has a cycle in it.

 There is a cycle in a linked list if there is some node in the list that can be reached again
 by continuously following the next pointer.

 Return true if there is a cycle in the linked list. Otherwise, return false.

 Constraints:
 - The number of nodes in the list is in the range [0, 10^4].
 - -10^5 <= Node.val <= 10^5
 */

class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}

class Solution {
    func hasCycle(_ head: ListNode?) -> Bool {
        // TODO: Solve
        return false
    }
}

// Test Cases
let solution = Solution()
print("Linked List Cycle - implement and test with manual node wiring")
