"""
Project Euler Problem 108: Diophantine reciprocals I

In the following equation x, y, and n are positive integers.
1/x + 1/y = 1/n

For n = 4 there are exactly three distinct solutions:
1/5 + 1/20 = 1/4
1/6 + 1/12 = 1/4
1/8 + 1/8 = 1/4

What is the least value of n for which the number of distinct solutions exceeds one
thousand?

## Solution approach

Starting with the equation 1/x + 1/y = 1/n, we can rearrange it:
1/x + 1/y = 1/n
(y + x)/(xy) = 1/n
n(y + x) = xy
ny + nx = xy
y(n - x) = -nx
y = nx/(x - n)

For y to be a positive integer, we need x > n and (x - n) must divide nx. Let d = x - n, so
x = n + d. Then: y = n(n + d)/d = n²/d + n

For y to be an integer, d must be a divisor of n².

The number of positive solutions corresponds to the divisors of n² where d > 0. Since we
want distinct solutions and the equation is symmetric in x and y, the number of distinct
solutions is (τ(n²) + 1)/2, where τ(n²) is the number of divisors of n².

For n with prime factorization n = p₁^a₁ × p₂^a₂ × ... × pₖ^aₖ, we have:
τ(n²) = (2a₁ + 1)(2a₂ + 1)...(2aₖ + 1)

We search for the smallest n where (τ(n²) + 1)/2 > 1000, i.e., τ(n²) > 1999.

## Complexity analysis

Time complexity: O(n√n) for each candidate n we test
- Computing the number of divisors takes O(√n²) = O(n) time

Space complexity: O(1)
- Only storing a constant amount of data
"""
module Problem108

using ProjectEulerSolutions.Utils.Primes: prime_factors
using ProjectEulerSolutions.Utils.Divisors: get_divisors

"""
    count_solutions(n)

Count the number of distinct positive integer solutions to 1/x + 1/y = 1/n
"""
function count_solutions(n)
    factors = prime_factors(n)

    # Count occurrences of each prime factor
    factor_counts = Dict{Int, Int}()
    for factor in factors
        factor_counts[factor] = get(factor_counts, factor, 0) + 1
    end

    # For n², each exponent is doubled
    # Number of divisors of n² = ∏(2aᵢ + 1) where aᵢ is the exponent of prime i in n
    divisor_count = 1
    for count in values(factor_counts)
        divisor_count *= (2 * count + 1)
    end

    return (divisor_count + 1) ÷ 2
end

function solve()
    target = 1000
    n = 1

    while true
        solutions = count_solutions(n)

        if solutions > target
            @info "Found n = $n with $solutions distinct solutions to 1/x + 1/y = 1/n"
            return n
        end

        n += 1
    end
end

end # module
