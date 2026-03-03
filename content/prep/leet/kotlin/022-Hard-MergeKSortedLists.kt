/**
 * 23. Merge k Sorted Lists
 * https://leetcode.com/problems/merge-k-sorted-lists/
 */

class Solution022 {
    fun mergeKLists(lists: Array<ListNode?>): ListNode? {
        // TODO: Implement Merge k Sorted Lists
        return null
    }
}

private fun listToLinkedList022(values: List<Int>): ListNode? {
    if (values.isEmpty()) return null
    val head = ListNode(values[0])
    var current = head
    for (i in 1 until values.size) {
        current.next = ListNode(values[i])
        current = current.next!!
    }
    return head
}

private fun linkedListToList022(head: ListNode?): List<Int> {
    val result = mutableListOf<Int>()
    var curr = head
    while (curr != null) {
        result.add(curr.`val`)
        curr = curr.next
    }
    return result
}

private fun checkMergeKLists(label: String, actual: List<Int>, expected: List<Int>) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution022()
    val lists = arrayOf(
        listToLinkedList022(listOf(1, 4, 5)),
        listToLinkedList022(listOf(1, 3, 4)),
        listToLinkedList022(listOf(2, 6)),
    )
    checkMergeKLists(
        "Merge k Sorted Lists – Test 1",
        linkedListToList022(solution.mergeKLists(lists)),
        listOf(1, 1, 2, 3, 4, 4, 5, 6),
    )
}

