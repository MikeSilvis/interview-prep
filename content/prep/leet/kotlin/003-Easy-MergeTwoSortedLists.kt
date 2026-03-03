/**
 * 21. Merge Two Sorted Lists
 * https://leetcode.com/problems/merge-two-sorted-lists/
 */

class Solution003 {
    fun mergeTwoLists(list1: ListNode?, list2: ListNode?): ListNode? {
        // TODO: Implement Merge Two Sorted Lists
        return null
    }
}

private fun createLinkedList(values: List<Int>): ListNode? {
    if (values.isEmpty()) return null
    val head = ListNode(values[0])
    var current = head
    for (i in 1 until values.size) {
        current.next = ListNode(values[i])
        current = current.next!!
    }
    return head
}

private fun linkedListToList(head: ListNode?): List<Int> {
    val result = mutableListOf<Int>()
    var curr = head
    while (curr != null) {
        result.add(curr.`val`)
        curr = curr.next
    }
    return result
}

private fun checkMergeLists(label: String, actual: List<Int>, expected: List<Int>) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution003()
    checkMergeLists(
        "Merge Two Sorted Lists – Test 1",
        linkedListToList(
            solution.mergeTwoLists(
                createLinkedList(listOf(1, 2, 4)),
                createLinkedList(listOf(1, 3, 4)),
            )
        ),
        listOf(1, 1, 2, 3, 4, 4),
    )
    checkMergeLists(
        "Merge Two Sorted Lists – Test 2",
        linkedListToList(solution.mergeTwoLists(null, null)),
        emptyList(),
    )
    checkMergeLists(
        "Merge Two Sorted Lists – Test 3",
        linkedListToList(solution.mergeTwoLists(null, createLinkedList(listOf(0)))),
        listOf(0),
    )
}

