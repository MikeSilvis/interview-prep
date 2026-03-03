/**
 * 49. Group Anagrams
 * https://leetcode.com/problems/group-anagrams/
 */

class Solution016 {
    fun groupAnagrams(strs: Array<String>): List<List<String>> {
        // TODO: Implement Group Anagrams
        return emptyList()
    }
}

private fun checkGroupAnagrams(label: String, actual: List<List<String>>, expected: Set<Set<String>>) {
    val actualSet = actual.map { it.toSet() }.toSet()
    val pass = actualSet == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actualSet, expected=$expected")
}

fun main() {
    val solution = Solution016()
    checkGroupAnagrams(
        "Group Anagrams – Test 1",
        solution.groupAnagrams(arrayOf("eat", "tea", "tan", "ate", "nat", "bat")),
        setOf(setOf("eat", "tea", "ate"), setOf("tan", "nat"), setOf("bat")),
    )
}

