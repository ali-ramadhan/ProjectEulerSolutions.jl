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
    # Use `widemul` as factor^2 overflows `Int64` when n is near `typemax(Int64)`
    while widemul(factor, factor) <= n
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
