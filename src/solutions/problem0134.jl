"""
Project Euler Problem 134: Prime Pair Connection

Consider the consecutive primes p₁ = 19 and p₂ = 23. It can be verified that 1219 is the
smallest number such that the last digits are formed by p₁ whilst also being divisible by
p₂.

In fact, with the exception of p₁ = 3 and p₂ = 5, for every pair of consecutive primes, p₂ >
p₁, there exist values of n for which the last digits are formed by p₁ and n is divisible by
p₂. Let S be the smallest of these values of n.

Find ∑S for every pair of consecutive primes with 5 ≤ p₁ ≤ 1000000.

## Solution approach

For each pair of consecutive primes (p₁, p₂), we need to find the smallest number S such
that:
1. S ends with the digits of p₁ (i.e., S ≡ p₁ (mod 10^d) where d is the number of digits in
   p₁)
2. S is divisible by p₂ (i.e., S ≡ 0 (mod p₂))

This forms a system of modular congruences:
- S ≡ p₁ (mod 10^d)
- S ≡ 0 (mod p₂)

We can solve this by expressing S = k * p₂ for some integer k, and then: k * p₂ ≡ p₁ (mod
10^d)

Using modular inverse: k ≡ p₁ * invmod(p₂, 10^d) (mod 10^d)

The smallest positive solution is S = k * p₂ where k is the smallest positive value
satisfying the congruence.

## Complexity analysis

Time complexity: O(n log log n + p log m)
- O(n log log n) for generating primes up to limit using sieve
- O(p) for iterating through prime pairs (p = number of primes)
- O(log m) per modular inverse operation where m = 10^d

Space complexity: O(n)
- Storage for prime sieve and prime list

## Key insights

The modular inverse approach gives us the exact mathematical solution without
trial-and-error. Since gcd(p₂, 10^d) = 1 for primes p₂ ≥ 5 and d ≥ 1, the modular inverse
always exists.
"""
module Problem0134

using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes

"""
    count_digits(n)

Count the number of digits in a positive integer n.
"""
function count_digits(n)
    return length(string(n))
end

"""
    find_smallest_s(p1, p2)

Find the smallest number S such that S ends with digits of p1 and is divisible by p2.
Uses modular arithmetic to solve the system of congruences directly.
"""
function find_smallest_s(p1, p2)
    d = count_digits(p1)
    mod_base = 10^d

    # We need k such that k * p2 ≡ p1 (mod 10^d)
    # So k ≡ p1 * invmod(p2, 10^d) (mod 10^d)
    k = (p1 * invmod(p2, mod_base)) % mod_base

    return k * p2
end

"""
    sum_prime_pair_connections(limit)

Calculate the sum of smallest S values for all consecutive prime pairs with 5 ≤ p₁ ≤ limit.
"""
function sum_prime_pair_connections(limit)
    # Generate primes up to a bit beyond the limit to ensure we get the next prime after limit
    primes = sieve_of_eratosthenes(limit + 100)

    # Filter to start from p1 >= 5
    start_idx = findfirst(p -> p >= 5, primes)

    total_sum = 0
    count = 0

    for i in start_idx:(length(primes)-1)
        p1 = primes[i]
        p2 = primes[i+1]

        # Only consider pairs where p1 <= limit
        if p1 > limit
            break
        end

        s = find_smallest_s(p1, p2)
        total_sum += s
        count += 1

        # Progress logging for large computations
        if count % 10000 == 0
            @info "Processed $count prime pairs, current sum: $total_sum"
        end
    end

    @info "Processed $count consecutive prime pairs total"
    return total_sum
end

function solve()
    return sum_prime_pair_connections(1000000)
end

end # module
