"""
Project Euler Problem 87: Prime Power Triples

The smallest number expressible as the sum of a prime square, prime cube, and prime fourth
power is 28. In fact, there are exactly four numbers below fifty that can be expressed in
such a way:

28 = 2² + 2³ + 2⁴
33 = 3² + 2³ + 2⁴
49 = 5² + 2³ + 2⁴
47 = 2² + 3³ + 2⁴

How many numbers below fifty million can be expressed as the sum of a prime square, prime
cube, and prime fourth power?

## Solution approach

We generate all possible combinations of prime powers below the limit and count unique sums.
The algorithm:

1. Find maximum primes needed for each power: p² < 50M, p³ < 50M, p⁴ < 50M
2. Generate primes up to the maximum using sieve of Eratosthenes
3. Use nested loops to try all combinations of (p₁², p₂³, p₃⁴)
4. Store sums in a Set to automatically handle uniqueness
5. Return the count of unique sums

Key optimization: Break early when partial sums exceed the limit to avoid unnecessary
computation.

## Complexity analysis

Time complexity: O(P₂ × P₃ × P₄)
- Where Pₖ is the number of primes whose k-th power is below the limit
- P₄ ≈ ⌊∜50M⌋ ≈ 84 primes, P₃ ≈ ⌊∛50M⌋ ≈ 368 primes, P₂ ≈ ⌊√50M⌋ ≈ 7071 primes
- Early breaks significantly reduce the actual iterations

Space complexity: O(unique_sums)
- Set storage for all unique prime power triple sums
- In practice, much less than the theoretical maximum of P₂ × P₃ × P₄
"""
module Problem0087

using ..Utils.Primes: sieve_of_eratosthenes

function find_prime_power_triples(limit)
    # Find the maximum prime needed for each power
    max_prime_4th = floor(Int, limit^(1/4))
    max_prime_3rd = floor(Int, cbrt(limit))
    max_prime_2nd = floor(Int, sqrt(limit))

    # Generate primes up to the maximum needed
    max_prime = max(max_prime_2nd, max_prime_3rd, max_prime_4th)
    primes = sieve_of_eratosthenes(max_prime)

    # Filter primes for each power
    primes_4th = [p for p in primes if p <= max_prime_4th]
    primes_3rd = [p for p in primes if p <= max_prime_3rd]
    primes_2nd = [p for p in primes if p <= max_prime_2nd]

    # Use a set to store unique sums
    unique_sums = Set{Int}()

    # Generate all possible combinations
    for p4 in primes_4th
        fourth_power = p4^4
        if fourth_power > limit
            break
        end

        for p3 in primes_3rd
            cube = p3^3
            if fourth_power + cube > limit
                break
            end

            for p2 in primes_2nd
                square = p2^2
                sum_total = fourth_power + cube + square

                if sum_total > limit
                    break
                end

                push!(unique_sums, sum_total)
            end
        end
    end

    return length(unique_sums)
end

function solve()
    return find_prime_power_triples(50_000_000)
end

end # module
