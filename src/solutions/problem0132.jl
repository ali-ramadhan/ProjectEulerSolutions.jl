"""
Project Euler Problem 132: Large Repunit Factors

A number consisting entirely of ones is called a repunit. We shall define R(k) to be a
repunit of length k.

For example, R(10) = 1111111111 = 11 × 41 × 271 × 9091, and the sum of these prime factors
is 9414.

Find the sum of the first forty prime factors of R(10^9).

## Solution approach

A repunit R(k) = (10^k - 1) / 9. A prime p divides R(k) if and only if 10^k ≡ 1 (mod p),
which means the multiplicative order of 10 modulo p must divide k.

For R(10^9), we need primes p where:
1. gcd(p, 10) = 1 (so p ≠ 2, 5)
2. The multiplicative order of 10 modulo p divides 10^9

The algorithm:
1. Generate primes using sieve
2. For each prime p > 5, compute the multiplicative order of 10 mod p
3. Check if this order divides 10^9
4. Collect the first 40 such primes and sum them

## Complexity analysis

Time complexity: O(n log log n + 40 × p × log p) where n is the sieve limit and p is the
average prime tested
- Sieve generation: O(n log log n)
- For each prime, computing multiplicative order takes O(p) in worst case
- We only need to check until we find 40 primes

Space complexity: O(n) for the prime sieve

## Key insights

The multiplicative order of 10 modulo p is at most p-1 (by Fermat's Little Theorem). We can
compute it efficiently by iterating through divisors of 10^9 and checking if
10^d ≡ 1 (mod p) for each divisor d.

Since 10^9 = 2^9 × 5^9, its divisors are of the form 2^a × 5^b where 0 ≤ a ≤ 9 and 0 ≤ b ≤
9, giving us 100 divisors to check at most.
"""
module Problem0132

using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes

"""
    multiplicative_order(a, n)

Compute the multiplicative order of a modulo n, i.e., the smallest positive integer k such
that a^k ≡ 1 (mod n). Assumes gcd(a, n) = 1.
"""
function multiplicative_order(a, n)
    # Start with k = 1 and compute powers of a mod n
    power = a % n
    k = 1

    while power != 1
        power = (power * a) % n
        k += 1
    end

    return k
end

"""
    prime_divides_repunit(p, k)

Check if prime p divides the repunit R(k) = 111...1 (k ones). For large k, we optimize by
using the multiplicative order when applicable.
"""
function prime_divides_repunit(p, k)
    # Special case: for p = 3, R(k) ≡ 0 (mod 3) iff k ≡ 0 (mod 3)
    if p == 3
        return k % 3 == 0
    end

    # For other primes, use the multiplicative order theorem:
    # p divides R(k) iff ord_p(10) divides k
    order = multiplicative_order(10, p)
    return k % order == 0
end

"""
    find_repunit_prime_factors(k, count)

Find the first `count` prime factors of the repunit R(k). Returns a vector of primes p such
that p divides R(k).
"""
function find_repunit_prime_factors(k, count)
    primes = Int[]

    # Generate primes - start with a larger limit for efficiency
    limit = 100000

    while length(primes) < count
        prime_list = sieve_of_eratosthenes(limit)

        # Continue from where we left off, not from the beginning
        start_idx = length(primes) > 0 ? findfirst(p -> p > primes[end], prime_list) : 1
        if start_idx === nothing
            # All primes in current list are smaller than our last found prime
            limit *= 2
            continue
        end

        for i in start_idx:length(prime_list)
            p = prime_list[i]

            # Skip 2 and 5 since gcd(p, 10) must be 1
            if p == 2 || p == 5
                continue
            end

            # Check if p divides R(k)
            if prime_divides_repunit(p, k)
                push!(primes, p)
                order = multiplicative_order(10, p)
                @info "Found prime factor $p with order $order"

                if length(primes) >= count
                    break
                end
            end
        end

        # If we didn't find enough primes, increase the limit
        if length(primes) < count
            limit *= 2
        end
    end

    return primes[1:count]
end

function solve()
    prime_factors = find_repunit_prime_factors(1000000000, 40)
    return sum(prime_factors)
end

end # module
