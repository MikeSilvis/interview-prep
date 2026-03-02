import Foundation

/*
 146. LRU Cache

 Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.

 Implement the LRUCache class:
 - LRUCache(int capacity) Initialize the LRU cache with positive size capacity.
 - int get(int key) Return the value of the key if the key exists, otherwise return -1.
 - void put(int key, int value) Update the value of the key if the key exists. Otherwise, add the key-value pair to the cache. If the number of keys exceeds the capacity from this operation, evict the least recently used key.

 The functions get and put must each run in O(1) average time complexity.

 Example 1:
 Input
 ["LRUCache", "put", "put", "get", "put", "get", "put", "get", "get", "get"]
 [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]]
 Output
 [null, null, null, 1, null, -1, null, -1, 3, 4]

 Constraints:
 - 1 <= capacity <= 3000
 - 0 <= key <= 10^4
 - 0 <= value <= 10^5
 - At most 2 * 10^5 calls will be made to get and put.
 */

class Node {
    var key: Int
    var value: Int
    var prev: Node?
    var next: Node?

    init(_ key: Int, _ value: Int) {
        self.key = key
        self.value = value
    }
}

class LRUCache {
    var capacity: Int
    var size: Int = 0
    
    var cache: [Int: Node] = [:]    // key → node
    
    var head = Node(0, 0)           // dummy head (most recent side)
    var tail = Node(0, 0)           // dummy tail (least recent side)
    
    init(_ capacity: Int) {
        self.capacity = capacity
        head.next = tail
        tail.prev = head
    }

    func get(_ key: Int) -> Int {
        if let node = cache[key] {
            remove(node)
            insertAfterHead(node)
            
            return node.value
        }
       
        return -1
    }

    func put(_ key: Int, _ value: Int) {
        // Replaces an existing value
        if let node = cache[key] {
            node.value = value
            
            remove(node)
            insertAfterHead(node)
            
            return
        }
        
        if let prev = tail.prev, capacity == size {
            cache.removeValue(forKey: prev.key)
            remove(prev)
        }
        
        if capacity != size {
            size += 1
        }
        
        let newNode = Node(key, value)
        cache[key] = newNode
        insertAfterHead(newNode)
    }
    
    // Remove a node from wherever it is
    private func remove(_ node: Node) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
    }

    // Insert a node right after HEAD (making it most recent)
    private func insertAfterHead(_ node: Node) {
        node.next = head.next
        node.prev = head
        head.next?.prev = node
        head.next = node
    }
}

// Test Cases
let lruCache = LRUCache(2)
lruCache.put(1, 1)
lruCache.put(2, 2)

print("Get 1: \(lruCache.get(1))") // Expected: 1
lruCache.put(3, 3) // Evicts key 2

print("Get 2: \(lruCache.get(2))") // Expected: -1
lruCache.put(4, 4) // Evicts key 1

print("Get 1: \(lruCache.get(1))") // Expected: -1
print("Get 3: \(lruCache.get(3))") // Expected: 3
print("Get 4: \(lruCache.get(4))") // Expected: 4

