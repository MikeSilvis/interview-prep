import Foundation

/*
 23. Merge k Sorted Lists

 You are given an array of k linked-lists lists, each linked-list is sorted in ascending order.

 Merge all the linked-lists into one sorted linked-list and return it.

 Example 1:
 Input: lists = [[1,4,5],[1,3,4],[2,6]]
 Output: [1,1,2,3,4,4,5,6]

 Example 2:
 Input: lists = []
 Output: []

 Example 3:
 Input: lists = [[]]
 Output: []

 Constraints:
 - k == lists.length
 - 0 <= k <= 10^4
 - 0 <= lists[i].length <= 500
 - -10^4 <= lists[i][j] <= 10^4
 - lists[i] is sorted in ascending order.
 - The sum of lists[i].length will not exceed 10^4.
 */

class ListNode {
    var val: Int
    var next: ListNode?
    init() { self.val = 0; self.next = nil }
    init(_ val: Int) { self.val = val; self.next = nil }
    init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next }
}

class Solution {
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
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
func check(_ label: String, _ actual: [Int], _ expected: [Int]) {
    let pass = actual == expected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let solution = Solution()
let lists1 = [createLinkedList([1, 4, 5]), createLinkedList([1, 3, 4]), createLinkedList([2, 6])]
check("Test 1", linkedListToArray(solution.mergeKLists(lists1)), [1, 1, 2, 3, 4, 4, 5, 6])
check("Test 2", linkedListToArray(solution.mergeKLists([])), [])
check("Test 3", linkedListToArray(solution.mergeKLists([nil])), [])

/*
 Follow-up Questions:
 1. How would you solve this with a min-heap / priority queue?
 2. What is the divide-and-conquer approach and its complexity?
 3. How does this compare to merging lists one by one?
 */
