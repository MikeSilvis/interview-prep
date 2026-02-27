import Foundation

/*
 141. Linked List Cycle

 Given head, the head of a linked list, determine if the linked list has a cycle in it.
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
        guard let head = head else { return false }

        var slow: ListNode? = head
        var fast: ListNode? = head

        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next

            if slow === fast {
                return true
            }
        }

        return false
    }
}

// Test creation
let solution = Solution()
print("Linked List Cycle solution created")
