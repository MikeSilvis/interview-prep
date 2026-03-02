import Foundation

/*
 226. Invert Binary Tree

 Given the root of a binary tree, invert the tree, and return its root.

 Example:
     4                4
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
        var initialLeft = root?.left
        
        root?.left = invertTree(root?.right)
        root?.right = invertTree(initialLeft)
        
        return root
    }
}

// Pretty print a tree level by level
func printTree(_ root: TreeNode?, label: String = "") {
    if !label.isEmpty { print(label) }
    guard let root = root else {
        print("(empty)")
        return
    }

    var queue: [TreeNode?] = [root]
    while !queue.compactMap({ $0 }).isEmpty {
        let line = queue.map { node in
            node != nil ? "\(node!.val)" : "·"
        }.joined(separator: "  ")
        print(line)

        var next: [TreeNode?] = []
        for node in queue {
            if node != nil {
                next.append(node?.left)
                next.append(node?.right)
            }
        }
        queue = next
    }
    
    print()
}

// Test Cases
let solution = Solution()
print("Binary Tree Inversion - implement and test with tree construction")

// Build the example tree:
//       4
//      / \
//     2   7
//    / \ / \
//   1  3 6  9
let n1 = TreeNode(1)
let n3 = TreeNode(3)
let n6 = TreeNode(6)
let n9 = TreeNode(9)
let n2 = TreeNode(2, n1, n3)
let n7 = TreeNode(7, n6, n9)
let root = TreeNode(4, n2, n7)

printTree(root, label: "Before:")

let result = solution.invertTree(root)

printTree(result, label: "After:")
