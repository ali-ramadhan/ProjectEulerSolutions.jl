"""
Project Euler Problem 31: Coin Sums

In the United Kingdom the currency is made up of pound (£) and pence (p). There are eight coins in general circulation:
1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), and £2 (200p).

It is possible to make £2 in the following way:
1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p

How many different ways can £2 be made using any number of coins?
"""
module Problem031

"""
    count_coin_combinations(target, coins)

Count the number of ways to make 'target' amount using the given 'coins'.
Uses dynamic programming to efficiently solve this classic coin change problem.

This approach iterates through each coin denomination and updates the ways array:
- ways[amount+1] represents the number of ways to make 'amount' pence
- For each coin and amount combination, we add the number of ways to make
  (amount - coin) to the current count for amount
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
    return count_coin_combinations(target, coins)
end

end # module
