/**
 * 242. Valid Anagram
 * https://leetcode.com/problems/valid-anagram/
 */

class Solution009 {
    fun isAnagram(s: String, t: String): Boolean {
        // TODO: Implement Valid Anagram
        return false
    }
}

private fun checkValidAnagram(label: String, actual: Boolean, expected: Boolean) {
    val pass = actual == expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected=$expected")
}

fun main() {
    val solution = Solution009()
    checkValidAnagram("Valid Anagram – Test 1", solution.isAnagram("anagram", "nagaram"), true)
    checkValidAnagram("Valid Anagram – Test 2", solution.isAnagram("rat", "car"), false)
}

