"""
Project Euler Problem 47: Distinct Primes Factors

The first two consecutive numbers to have two distinct prime factors are:
14 = 2 × 7
15 = 3 × 5.

The first three consecutive numbers to have three distinct prime factors are:
644 = 2² × 7 × 23
645 = 3 × 5 × 43
646 = 2 × 17 × 19.

Find the first four consecutive integers to have four distinct prime factors each.
What is the first of these numbers?
"""
module Problem047

"""
    count_distinct_prime_factors(n)

Count the number of distinct prime factors of n.
Uses trial division to find prime factors, adding each unique prime to a Set.
"""
function count_distinct_prime_factors(n)
    if n <= 1
        return 0
    end

    factors = Set{Int}()

    while n % 2 == 0
        push!(factors, 2)
        n ÷= 2
    end

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

    return length(factors)
end

"""
    find_consecutive_with_distinct_prime_factors(consecutive_count, factor_count)

Find the first sequence of consecutive_count integers where each has exactly
factor_count distinct prime factors.

Returns the first number in the sequence.
"""
function find_consecutive_with_distinct_prime_factors(consecutive_count, factor_count)
    consecutive = 0
    n = 2

    while consecutive < consecutive_count
        if count_distinct_prime_factors(n) == factor_count
            consecutive += 1
        else
            consecutive = 0
        end

        n += 1

        if consecutive == consecutive_count
            return n - consecutive_count
        end
    end

    return -1
end

function solve()
    return find_consecutive_with_distinct_prime_factors(4, 4)
end

end # module
