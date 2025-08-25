"""
Divisor utilities for Project Euler solutions.

This module provides functions for working with divisors of integers,
including proper divisors, divisor counting, and related concepts.
"""
module Divisors

export get_divisors, is_abundant, is_perfect

"""
    get_divisors(n)

Return a vector containing all divisors of n (including 1 and n).
Divisors are returned in sorted order.

Example: get_divisors(12) returns [1, 2, 3, 4, 6, 12]
"""
function get_divisors(n)
    divisors = Int[]

    for i in 1:isqrt(n)
        if n % i == 0
            push!(divisors, i)
            if i^2 != n  # Avoid duplicate for perfect squares
                push!(divisors, n ÷ i)
            end
        end
    end

    return sort(divisors)
end

"""
    is_abundant(n)

Check if a number is abundant, which means the sum of its proper divisors exceeds the number itself.

Example: is_abundant(12) returns true (proper divisors sum: 1+2+3+4+6 = 16 > 12)
"""
function is_abundant(n)
    divisors = get_divisors(n)
    return sum(divisors) - n > n
end

"""
    is_perfect(n)

Check if a number is perfect, which means the sum of its proper divisors equals the number itself.

Example: is_perfect(28) returns true (proper divisors sum: 1+2+4+7+14 = 28)
"""
function is_perfect(n)
    divisors = get_divisors(n)
    return sum(divisors) - n == n
end

end # module Divisors
