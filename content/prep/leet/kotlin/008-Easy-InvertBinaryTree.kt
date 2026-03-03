/**
 * 226. Invert Binary Tree
 * https://leetcode.com/problems/invert-binary-tree/
 */

class Solution008 {
    fun invertTree(root: TreeNode?): TreeNode? {
        // TODO: Implement Invert Binary Tree
        return root
    }
}

private fun treeFromLevelOrder(values: List<Int?>): TreeNode? {
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

private fun levelOrder(root: TreeNode?): List<Int?> {
    if (root == null) return emptyList()
    val result = mutableListOf<Int?>()
    val queue: ArrayDeque<TreeNode?> = ArrayDeque()
    queue.add(root)
    while (queue.isNotEmpty()) {
        val node = queue.removeFirst()
        if (node == null) {
            result.add(null)
        } else {
            result.add(node.`val`)
            if (node.left != null || node.right != null) {
                queue.add(node.left)
                queue.add(node.right)
            }
        }
    }
    return result
}

private fun checkInvertTree(label: String, actual: List<Int?>, expected: List<Int?>) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution008()
    val root = treeFromLevelOrder(listOf(4, 2, 7, 1, 3, 6, 9))
    val inverted = solution.invertTree(root)
    checkInvertTree(
        "Invert Binary Tree – Test 1",
        levelOrder(inverted),
        listOf(4, 7, 2, 9, 6, 3, 1),
    )
}

