/**
 * 2. Add Two Numbers
 * https://leetcode.com/problems/add-two-numbers/
 */

class Solution011 {
    fun addTwoNumbers(l1: ListNode?, l2: ListNode?): ListNode? {
        // TODO: Implement Add Two Numbers
        return null
    }
}

private fun listToLinkedList(values: List<Int>): ListNode? {
    if (values.isEmpty()) return null
    val head = ListNode(values[0])
    var current = head
    for (i in 1 until values.size) {
        current.next = ListNode(values[i])
        current = current.next!!
    }
    return head
}

private fun linkedListToList011(head: ListNode?): List<Int> {
    val result = mutableListOf<Int>()
    var curr = head
    while (curr != null) {
        result.add(curr.`val`)
        curr = curr.next
    }
    return result
}

private fun checkAddTwoNumbers(label: String, actual: List<Int>, expected: List<Int>) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution011()
    checkAddTwoNumbers(
        "Add Two Numbers – Test 1",
        linkedListToList011(
            solution.addTwoNumbers(
                listToLinkedList(listOf(2, 4, 3)),
                listToLinkedList(listOf(5, 6, 4)),
            )
        ),
        listOf(7, 0, 8),
    )
    checkAddTwoNumbers(
        "Add Two Numbers – Test 2",
        linkedListToList011(
            solution.addTwoNumbers(
                listToLinkedList(listOf(0)),
                listToLinkedList(listOf(0)),
            )
        ),
        listOf(0),
    )
}

