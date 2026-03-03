/**
 * 297. Serialize and Deserialize Binary Tree
 * https://leetcode.com/problems/serialize-and-deserialize-binary-tree/
 */

class Codec028 {
    // Encodes a tree to a single string.
    fun serialize(root: TreeNode?): String {
        // TODO: Implement serialize
        return ""
    }

    // Decodes your encoded data to tree.
    fun deserialize(data: String): TreeNode? {
        // TODO: Implement deserialize
        return null
    }
}

private fun levelOrder028(root: TreeNode?): List<Int?> {
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

private fun checkSerializeDeserialize(label: String, root: TreeNode?) {
    val codec = Codec028()
    val serialized = codec.serialize(root)
    val deserialized = codec.deserialize(serialized)
    val originalLevel = levelOrder028(root)
    val decodedLevel = levelOrder028(deserialized)
    val pass = originalLevel == decodedLevel
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: original=$originalLevel, decoded=$decodedLevel")
}

fun main() {
    val root = TreeNode(1,
        left = TreeNode(2),
        right = TreeNode(3,
            left = TreeNode(4),
            right = TreeNode(5),
        ),
    )
    checkSerializeDeserialize("Serialize & Deserialize Binary Tree – Test 1", root)
}

