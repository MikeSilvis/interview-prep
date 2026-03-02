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

// Definition for singly-linked list
class ListNode {
    var val: Int
    var next: ListNode?

    init() {
        self.val = 0
        self.next = nil
    }

    init(_ val: Int) {
        self.val = val
        self.next = nil
    }

    init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
    }
}

class Solution {
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        /*
         Approach: Two Pointers with Dummy Head
         - Create a dummy head to simplify edge cases
         - Use two pointers to traverse both lists
         - At each step, choose the smaller value and advance that pointer
         - Attach any remaining nodes from the non-empty list

         Time Complexity: O(m + n) - visit each node once
         Space Complexity: O(1) - only using constant extra space
         */

        let dummy = ListNode(0)
        var current = dummy
        var l1 = list1
        var l2 = list2

        while l1 != nil && l2 != nil {
            if l1!.val <= l2!.val {
                current.next = l1
                l1 = l1!.next
            } else {
                current.next = l2
                l2 = l2!.next
            }
            current = current.next!
        }

        // Attach remaining nodes
        current.next = l1 ?? l2

        return dummy.next
    }
}

// Helper function to create a linked list from array
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

// Helper function to convert linked list to array for testing
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

// Test Case 1
let list1 = createLinkedList([1, 2, 4])
let list2 = createLinkedList([1, 3, 4])
let merged1 = solution.mergeTwoLists(list1, list2)
print("Test 1: \(linkedListToArray(merged1))") // Expected: [1, 1, 2, 3, 4, 4]

// Test Case 2
let merged2 = solution.mergeTwoLists(nil, nil)
print("Test 2: \(linkedListToArray(merged2))") // Expected: []

// Test Case 3
let list3 = createLinkedList([0])
let merged3 = solution.mergeTwoLists(nil, list3)
print("Test 3: \(linkedListToArray(merged3))") // Expected: [0]

/*
 Follow-up Questions:
 1. How would you solve this recursively?
 2. What if you needed to merge k sorted lists instead of just two?
 3. How would you modify this to work with doubly linked lists?
 */
