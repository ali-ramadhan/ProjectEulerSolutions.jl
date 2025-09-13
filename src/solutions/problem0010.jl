"""
Project Euler Problem 10: Summation of Primes

The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
Find the sum of all the primes below two million.

## Solution approach

The problem requires summing all prime numbers below 2 million. The most efficient approach
is to use the Sieve of Eratosthenes algorithm to generate all primes up to the limit, then
sum them.

The approach:
1. Use the existing `sieve_of_eratosthenes` utility function to generate all primes
   below 2,000,000
2. Sum all the generated primes

This leverages the highly optimized sieve implementation from the utils module rather than
implementing prime generation from scratch.

## Complexity analysis

Time complexity: O(n log log n)
- The Sieve of Eratosthenes has time complexity O(n log log n) where n is the upper limit
- Summing the resulting primes is O(π(n)) where π(n) is the prime counting function

Space complexity: O(n)
- The sieve algorithm requires O(n) space to store the boolean array
- The resulting prime list requires O(π(n)) space, which is approximately O(n/log n)
"""
module Problem0010

using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes

function sum_of_primes_below(limit)
    primes = sieve_of_eratosthenes(limit)
    return primes, sum(primes)
end

function solve()
    primes, result = sum_of_primes_below(2_000_000)
    @info "Sum of $(length(primes)) primes below 2,000,000 is $result"
    return result
end

end # module
