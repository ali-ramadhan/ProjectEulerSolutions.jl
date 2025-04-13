"""
Project Euler Problem 77: Prime Summations

It is possible to write ten as the sum of primes in exactly five different ways:
7 + 3
5 + 5
5 + 3 + 2
3 + 3 + 2 + 2
2 + 2 + 2 + 2 + 2

What is the first value which can be written as the sum of primes in over five thousand different ways?
"""
module Problem077

"""
    sieve_of_eratosthenes(limit)

Generate all prime numbers up to the given limit using the Sieve of Eratosthenes algorithm.
Returns an array of prime numbers up to `limit`.
"""
function sieve_of_eratosthenes(limit)
    is_prime = fill(true, limit)
    is_prime[1] = false
    
    for i in 2:isqrt(limit)
        if is_prime[i]
            for j in i^2:i:limit
                is_prime[j] = false
            end
        end
    end
    
    return filter(p -> is_prime[p], 1:limit)
end

"""
    find_first_with_over_n_ways(n_ways, max_check=100000)

Find the first integer that can be written as a sum of primes in over n_ways different ways.
Uses dynamic programming to count the number of ways for each integer.

This is essentially a variation of the coin change problem where the "coins" are prime numbers.
"""
function find_first_with_over_n_ways(n_ways, max_check=100000)
    primes = sieve_of_eratosthenes(max_check)
    
    # ways[i] = number of ways to make a sum of i-1
    # So ways[1] represents 0, ways[2] represents 1, etc.
    ways = zeros(Int, max_check+1)
    ways[1] = 1  # Base case: one way to make a sum of 0 (use no primes)
    
    # Dynamic programming approach similar to coin change problem
    for prime in primes
        for amount in prime:max_check
            ways[amount+1] += ways[amount+1-prime]
        end
    end
    
    # Find the first value with over n_ways different prime summations
    for n in 2:max_check
        if ways[n+1] > n_ways
            return n
        end
    end
    
    return -1  # Indicates we need to check higher numbers
end

function solve()
    return find_first_with_over_n_ways(5000)
end

end # module
