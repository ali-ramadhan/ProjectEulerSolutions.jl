"""
Project Euler Problem 31: Coin Sums

Problem description: https://projecteuler.net/problem=31
Solution description: https://aliramadhan.me/blog/project-euler/problem-0031/
"""
module Problem0031

export count_coin_combinations, solve

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
