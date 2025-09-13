"""
Project Euler Problem 35: Circular Primes

The number, 197, is called a circular prime because all rotations of the digits: 197, 971,
and 719, are themselves prime. There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13,
17, 31, 37, 71, 73, 79, and 97. How many circular primes are there below one million?

## Solution approach

We first generate all primes below 1,000,000 using the Sieve of Eratosthenes for efficient
prime checking. Then for each prime, we check if it's circular by generating all digit
rotations and verifying they're all prime.

Key optimizations:
1. Single-digit primes (2,3,5,7) are circular by definition
2. Multi-digit primes containing even digits (0,2,4,6,8) cannot be circular, as some
   rotation would be even
3. We use utility functions for digit rotations and even-digit checking to avoid code
   duplication

The algorithm iterates through all generated primes and counts those that pass the circular
prime test.

## Complexity analysis

Time complexity: O(n log log n + p × d × log n)
- O(n log log n) for sieve generation where n = 1,000,000
- O(p × d × log n) for circular prime checking, where p is the number of primes, d is
  average digits per prime
- The log n factor comes from primality lookups in the boolean array
- Dominated by the sieve generation

Space complexity: O(n)
- O(n) for the boolean prime array where n = 1,000,000
- O(p) for storing the list of primes where p ≈ n/ln(n) ≈ 72,000 for n = 1,000,000
- Total space is linear in the input limit
"""
module Problem0035

using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes
using ProjectEulerSolutions.Utils.Digits: digit_rotations, has_even_digit


"""
    is_circular_prime(n, is_prime)

Check if n is a circular prime using the boolean primality array.
"""
function is_circular_prime(n, is_prime)
    if n >= length(is_prime) || !is_prime[n]
        return false
    end

    # Single-digit primes are circular by definition
    if n < 10
        return true
    end

    if has_even_digit(n)
        return false
    end

    for rotation in digit_rotations(n)
        if rotation >= length(is_prime) || !is_prime[rotation]
            return false
        end
    end

    return true
end

"""
    count_circular_primes_below(limit)

Count the number of circular primes below the given limit.
"""
function count_circular_primes_below(limit)
    primes, is_prime_arr = sieve_of_eratosthenes(limit, return_array=true)

    count = 0
    for prime in primes
        if is_circular_prime(prime, is_prime_arr)
            count += 1
        end
    end

    @info "Found $count circular primes below $limit"

    return count
end

function solve()
    return count_circular_primes_below(1_000_000)
end

end # module
