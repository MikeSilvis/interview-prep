## Trees & BSTs

---

### Why this matters in interviews

- Tree questions test your comfort with **recursion, traversal, and structural thinking**.
- BST questions add ordering constraints and are a bridge to **search and range query** problems.
- Many graph, recursion, and DP problems can be **rephrased as trees**, so this is high‑leverage study.

---

### Core concepts

- **Tree terminology**
  - Root, parent, child, sibling, leaf, depth, height, subtree.
- **Traversal orders**
  - Depth‑first: **pre‑order, in‑order, post‑order**.
  - Breadth‑first: **level‑order** using a queue.
- **BST property**
  - For any node: all values in left subtree \< node value \< all values in right subtree (assuming strict ordering).
- **Complexities**
  - Balanced BST: search/insert/delete in \(O(\log n)\).
  - Skewed BST: worst‑case \(O(n)\).

---

### Canonical patterns

#### DFS recursion template

Most tree problems can be solved with a simple recursion skeleton.

Swift sketch (maximum depth):

```swift
class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}

func maxDepth(_ root: TreeNode?) -> Int {
    guard let node = root else { return 0 }
    let leftDepth = maxDepth(node.left)
    let rightDepth = maxDepth(node.right)
    return max(leftDepth, rightDepth) + 1
}
```

The same pattern applies to **height, diameter, balanced tree checks, sums, path properties**, etc.

#### BFS level‑order traversal

Use when you need answers **by level** (e.g., right side view, zigzag order, average per level).

Swift sketch:

```swift
func levelOrder(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else { return [] }

    var result: [[Int]] = []
    var queue: [TreeNode] = [root]
    var head = 0

    while head < queue.count {
        let levelSize = queue.count - head
        var level: [Int] = []

        for _ in 0..<levelSize {
            let node = queue[head]
            head += 1
            level.append(node.val)
            if let left = node.left { queue.append(left) }
            if let right = node.right { queue.append(right) }
        }

        result.append(level)
    }

    return result
}
```

#### BST search & insert

Swift sketch:

```swift
func searchBST(_ root: TreeNode?, _ target: Int) -> TreeNode? {
    var node = root
    while let current = node {
        if target == current.val {
            return current
        } else if target < current.val {
            node = current.left
        } else {
            node = current.right
        }
    }
    return nil
}

func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let root = root else {
        return TreeNode(val)
    }

    if val < root.val {
        root.left = insertIntoBST(root.left, val)
    } else {
        root.right = insertIntoBST(root.right, val)
    }
    return root
}
```

#### Validate BST

Pass down **min/max bounds**:

Swift sketch:

```swift
func isValidBST(_ root: TreeNode?) -> Bool {
    func helper(_ node: TreeNode?, _ minVal: Int?, _ maxVal: Int?) -> Bool {
        guard let node = node else { return true }
        if let minVal = minVal, node.val <= minVal { return false }
        if let maxVal = maxVal, node.val >= maxVal { return false }
        return helper(node.left, minVal, node.val) &&
               helper(node.right, node.val, maxVal)
    }

    return helper(root, nil, nil)
}
```

---

### Interview Q&A

- **Q: When would you choose recursion vs explicit stack for tree traversal?**  
  **A:** Recursion is simpler and fine for most interview problems; explicit stacks help when you need **iterative control**, avoid stack overflow, or match a specific traversal order while tracking extra state.

- **Q: What makes a tree “balanced”?**  
  **A:** A common definition: for every node, the heights of left and right subtrees differ by at most 1. There are other balance criteria (e.g., AVL, red‑black), but this is the usual interview one.

- **Q: How do you get sorted order from a BST?**  
  **A:** Perform an **in‑order traversal** (left, node, right) to visit nodes in ascending order.

- **Q: What’s the complexity of searching in a balanced BST?**  
  **A:** \(O(\log n)\) time, \(O(1)\) extra space (iterative) or \(O(h)\) call stack (recursive), where \(h\) is tree height.

---

### Practice prompts

- Compute the **maximum depth** of a binary tree.
- Check if a binary tree is **height‑balanced**.
- Given a BST and a value, **insert** the value and return the tree.
- Given a BST, find the **lowest common ancestor** of two nodes.
- Given a binary tree, return the **right side view** (nodes you can see from the right).

