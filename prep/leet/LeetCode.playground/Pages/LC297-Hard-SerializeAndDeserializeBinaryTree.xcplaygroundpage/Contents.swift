import Foundation

/*
 297. Serialize and Deserialize Binary Tree

 Serialization is the process of converting a data structure or object into a sequence of bits
 so that it can be stored in a file or memory buffer, or transmitted across a network connection
 link to be reconstructed later in the same or another computer environment.

 Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how
 your serialization/deserialization algorithm should work. You just need to ensure that a binary
 tree can be serialized to a string and this string can be deserialized to the original tree structure.

 Example 1:
 Input: root = [1,2,3,null,null,4,5]
       1
      / \
     2   3
        / \
       4   5
 Output: [1,2,3,null,null,4,5]

 Example 2:
 Input: root = []
 Output: []

 Constraints:
 - The number of nodes in the tree is in the range [0, 10^4].
 - -1000 <= Node.val <= 1000
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

class Codec {
    func serialize(_ root: TreeNode?) -> String {
        // TODO: Solve
        return ""
    }

    func deserialize(_ data: String) -> TreeNode? {
        // TODO: Solve
        return nil
    }
}

// Helper: level-order traversal to array for comparison
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
    while result.last == nil { result.removeLast() }
    return result
}

func check(_ label: String, _ actual: [Int?], _ expected: [Int?]) {
    let pass = actual.count == expected.count && zip(actual, expected).allSatisfy { $0.0 == $0.1 }
    print("\(pass ? "✅ PASS" : "❌ FAIL") \(label): got \(actual), expected \(expected)")
}

let codec = Codec()

// Test 1: [1,2,3,null,null,4,5]
let n4 = TreeNode(4)
let n5 = TreeNode(5)
let n2 = TreeNode(2)
let n3 = TreeNode(3, n4, n5)
let root1 = TreeNode(1, n2, n3)

let serialized1 = codec.serialize(root1)
let deserialized1 = codec.deserialize(serialized1)
check("Test 1 (roundtrip)", treeToLevelOrder(deserialized1), [1, 2, 3, nil, nil, 4, 5])

// Test 2: empty tree
let serialized2 = codec.serialize(nil)
let deserialized2 = codec.deserialize(serialized2)
check("Test 2 (empty)", treeToLevelOrder(deserialized2), [])

// Test 3: single node
let single = TreeNode(42)
let serialized3 = codec.serialize(single)
let deserialized3 = codec.deserialize(serialized3)
check("Test 3 (single)", treeToLevelOrder(deserialized3), [42])

/*
 Follow-up Questions:
 1. What traversal order do you use for serialization and why?
 2. How do you handle null nodes in your serialized format?
 3. What is the time and space complexity of your approach?
 */
