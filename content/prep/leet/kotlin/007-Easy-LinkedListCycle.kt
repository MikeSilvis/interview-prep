/**
 * 141. Linked List Cycle
 * https://leetcode.com/problems/linked-list-cycle/
 */

class Solution007 {
    fun hasCycle(head: ListNode?): Boolean {
        // TODO: Implement Linked List Cycle detection
        return false
    }
}

private fun createLinkedListWithCycle(values: List<Int>, pos: Int): ListNode? {
    if (values.isEmpty()) return null
    val head = ListNode(values[0])
    var current = head
    var cycleNode: ListNode? = if (pos == 0) head else null

    for (i in 1 until values.size) {
        current.next = ListNode(values[i])
        current = current.next!!
        if (i == pos) cycleNode = current
    }

    if (pos >= 0) {
        current.next = cycleNode
    }

    return head
}

private fun checkHasCycle(label: String, actual: Boolean, expected: Boolean) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution007()
    checkHasCycle(
        "Linked List Cycle – Test 1",
        solution.hasCycle(createLinkedListWithCycle(listOf(3, 2, 0, -4), pos = 1)),
        true,
    )
    checkHasCycle(
        "Linked List Cycle – Test 2",
        solution.hasCycle(createLinkedListWithCycle(listOf(1, 2), pos = 0)),
        true,
    )
    checkHasCycle(
        "Linked List Cycle – Test 3",
        solution.hasCycle(createLinkedListWithCycle(listOf(1), pos = -1)),
        false,
    )
}

