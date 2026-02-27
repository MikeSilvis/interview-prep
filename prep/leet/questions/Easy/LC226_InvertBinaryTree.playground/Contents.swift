import Foundation

/*
 226. Invert Binary Tree

 Given the root of a binary tree, invert the tree, and return its root.

 Example:
     4                 4
    / \     →        / \
   2   7            7   2
  / \ / \          / \ / \
 1  3 6  9        9  6 3  1

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
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        // TODO: Solve
        return nil
    }
}

// Test Cases
let solution = Solution()
print("Binary Tree Inversion - implement and test with tree construction")
