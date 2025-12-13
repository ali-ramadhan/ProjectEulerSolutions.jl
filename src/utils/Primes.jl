"""
Prime number utilities for Project Euler solutions.

This module provides optimized implementations of common prime number algorithms
that are used across multiple Project Euler problems.
"""
module Primes

export is_prime, TrialDivision, MillerRabin
export sieve_of_eratosthenes, prime_factors

#####
##### Primality tests
#####

abstract type PrimalityTest end
struct TrialDivision <: PrimalityTest end
struct MillerRabin <: PrimalityTest end

is_prime(n) = is_prime(n, TrialDivision())

"""
    is_prime(n, ::TrialDivision)

Check if n is prime using trial division with 6k±1 optimization.
Only checks divisors up to sqrt(n) and filters common cases.
"""
function is_prime(n, ::TrialDivision)
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
    is_prime(n, ::MillerRabin)

Determines if `n` is prime using the deterministic Miller-Rabin test.
This function is 100% accurate for any integer n < 2^64.
"""
function is_prime(n, ::MillerRabin)
    # Handle small edge cases efficiently
    if n < 2
        return false
    elseif n == 2 || n == 3
        return true
    elseif n % 2 == 0
        return false
    end

    # Decompose n - 1 into d * 2^s
    # We want to find odd d and integer s such that n-1 = d * 2^s
    d = n - 1
    s = trailing_zeros(d) # Built-in fast bit counting
    d >>= s

    # Deterministic bases for 64-bit integers
    # Testing these specific bases guarantees correctness for n < 2^64.
    # See: https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test
    bases = (2, 3, 5, 7, 11) # (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37)

    for a in bases
        # If the base is larger than n, we don't need to test it (or further ones)
        if n <= a
            break
        end

        if is_composite_witness(n, a, d, s)
            return false
        end
    end

    return true
end

"""
    is_composite_witness(n, a, d, s)

Checks if 'a' is a witness to the compositeness of 'n'.
Returns true if 'n' is definitely composite.
Returns false if 'n' is probably prime (to base 'a').
"""
@inline function is_composite_witness(n, a, d, s)
    # Compute x = a^d mod n
    # We use built-in powermod which handles Int128 promotion internally
    # to avoid overflow during intermediate calculations.
    x = powermod(a, d, n)

    # If x = 1 or x = n-1, then 'n' passes the test for this base 'a'
    if x == 1 || x == n - 1
        return false
    end

    # Square x repeatedly up to s-1 times
    for _ in 1:(s - 1)
        # x = x^2 mod n
        # We manually promote to Int128 to ensure (x*x) doesn't overflow Int64
        x = (Int128(x) * x) % n

        # If we hit n-1, 'n' passes the test for this base
        if x == n - 1
            return false
        end
    end

    # If we finished the loop and never saw n-1 (and didn't start at 1),
    # then 'a' is a witness that 'n' is composite.
    return true
end

"""
    sieve_of_eratosthenes(limit; return_array=false)

Generate all prime numbers up to and including the given limit using the Sieve of
Eratosthenes.

This algorithm efficiently identifies primes by eliminating multiples in O(n log log n)
time.

# Arguments
- `limit`: Upper bound for prime generation
- `return_array`: If true, returns (primes, is_prime_array), otherwise just primes

# Returns
- If `return_array=false`: Vector of prime numbers
- If `return_array=true`: Tuple of (primes, boolean_array) where boolean_array[i] is true if
  i is prime

# Examples
```julia
sieve_of_eratosthenes(10)  # returns [2, 3, 5, 7]
primes, is_prime = sieve_of_eratosthenes(10, return_array=true)
```
"""
function sieve_of_eratosthenes(limit; return_array=false)
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

    primes = [i for i in 2:limit if is_prime_arr[i]]

    if return_array
        return primes, is_prime_arr
    else
        return primes
    end
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
