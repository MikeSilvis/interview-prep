import Foundation

/*
 2. Add Two Numbers

 You are given two non-empty linked lists representing two non-negative integers.
 */

class ListNode {
    var val: Int
    var next: ListNode?
    init() { self.val = 0; self.next = nil; }
    init(_ val: Int) { self.val = val; self.next = nil; }
    init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummy = ListNode(0)
        var current = dummy
        var carry = 0
        var node1 = l1
        var node2 = l2

        while node1 != nil || node2 != nil || carry > 0 {
            let val1 = node1?.val ?? 0
            let val2 = node2?.val ?? 0

            let sum = val1 + val2 + carry
            carry = sum / 10
            let digit = sum % 10

            current.next = ListNode(digit)
            current = current.next!

            node1 = node1?.next
            node2 = node2?.next
        }

        return dummy.next
    }
}

let solution = Solution()
print("Add Two Numbers solution created")
