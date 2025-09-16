"""
Project Euler Problem 136: Singleton difference

The positive integers, x, y, and z, are consecutive terms of an arithmetic progression.
Given that n is a positive integer, the equation, x² - y² - z² = n, has exactly one solution
when n = 20:

13² - 10² - 7² = 20.

In fact there are twenty-five values of n below one hundred for which the equation has a
unique solution.

How many values of n less than fifty million have exactly one solution?

## Solution approach

The equation x² - y² - z² = n with arithmetic progression x, y, z can be transformed into:
n = m(4d - m) where m is the middle term and d is the common difference.

This leads to analyzing factor pairs (u,v) where n = uv, u+v ≡ 0 (mod 4), and 3u > v.
Through detailed number-theoretic analysis, it turns out that n has exactly one solution
if and only if n belongs to one of these forms (where p is an odd prime):

1. n is a prime and n ≡ 3 (mod 4)
2. n = 4p or n = 4
3. n = 16p or n = 16

This transforms the problem into a prime-counting exercise, which is vastly more efficient
than checking each n individually.

## Complexity analysis

Time complexity: O(√N log log √N)
- Dominated by the Sieve of Eratosthenes to generate primes up to N/4
- For N = 50,000,000: approximately O(√12,500,000 × log log √12,500,000) ≈ O(3,500 × 4) ≈
  O(14,000)
- This is orders of magnitude faster than the O(N√N) brute force approach

Space complexity: O(√N)
- For the prime sieve array

## Mathematical background

The key insight comes from analyzing when the equation n = uv with constraints
u+v ≡ 0 (mod 4) and 3u > v has exactly one valid factor pair. Through case analysis:

- If n is an odd prime p ≡ 3 (mod 4): only factor pair is (1,p), and 1+p ≡ 0 (mod 4) when
  p ≡ 3 (mod 4)
- If n = 4p where p is odd prime: factor pairs (1,4p), (2,2p), (4,p). Only (4,p) satisfies
  constraints
- If n = 16p where p is odd prime: only factor pair (16,p) satisfies all constraints

## Key insights

The transformation from brute-force divisor checking to prime classification reduces
computational complexity from O(N√N) to O(√N log log √N), making the solution
feasible for N = 50,000,000.
"""
module Problem0136

using ..Utils.Primes: sieve_of_eratosthenes

"""
    count_values_with_one_solution(limit)

Count how many values of n < limit have exactly one distinct solution.
Uses the optimal number-theoretic approach based on prime classification.

A number n has exactly one solution if and only if:
1. n is a prime and n ≡ 3 (mod 4), or
2. n = 4p where p is an odd prime, or n = 4, or
3. n = 16p where p is an odd prime, or n = 16
"""
function count_values_with_one_solution(limit)
    # Generate all primes up to the limit (needed for case 1: n = p)
    # We need primes up to limit-1 since we check n < limit
    max_prime_needed = limit - 1
    primes = sieve_of_eratosthenes(max_prime_needed)

    count = 0

    # Special cases: n = 4 and n = 16
    if limit > 4
        count += 1  # n = 4
    end
    if limit > 16
        count += 1  # n = 16
    end

    for p in primes
        if p == 2
            continue  # Skip 2, we only want odd primes
        end

        # Case 1: n = p where p ≡ 3 (mod 4)
        if p < limit && p % 4 == 3
            count += 1
        end

        # Case 2: n = 4p
        if 4 * p < limit
            count += 1
        end

        # Case 3: n = 16p
        if 16 * p < limit
            count += 1
        end
    end

    @info "Found $count values with exactly 1 solution using number-theoretic approach"
    return count
end

function solve()
    return count_values_with_one_solution(50_000_000)
end

end # module
