/**
 * 3. Longest Substring Without Repeating Characters
 * https://leetcode.com/problems/longest-substring-without-repeating-characters/
 */

class Solution012 {
    fun lengthOfLongestSubstring(s: String): Int {
        // TODO: Implement Longest Substring Without Repeating Characters
        return 0
    }
}

private fun checkLongestSubstring(label: String, actual: Int, expected: Int) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution012()
    checkLongestSubstring("Longest Substring – Test 1", solution.lengthOfLongestSubstring("abcabcbb"), 3)
    checkLongestSubstring("Longest Substring – Test 2", solution.lengthOfLongestSubstring("bbbbb"), 1)
    checkLongestSubstring("Longest Substring – Test 3", solution.lengthOfLongestSubstring("pwwkew"), 3)
}

