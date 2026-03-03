/**
 * 146. LRU Cache
 * https://leetcode.com/problems/lru-cache/
 */

class LRUCache(private val capacity: Int) {
    // TODO: Implement LRU Cache

    fun get(key: Int): Int {
        return -1
    }

    fun put(key: Int, value: Int) {
        // TODO: Store key/value with LRU eviction
    }
}

private fun checkLRU(label: String, actual: Int, expected: Int) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val cache = LRUCache(2)
    cache.put(1, 1)
    cache.put(2, 2)
    checkLRU("LRU Cache – Test 1", cache.get(1), 1)
    cache.put(3, 3) // evicts key 2
    checkLRU("LRU Cache – Test 2", cache.get(2), -1)
    cache.put(4, 4) // evicts key 1
    checkLRU("LRU Cache – Test 3", cache.get(1), -1)
    checkLRU("LRU Cache – Test 4", cache.get(3), 3)
    checkLRU("LRU Cache – Test 5", cache.get(4), 4)
}

