## Linked Lists

Think of this chapter as your **playground for pointer manipulation**. You’ll practice rewiring `next` pointers, reasoning about references vs values, and applying a few core templates that cover most interview questions in this space.

---

### Why this matters in interviews

- Classic structure for **pointer manipulation** questions.
- Tests your understanding of **references vs values**, especially in languages like Swift.
- Many canonical problems (reverse list, detect cycle, merge lists) are easy once you know the patterns, but easy to fumble under pressure.

---

### How to study this chapter

- Before coding, **draw the list** and mentally walk through reversing it, finding the middle, or merging two lists. Practice until you can see the transformations clearly.
- Memorize just **one clean template** for each pattern (reverse, fast/slow, merge). You don’t need multiple variations; you need one you can write without thinking.
- When you get a new problem, ask: “Is this really just a twist on **reverse**, **fast/slow**, **merge**, or **reorder**?” If so, lean on that template instead of improvising pointer logic from scratch.

---

### Core concepts

- **Singly vs doubly linked lists**
  - Singly: node has `value` and `next`.
  - Doubly: node has `value`, `prev`, and `next` (more flexible, more memory).
- **Complexities**
  - Access by index: \(O(n)\) – requires traversal.
  - Insert/delete at head: \(O(1)\).
  - Insert/delete in middle: \(O(1)\) once you have a reference to the node (but \(O(n)\) to find it).
- **Sentinel (dummy) nodes**
  - A “fake” head or tail node used to simplify insertion/deletion logic and avoid special cases.
- **Fast/slow pointers**
  - Two pointers moving at different speeds used to detect cycles or find midpoints.

---

### Canonical patterns

#### Reverse a singly linked list (iterative)

Swift sketch:

```swift
class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int, _ next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
}

func reverseList(_ head: ListNode?) -> ListNode? {
    var prev: ListNode? = nil
    var curr = head

    while let node = curr {
        let next = node.next
        node.next = prev
        prev = node
        curr = next
    }

    return prev
}
```

Key idea: carefully update `next` pointer before re‑wiring links.

#### Find middle of list (fast/slow)

Swift sketch:

```swift
func middleNode(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head

    while fast != nil, fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
    }

    return slow
}
```

#### Detect cycle (Floyd’s algorithm)

Swift sketch:

```swift
func hasCycle(_ head: ListNode?) -> Bool {
    var slow = head
    var fast = head

    while fast != nil, fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        if slow === fast {
            return true
        }
    }

    return false
}

func cycleStart(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head

    while fast != nil, fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        if slow === fast {
            break
        }
    }

    guard slow === fast, let _ = slow else { return nil }

    slow = head
    while slow !== fast {
        slow = slow?.next
        fast = fast?.next
    }
    return slow
}
```

#### Merge two sorted lists

Swift sketch:

```swift
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    let dummy = ListNode(0)
    var tail: ListNode? = dummy
    var a = l1
    var b = l2

    while let na = a, let nb = b {
        if na.val <= nb.val {
            tail?.next = na
            a = na.next
        } else {
            tail?.next = nb
            b = nb.next
        }
        tail = tail?.next
    }

    tail?.next = a ?? b
    return dummy.next
}
```

---

### Common gotchas & tradeoffs

- **Losing the rest of the list**
  - When reversing or deleting nodes, always save `next` **before** rewiring pointers. A missing temporary is the fastest way to “leak” the tail of the list.
- **Infinite loops due to bad rewiring**
  - One wrong assignment can create a cycle. If your loop never terminates, suspect a pointer was set to the wrong node rather than `nil`.
- **Forgetting dummy (sentinel) nodes**
  - Dummy heads/tails dramatically simplify insert/delete logic. If you’re writing lots of `if head == nil` branches, consider a sentinel.
- **Confusing node equality vs value equality**
  - In Swift and many languages, `===` (reference equality) vs `==` (value equality) matters. For cycle detection or intersection, you care about **node identity**, not just values.
- **Recursion depth limits**
  - Recursive solutions for reversal or traversal are elegant but can blow the stack on very long lists. In interviews, mention the tradeoff and typically prefer iterative versions.
- **Practical relevance vs theoretical use**
  - In high‑level languages, arrays and slices are heavily optimized. It’s fair to say you rarely hand‑roll linked lists in production, but you still value them as a **teaching tool** for understanding pointers and memory.

---

### Interview Q&A

- **Q: When would you choose a linked list over an array?**  
  **A:** When you have lots of **insertions/deletions in the middle** and you already have references to nodes; array insertions require shifting elements. In high‑level languages, arrays are heavily optimized, so practical uses of linked lists are rarer than in theory questions.

- **Q: What’s the space/time complexity of reversing a linked list?**  
  **A:** Time \(O(n)\), space \(O(1)\) (iterative approach).

- **Q: Why might a dummy head be helpful?**  
  **A:** It avoids special cases for inserting/deleting at the head; all nodes, including the “first real one”, become part of a uniform pattern.

- **Q: How can you detect if two singly linked lists intersect?**  
  **A:** One approach: get lengths, advance the longer list’s pointer by the difference, then walk both simultaneously until they meet or reach null. Another approach: use a hash set of nodes from one list.

---

### Practice prompts

- Reverse a singly linked list.
- Given a linked list, **reorder** it `L0 → Ln → L1 → Ln-1 …` (classic reorder list).
- Merge **k** sorted linked lists into one sorted list.
- Given a linked list, remove the **n‑th node from the end** in one pass.
- Determine if a linked list is a **palindrome** using \(O(1)\) extra space.

