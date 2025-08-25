"""
Number theory utilities for Project Euler solutions.

This module provides functions for number-theoretic operations
including Euler's totient function and related concepts.
"""
module NumberTheory

export euler_totient, totient_sieve, is_coprime

"""
    euler_totient(n)

Calculate Euler's totient function φ(n), which counts the number of positive integers
up to n that are relatively prime to n.

For a number n with prime factorization n = p₁^a₁ × p₂^a₂ × ... × pₖ^aₖ,
φ(n) = n × ∏(1 - 1/pᵢ) for each distinct prime pᵢ dividing n.

Example: euler_totient(9) returns 6 (numbers 1,2,4,5,7,8 are coprime to 9)
"""
function euler_totient(n)
    if n == 1
        return 1
    end

    result = n

    # Handle factor 2
    if n % 2 == 0
        result = result ÷ 2  # result *= (1 - 1/2)
        while n % 2 == 0
            n ÷= 2
        end
    end

    # Handle odd factors
    factor = 3
    while factor^2 <= n
        if n % factor == 0
            result = result - result ÷ factor  # result *= (1 - 1/factor)
            while n % factor == 0
                n ÷= factor
            end
        end
        factor += 2
    end

    # If n > 1, then n is a prime factor itself
    if n > 1
        result = result - result ÷ n  # result *= (1 - 1/n)
    end

    return result
end

"""
    totient_sieve(limit)

Generate all totient values φ(n) for n from 1 to limit using a sieve-like approach.
This is more efficient than computing individual totient values when you need many of them.

Returns an array where result[i] = φ(i).

This is used in problems that need the sum of totient values or many totient computations.
"""
function totient_sieve(limit)
    # Initialize phi[i] = i for i from 1 to limit
    phi = collect(1:limit)

    # Sieve-like approach to compute phi values
    for p in 2:limit
        # If phi[p] == p, then p is prime
        if phi[p] == p
            # Update phi values for p and its multiples
            for j in p:p:limit
                # phi[j] = phi[j] * (1 - 1/p) = phi[j] - phi[j]/p
                phi[j] -= phi[j] ÷ p
            end
        end
    end

    return phi
end

"""
    is_coprime(a, b)

Check if two numbers are coprime (their greatest common divisor is 1).

Example: is_coprime(8, 9) returns true, is_coprime(6, 9) returns false
"""
function is_coprime(a, b)
    return gcd(a, b) == 1
end

end # module NumberTheory
