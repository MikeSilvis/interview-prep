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

class LRUCache {
    init(_ capacity: Int) {
        // TODO: Implement
    }

    func get(_ key: Int) -> Int {
        // TODO: Implement
        return -1
    }

    func put(_ key: Int, _ value: Int) {
        // TODO: Implement
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

/*
 Follow-up Questions:
 1. How would you implement an LFU (Least Frequently Used) cache?
 2. What if you needed to support TTL (Time To Live) for cache entries?
 3. How would you make this thread-safe for concurrent access?
 */
