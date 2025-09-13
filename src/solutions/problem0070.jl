"""
Project Euler Problem 70: Totient Permutation

Euler's totient function, φ(n) [sometimes called the phi function], is used to determine the
number of positive numbers less than or equal to n which are relatively prime to n. For
example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine,
φ(9)=6. The number 1 is considered to be relatively prime to every positive number, so
φ(1)=1.

Interestingly, φ(87109)=79180, and it can be seen that 87109 is a permutation of 79180.

Find the value of n, 1 < n < 10^7, for which φ(n) is a permutation of n and the ratio n/φ(n)
produces a minimum.

## Solution approach

This solution focuses on semiprimes (products of two primes) to minimize n/φ(n):
1. Generate all primes up to a suitable bound (roughly 2√(10^7))
2. For each pair of primes (p,q), compute n = p×q and φ(n) = (p-1)×(q-1)
3. Check if n and φ(n) are digit permutations of each other
4. Among valid permutations, find the one with minimum ratio n/φ(n)
5. Focus on semiprimes because they have high φ(n) values relative to n

## Complexity analysis

Time complexity: O(P²) where P ≈ 2√N is the number of primes up to 2√N
- Generate primes up to 2√(10^7) ≈ 6325: O(N log log N) using sieve
- Check all pairs of primes: O(P²) ≈ O(N/log²N) pairs
- Permutation check per pair: O(log N) for digit operations

Space complexity: O(P)
- Store list of primes: O(N/log N) space
- Temporary variables for computation

## Mathematical background

For a semiprime n = p×q where p,q are distinct primes:
- φ(n) = φ(p)×φ(q) = (p-1)×(q-1)
- n/φ(n) = pq/((p-1)(q-1))

This ratio approaches 1 as p,q grow large, making semiprimes good candidates for minimal
ratios.

## Key insights

Semiprimes are optimal because:
1. They have relatively high φ(n) values (close to n)
2. The formula φ(pq) = (p-1)(q-1) is easy to compute
3. When p ≈ q ≈ √N, the ratio n/φ(n) ≈ 1, which is minimal
"""
module Problem0070

using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes
using ProjectEulerSolutions.Utils.Digits: are_permutations

"""
    find_totient_permutation(limit)

Find the value of n, 1 < n < limit, for which φ(n) is a permutation of n
and the ratio n/φ(n) produces a minimum.

Strategy: Focus on semiprimes (products of two primes) since they tend to have high
totient values relative to n, which helps minimize n/φ(n).

For a semiprime n = p*q where p and q are distinct primes:
φ(n) = (p-1)*(q-1)

The ratio n/φ(n) = pq/((p-1)(q-1)) approaches 1 as p and q get larger.
"""
function find_totient_permutation(limit)
    min_ratio = Inf
    min_n = 0

    # Generate primes up to a suitable upper bound
    # We need primes such that their product is < limit
    sqrt_limit = isqrt(limit)
    prime_upper_bound = 2 * sqrt_limit

    primes = sieve_of_eratosthenes(prime_upper_bound)

    # Search for suitable pairs of primes
    for i in 1:length(primes)
        p = primes[i]
        max_q = limit ÷ p  # Ensure p*q < limit

        for j in i:length(primes)  # Start from i to avoid duplicates
            q = primes[j]

            if q > max_q
                break  # Skip remaining primes if they exceed max_q
            end

            n = p * q
            phi_n = (p - 1) * (q - 1)  # φ(n) for semiprime n = p*q

            if are_permutations(n, phi_n)
                ratio = n / phi_n

                if ratio < min_ratio
                    min_ratio = ratio
                    min_n = n
                    @info "New minimum ratio found: n=$n=($p×$q), φ(n)=$phi_n, " *
                          "ratio=$(round(ratio, digits=6))"
                end
            end
        end
    end

    return min_n
end

function solve()
    return find_totient_permutation(10^7)
end

end # module
