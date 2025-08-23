"""
Project Euler Problem 87: Prime Power Triples

The smallest number expressible as the sum of a prime square, prime cube, and prime
fourth power is 28. In fact, there are exactly four numbers below fifty that can be
expressed in such a way:

28 = 2² + 2³ + 2⁴
33 = 3² + 2³ + 2⁴
49 = 5² + 2³ + 2⁴
47 = 2² + 3³ + 2⁴

How many numbers below fifty million can be expressed as the sum of a prime square,
prime cube, and prime fourth power?
"""
module Problem087

using ..Utils.Primes: sieve_of_eratosthenes

function find_prime_power_triples(limit)
    # Find the maximum prime needed for each power
    # For prime^4, we need p^4 < limit, so p < limit^(1/4)
    max_prime_4th = floor(Int, limit^(1/4))
    # For prime^3, we need p^3 < limit, so p < cbrt(limit)
    max_prime_3rd = floor(Int, cbrt(limit))
    # For prime^2, we need p^2 < limit, so p < sqrt(limit)
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
