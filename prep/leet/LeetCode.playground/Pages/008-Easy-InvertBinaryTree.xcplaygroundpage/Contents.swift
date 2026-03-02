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

// Helper: level-order traversal to array for easy comparison
func treeToLevelOrder(_ root: TreeNode?) -> [Int?] {
    guard let root = root else { return [] }
    var result: [Int?] = []
    var queue: [TreeNode?] = [root]
    while !queue.compactMap({ $0 }).isEmpty {
        let node = queue.removeFirst()
        result.append(node?.val)
        if node != nil {
            queue.append(node?.left)
            queue.append(node?.right)
        }
    }
    // Trim trailing nils
    while result.last == nil { result.removeLast() }
    return result
}

func check(_ label: String, _ actual: [Int?], _ expected: [Int?]) {
    let pass = actual.count == expected.count && zip(actual, expected).allSatisfy { $0.0 == $0.1 }
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let solution = Solution()

// Test 1: [4,2,7,1,3,6,9] -> [4,7,2,9,6,3,1]
let n1 = TreeNode(1)
let n3 = TreeNode(3)
let n6 = TreeNode(6)
let n9 = TreeNode(9)
let n2 = TreeNode(2, n1, n3)
let n7 = TreeNode(7, n6, n9)
let root = TreeNode(4, n2, n7)

let result = solution.invertTree(root)
check("Test 1", treeToLevelOrder(result), [4, 7, 2, 9, 6, 3, 1])

// Test 2: empty tree
check("Test 2 (empty)", treeToLevelOrder(solution.invertTree(nil)), [])

// Test 3: single node
let single = TreeNode(1)
check("Test 3 (single)", treeToLevelOrder(solution.invertTree(single)), [1])

/*
 Follow-up Questions:
 1. How would you solve this iteratively using a queue?
 2. What is the time and space complexity of the recursive approach?
 3. How would you verify that two trees are mirrors of each other?
 */
