"""
Project Euler Problem 46: Goldbach's Other Conjecture

It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.

9 = 7 + 2 × 1²
15 = 7 + 2 × 2²
21 = 3 + 2 × 3²
25 = 7 + 2 × 3²
27 = 19 + 2 × 2²
33 = 31 + 2 × 1²

It turns out that the conjecture was false.

What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?
"""
module Problem046

"""
    sieve_of_eratosthenes(limit)

Generate a boolean array where is_prime[i] is true if i is prime, using the Sieve of Eratosthenes.
This efficient algorithm marks all multiples of each prime as non-prime.
"""
function sieve_of_eratosthenes(limit)
    is_prime = fill(true, limit)
    is_prime[1] = false

    for i in 2:isqrt(limit)
        if is_prime[i]
            for j in (i ^ 2):i:limit
                is_prime[j] = false
            end
        end
    end

    return is_prime
end

"""
    is_prime_plus_twice_square(n, primes, twice_squares)

Check if n can be written as the sum of a prime and twice a square.
Returns true if it satisfies Goldbach's conjecture, false otherwise.

This function tries all possible primes p less than n and checks if n-p is twice a perfect square.
Uses pre-computed lists for efficiency.
"""
function is_prime_plus_twice_square(n, primes, twice_squares)
    for p in primes
        p >= n && break

        if n - p in twice_squares
            return true
        end
    end

    return false
end

"""
    find_goldbach_counterexample()

Find the smallest odd composite number that cannot be written as the sum of a prime and twice a square,
disproving Goldbach's conjecture.

The approach:

 1. Generate primes using the Sieve of Eratosthenes
 2. Pre-compute a set of values of the form 2s² for quick lookup
 3. Check odd composite numbers sequentially until finding one that cannot be expressed
    as the sum of a prime and twice a square
"""
function find_goldbach_counterexample()
    limit = 10000
    is_prime_list = sieve_of_eratosthenes(limit)

    primes = [i for i in 2:limit if is_prime_list[i]]

    twice_squares = Set(2 * s^2 for s in 1:isqrt(limit ÷ 2))

    # Test odd composite numbers
    for n in 9:2:limit
        if is_prime_list[n]
            continue
        end

        if !is_prime_plus_twice_square(n, primes, twice_squares)
            return n
        end
    end

    return error("No solution found within the limit")
end

function solve()
    return find_goldbach_counterexample()
end

end # module
