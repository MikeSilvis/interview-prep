import Foundation

/*
 21. Merge Two Sorted Lists

 You are given the heads of two sorted linked lists list1 and list2.

 Merge the two lists in a one sorted list. The list should be made by splicing together the nodes of the first two lists.

 Return the head of the merged linked list.

 Example 1:
 Input: list1 = [1,2,4], list2 = [1,3,4]
 Output: [1,1,2,3,4,4]

 Example 2:
 Input: list1 = [], list2 = []
 Output: []

 Example 3:
 Input: list1 = [], list2 = [0]
 Output: [0]

 Constraints:
 - The number of nodes in both lists is in the range [0, 50].
 - -100 <= Node.val <= 100
 - Both list1 and list2 are sorted in non-decreasing order.
 */

class ListNode {
    var val: Int
    var next: ListNode?
    init() { self.val = 0; self.next = nil }
    init(_ val: Int) { self.val = val; self.next = nil }
    init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next }
}

class Solution {
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
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
let merged1 = solution.mergeTwoLists(createLinkedList([1, 2, 4]), createLinkedList([1, 3, 4]))
print("Test 1: \(linkedListToArray(merged1))") // Expected: [1, 1, 2, 3, 4, 4]
print("Test 2: \(linkedListToArray(solution.mergeTwoLists(nil, nil)))") // Expected: []
print("Test 3: \(linkedListToArray(solution.mergeTwoLists(nil, createLinkedList([0]))))") // Expected: [0]

/*
 Follow-up Questions:
 1. How would you solve this recursively?
 2. What if you needed to merge k sorted lists instead of just two?
 3. How would you modify this to work with doubly linked lists?
 */
