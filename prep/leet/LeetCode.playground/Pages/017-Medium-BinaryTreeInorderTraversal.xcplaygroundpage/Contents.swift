import Foundation

/*
 94. Binary Tree Inorder Traversal

 Given the root of a binary tree, return the inorder traversal of its nodes' values.

 Inorder: Left → Root → Right

 Example 1:
 Input: root = [1,null,2,3]
       1
        \
         2
        /
       3
 Output: [1,3,2]

 Example 2:
 Input: root = []
 Output: []

 Example 3:
 Input: root = [1]
 Output: [1]

 Constraints:
 - The number of nodes in the tree is in the range [0, 100].
 - -100 <= Node.val <= 100
 */

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init() { self.val = 0; self.left = nil; self.right = nil }
    init(_ val: Int) { self.val = val; self.left = nil; self.right = nil }
    init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

class Solution {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        // TODO: Solve
        return []
    }
}

// Test Cases
func check(_ label: String, _ actual: [Int], _ expected: [Int]) {
    let pass = actual == expected
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let solution = Solution()

// Test 1: [1,null,2,3] -> [1,3,2]
let n3 = TreeNode(3)
let n2 = TreeNode(2, n3, nil)
let root1 = TreeNode(1, nil, n2)
check("Test 1", solution.inorderTraversal(root1), [1, 3, 2])

// Test 2: empty tree
check("Test 2 (empty)", solution.inorderTraversal(nil), [])

// Test 3: single node
check("Test 3 (single)", solution.inorderTraversal(TreeNode(1)), [1])

// Test 4: full tree [1,2,3] -> [2,1,3]
let left = TreeNode(2)
let right = TreeNode(3)
let root4 = TreeNode(1, left, right)
check("Test 4", solution.inorderTraversal(root4), [2, 1, 3])

/*
 Follow-up Questions:
 1. Can you solve this iteratively using a stack?
 2. What is Morris traversal and how does it achieve O(1) space?
 3. How do preorder, inorder, and postorder traversals differ?
 */
