"""
Project Euler Problem 77: Prime Summations

It is possible to write ten as the sum of primes in exactly five different ways:
7 + 3
5 + 5
5 + 3 + 2
3 + 3 + 2 + 2
2 + 2 + 2 + 2 + 2

What is the first value which can be written as the sum of primes in over five thousand
different ways?

## Solution approach

This is a variation of the coin change problem where "coins" are prime numbers. We use
dynamic programming to count the number of ways to express each integer as a sum of primes.

For each prime p and each amount n ≥ p, we add ways[n-p] to ways[n], representing the number
of ways to make amount n by including prime p.

## Complexity analysis

Time complexity: O(n * π(n))
- For each of the π(n) primes up to n, we iterate through amounts up to n

Space complexity: O(n)
- Array to store the number of ways for each amount up to the maximum check value
"""
module Problem077

using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes

"""
    find_first_with_over_n_ways(n_ways, max_check=100000)

Find the first integer that can be written as a sum of primes in over n_ways different ways.
"""
function find_first_with_over_n_ways(n_ways, max_check = 100000)
    primes = sieve_of_eratosthenes(max_check)

    # ways[i] = number of ways to make a sum of i-1
    # So ways[1] represents 0, ways[2] represents 1, etc.
    ways = zeros(Int, max_check+1)
    ways[1] = 1  # Base case: one way to make a sum of 0 (use no primes)

    # Dynamic programming approach similar to coin change problem
    for prime in primes
        for amount in prime:max_check
            ways[amount + 1] += ways[amount + 1 - prime]
        end
    end

    # Find the first value with over n_ways different prime summations
    for n in 2:max_check
        if ways[n + 1] > n_ways
            return n
        end
    end

    return -1  # Indicates we need to check higher numbers
end

function solve()
    result = find_first_with_over_n_ways(5000)
    @info "First number with over 5000 ways to be written as sum of primes: $result"
    return result
end

end # module
