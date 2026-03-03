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
        var fast = head?.next?.next
        var slow = head?.next

        while fast != nil, fast?.next != nil {
            if fast === slow {
                return true
            }

            fast = fast?.next?.next
            slow = slow?.next
        }

        return false
    }
}

// Test Cases
func check(_ label: String, _ actual: Bool, _ expected: Bool) {
    let pass = actual == expected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let solution = Solution()

// Test 1: [3,2,0,-4] with cycle at pos 1
let n3 = ListNode(3)
let n2 = ListNode(2)
let n0 = ListNode(0)
let n4 = ListNode(-4)
n3.next = n2; n2.next = n0; n0.next = n4; n4.next = n2
check("Test 1 (cycle)", solution.hasCycle(n3), true)

// Test 2: [1,2] with cycle at pos 0
let a1 = ListNode(1)
let a2 = ListNode(2)
a1.next = a2; a2.next = a1
check("Test 2 (cycle)", solution.hasCycle(a1), true)

// Test 3: [1] no cycle
let b1 = ListNode(1)
check("Test 3 (no cycle)", solution.hasCycle(b1), false)

// Test 4: empty list
check("Test 4 (empty)", solution.hasCycle(nil), false)

/*
 Follow-up Questions:
 1. Can you find the node where the cycle begins? (LC 142)
 2. What is the space complexity of Floyd's algorithm vs. using a hash set?
 3. How would you remove the cycle if one exists?
 */
