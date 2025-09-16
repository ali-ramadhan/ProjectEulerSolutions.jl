"""
Project Euler Problem 133: Repunit Non-factors

A number consisting entirely of ones is called a repunit. We shall define R(k) to be a
repunit of length k; for example, R(6) = 111111.

Let us consider repunits of the form R(10^n).

Although R(10), R(100), or R(1000) are not divisible by 17, R(10000) is divisible by 17. Yet
there is no value of n for which R(10^n) will divide by 19. In fact, it is remarkable that
11, 17, 41, and 73 are the only four primes below one-hundred that can be a factor of
R(10^n).

Find the sum of all the primes below one-hundred thousand that will never be a factor of
R(10^n).

## Solution approach

A repunit R(k) = (10^k - 1) / 9. A prime p divides R(k) if and only if 10^k ≡ 1 (mod p),
which means the multiplicative order of 10 modulo p must divide k.

For R(10^n), we need the multiplicative order of 10 modulo p to divide 10^n = 2^n × 5^n.
This is only possible if the multiplicative order contains only factors of 2 and 5.

The algorithm:
1. Generate all primes up to 100,000 (excluding 2 and 5)
2. For each prime p, compute the multiplicative order of 10 modulo p
3. Check if this order has any prime factors other than 2 and 5
4. Sum all primes whose order contains other prime factors

## Complexity analysis

Time complexity: O(n log log n + π(n) × ord_p(10)) where n = 100,000
- Sieve generation: O(n log log n)
- For each prime p, computing the multiplicative order takes O(ord_p(10)) time
- Factoring the order to check for non-{2,5} factors takes O(sqrt(ord_p(10)))

Space complexity: O(n) for the prime sieve

## Mathematical background

By Fermat's Little Theorem, if p is prime and gcd(10,p) = 1, then 10^(p-1) ≡ 1 (mod p). The
multiplicative order ord_p(10) is the smallest positive integer k such that 10^k ≡ 1 (mod
p), and it always divides p-1.

For a prime p to divide R(10^n), we need ord_p(10) to divide 10^n. Since 10^n contains only
powers of 2 and 5, ord_p(10) must be composed only of these prime factors.

## Key insights

The primes that can never divide R(10^n) are exactly those whose multiplicative order modulo
10 contains at least one prime factor other than 2 and 5. This creates a clear criterion for
filtering primes.
"""
module Problem0133

using ..Utils.Primes: sieve_of_eratosthenes

"""
    multiplicative_order(a, p)

Compute the multiplicative order of a modulo p, i.e., the smallest positive integer k such
that a^k ≡ 1 (mod p). Assumes gcd(a, p) = 1.
"""
function multiplicative_order(a, p)
    power = a % p
    k = 1

    while power != 1
        power = (power * a) % p
        k += 1
    end

    return k
end

"""
    has_only_factors_2_and_5(n)

Check if n has only 2 and 5 as prime factors.
"""
function has_only_factors_2_and_5(n)
    # Remove all factors of 2
    while n % 2 == 0
        n ÷= 2
    end

    # Remove all factors of 5
    while n % 5 == 0
        n ÷= 5
    end

    # If only 2s and 5s were factors, n should now be 1
    return n == 1
end

"""
    can_divide_repunit_10n(p)

Check if prime p can divide R(10^n) for some n. This happens if and only if the
multiplicative order of 10 modulo p divides some number of the form 2^a × 5^b. Equivalently,
ord_p(10) must have only 2 and 5 as prime factors.

Special case: For p = 3, R(k) ≡ k (mod 3), so R(10^n) ≡ 10^n ≡ 1 (mod 3) ≠ 0. Therefore 3
never divides R(10^n).
"""
function can_divide_repunit_10n(p)
    # Skip 2 and 5 as they don't satisfy gcd(10, p) = 1
    if p == 2 || p == 5
        return false
    end

    # Special case: 3 never divides R(10^n) because R(10^n) ≡ 10^n ≡ 1 (mod 3)
    if p == 3
        return false
    end

    order = multiplicative_order(10, p)
    return has_only_factors_2_and_5(order)
end

"""
    find_never_factor_primes(limit)

Find all primes below limit that will never be factors of R(10^n) for any n. Returns the sum
of these primes.
"""
function find_never_factor_primes(limit)
    primes = sieve_of_eratosthenes(limit - 1)
    never_factors = Int[]
    can_factors = Int[]

    for p in primes
        # Skip 2 and 5
        if p == 2 || p == 5
            continue
        end

        if can_divide_repunit_10n(p)
            push!(can_factors, p)
        else
            push!(never_factors, p)
        end
    end

    @info "Found $(length(can_factors)) primes that can divide R(10^n): first few are $(can_factors[1:min(10, length(can_factors))])"
    @info "Found $(length(never_factors)) primes that never divide R(10^n)"

    return sum(never_factors)
end

function solve()
    return find_never_factor_primes(100000)
end

end # module
