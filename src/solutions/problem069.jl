"""
Project Euler Problem 69: Totient Maximum

Euler's totient function, φ(n), is defined as the number of positive integers not exceeding
n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than
or equal to nine and relatively prime to nine, φ(9) = 6.

It can be seen that n = 6 produces a maximum n/φ(n) for n ≤ 10.

Find the value of n ≤ 1,000,000 for which n/φ(n) is a maximum.

## Solution approach

Rather than computing φ(n) for each n, we use the mathematical insight that n/φ(n) equals
the product ∏(p/(p-1)) over all distinct prime factors p of n. To maximize this ratio, we
multiply consecutive primes (2×3×5×7×...) until the next prime would exceed the limit. This
gives the primorial of the largest applicable prime.

## Complexity analysis

Time complexity: O(π(√N) × √N) where N = 1,000,000
- Find consecutive primes up to √N: O(π(√N)) primes to check
- Primality testing using trial division: O(√p) per prime p
- Overall: O(√N log log √N) using sieve bounds

Space complexity: O(1)
- Only store current product and next prime candidate

## Mathematical background

For n with prime factorization n = p₁^a₁ × p₂^a₂ × ... × p_k^a_k:
φ(n) = n × ∏(1 - 1/pᵢ) = n × ∏((pᵢ-1)/pᵢ)

Therefore: n/φ(n) = ∏(pᵢ/(pᵢ-1))

Each prime factor p contributes p/(p-1) to the ratio. Since smaller primes contribute larger
factors (2→2.0, 3→1.5, 5→1.25, 7→1.167, ...), the optimal strategy is to multiply
consecutive primes until reaching the limit.
"""
module Problem069

using ProjectEulerSolutions.Utils.Primes: is_prime

"""
    find_max_totient_ratio(limit)

Find the value of n ≤ limit for which n/φ(n) is a maximum.

Implements the primorial strategy: multiply consecutive primes (2×3×5×7×...) until the next
prime would exceed the limit.
"""
function find_max_totient_ratio(limit)
    n = 1
    p = 2

    # Keep multiplying by consecutive primes until we exceed the limit
    while true
        next_n = n * p
        if next_n > limit
            break
        end

        n = next_n
        @info "Including prime $p: primorial = $n"

        p += 1
        while !is_prime(p)
            p += 1
        end
    end

    return n
end

function solve()
    return find_max_totient_ratio(1_000_000)
end

end # module
