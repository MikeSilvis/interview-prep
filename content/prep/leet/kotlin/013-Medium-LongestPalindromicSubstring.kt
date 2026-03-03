/**
 * 5. Longest Palindromic Substring
 * https://leetcode.com/problems/longest-palindromic-substring/
 */

class Solution013 {
    fun longestPalindrome(s: String): String {
        // TODO: Implement Longest Palindromic Substring
        return ""
    }
}

private fun checkLongestPalindrome(label: String, actual: String, expected: Set<String>) {
    val pass = actual in expected
    println("${if (pass) "✅ PASS" else "❌ FAIL"} $label: got=$actual, expected one of $expected")
}

fun main() {
    val solution = Solution013()
    checkLongestPalindrome("Longest Palindrome – Test 1", solution.longestPalindrome("babad"), setOf("bab", "aba"))
    checkLongestPalindrome("Longest Palindrome – Test 2", solution.longestPalindrome("cbbd"), setOf("bb"))
}

