"""
Prime number utilities for Project Euler solutions.

This module provides optimized implementations of common prime number algorithms
that are used across multiple Project Euler problems.
"""
module Primes

export is_prime, sieve_of_eratosthenes, prime_factors

"""
    is_prime(n)

Check if n is prime using trial division with 6k±1 optimization.
Only checks divisors up to sqrt(n) and filters common cases.
"""
function is_prime(n)
    n <= 1 && return false
    n <= 3 && return true

    if n % 2 == 0 || n % 3 == 0
        return false
    end

    # Check divisibility by numbers of form 6k±1 up to sqrt(n)
    i = 5
    while i^2 <= n
        if n % i == 0 || n % (i + 2) == 0
            return false
        end
        i += 6
    end

    return true
end

"""
    sieve_of_eratosthenes(limit)

Generate all prime numbers up to and including the given limit using the Sieve of Eratosthenes.
Returns a list of prime numbers.

This algorithm efficiently identifies primes by eliminating multiples in O(n log log n) time.

Example: sieve_of_eratosthenes(10) returns [2, 3, 5, 7]
"""
function sieve_of_eratosthenes(limit)
    is_prime_arr = fill(true, limit)
    is_prime_arr[1] = false

    for i in 2:isqrt(limit)
        if is_prime_arr[i]
            # Mark all multiples of i as non-prime
            for j in (i ^ 2):i:limit
                is_prime_arr[j] = false
            end
        end
    end

    return [i for i in 2:limit if is_prime_arr[i]]
end

"""
    prime_factors(n)

Get the prime factorization of n.
Returns a vector of prime factors (with repetition for powers).
"""
function prime_factors(n)
    factors = Int[]

    while n % 2 == 0
        push!(factors, 2)
        n ÷= 2
    end

    # Handle odd factors
    factor = 3
    while factor^2 <= n
        while n % factor == 0
            push!(factors, factor)
            n ÷= factor
        end
        factor += 2
    end

    # If n > 1, then n is a prime factor itself
    if n > 1
        push!(factors, n)
    end

    return factors
end

end # module Primes
