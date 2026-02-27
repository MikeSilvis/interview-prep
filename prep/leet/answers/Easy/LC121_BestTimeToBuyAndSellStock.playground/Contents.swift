import Foundation

/*
 121. Best Time to Buy and Sell Stock

 You are given an array prices where prices[i] is the price of a given stock on the ith day.

 You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

 Return the maximum profit you can achieve from this transaction.
 */

class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 1 else { return 0 }

        var minPrice = prices[0]
        var maxProfit = 0

        for price in prices {
            if price < minPrice {
                minPrice = price
            } else {
                maxProfit = max(maxProfit, price - minPrice)
            }
        }

        return maxProfit
    }
}

// Test Cases
let solution = Solution()
print("Test 1: \(solution.maxProfit([7, 1, 5, 3, 6, 4]))") // Expected: 5
print("Test 2: \(solution.maxProfit([7, 6, 4, 3, 1]))") // Expected: 0
