"""
Project Euler Problem 31: Coin Sums

In the United Kingdom the currency is made up of pound (£) and pence (p). There are eight
coins in general circulation: 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), and £2 (200p).

It is possible to make £2 in the following way: 1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p

How many different ways can £2 be made using any number of coins?

## Solution approach

This is a classic dynamic programming problem known as the "coin change" problem. We use a
1D DP array where `ways[amount]` represents the number of ways to make that specific amount.
For each coin denomination, we iterate through all possible amounts from that coin value up
to the target, updating the number of ways by adding the ways to make `(amount -
coin_value)`.

The key insight is to process coins in order to avoid counting the same combination multiple
times (e.g., 1+2 and 2+1 are considered the same combination).

## Complexity analysis

Time complexity: O(n × m)
- Where n is the target amount (200) and m is the number of coin denominations (8)
- We iterate through each coin and for each coin, we iterate through amounts from coin_value
  to target

Space complexity: O(n)
- We use a 1D array of size (target + 1) to store the number of ways for each amount
- Only requires space proportional to the target amount, not the number of coins
"""
module Problem0031

"""
    count_coin_combinations(target, coins)

Count the number of ways to make 'target' amount using the given 'coins'.
"""
function count_coin_combinations(target, coins)
    # ways[amount+1] = ways to make 'amount'
    ways = zeros(Int, target + 1)

    # Base case: 1 way to make 0 (use no coins)
    ways[1] = 1

    for coin in coins
        for amount in coin:target
            ways[amount + 1] += ways[amount + 1 - coin]
        end
    end

    return ways[target + 1]
end

function solve()
    coins = [1, 2, 5, 10, 20, 50, 100, 200]
    target = 200
    result = count_coin_combinations(target, coins)
    @info "Found $result ways to make £2!"
    return result
end

end # module
