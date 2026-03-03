## Linked Lists

---

### Why this matters in interviews

- Classic structure for **pointer manipulation** questions.
- Tests your understanding of **references vs values**, especially in languages like Swift.
- Many canonical problems (reverse list, detect cycle, merge lists) are easy once you know the patterns, but easy to fumble under pressure.

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

