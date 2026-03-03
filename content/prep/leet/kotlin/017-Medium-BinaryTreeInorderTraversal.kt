/**
 * 94. Binary Tree Inorder Traversal
 * https://leetcode.com/problems/binary-tree-inorder-traversal/
 */

class Solution017 {
    fun inorderTraversal(root: TreeNode?): List<Int> {
        // TODO: Implement Binary Tree Inorder Traversal
        return emptyList()
    }
}

private fun treeFromLevelOrder017(values: List<Int?>): TreeNode? {
    if (values.isEmpty() || values[0] == null) return null
    val root = TreeNode(values[0]!!)
    val queue: ArrayDeque<TreeNode> = ArrayDeque()
    queue.add(root)
    var i = 1
    while (i < values.size && queue.isNotEmpty()) {
        val node = queue.removeFirst()
        if (i < values.size) {
            val leftVal = values[i++]
            if (leftVal != null) {
                node.left = TreeNode(leftVal)
                queue.add(node.left!!)
            }
        }
        if (i < values.size) {
            val rightVal = values[i++]
            if (rightVal != null) {
                node.right = TreeNode(rightVal)
                queue.add(node.right!!)
            }
        }
    }
    return root
}

private fun checkInorderTraversal(label: String, actual: List<Int>, expected: List<Int>) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution017()
    val root = treeFromLevelOrder017(listOf(1, null, 2, null, null, 3))
    checkInorderTraversal(
        "Binary Tree Inorder Traversal – Test 1",
        solution.inorderTraversal(root),
        listOf(1, 3, 2),
    )
}

