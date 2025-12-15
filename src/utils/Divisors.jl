"""
Divisor utilities for Project Euler solutions.

This module provides functions for working with divisors of integers,
including proper divisors, divisor counting, and related concepts.
"""
module Divisors

export divisors, sum_divisors, is_abundant, is_perfect, is_amicable

"""
    divisors(n)

Return a vector containing all divisors of n (including 1 and n).
Divisors are returned in sorted order.

Example: divisors(12) returns [1, 2, 3, 4, 6, 12]
"""
function divisors(n)
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
    sum_divisors(n)

Return the sum of all divisors of n (including 1 and n).
This function performs no memory allocations.

Example: sum_divisors(12) returns 28 (1 + 2 + 3 + 4 + 6 + 12)
"""
function sum_divisors(n)
    total = 0
    for i in 1:isqrt(n)
        if n % i == 0
            total += i
            if i^2 != n  # Avoid duplicate for perfect squares
                total += n ÷ i
            end
        end
    end
    return total
end

"""
    is_abundant(n)

Check if a number is abundant, which means the sum of its proper divisors exceeds the number itself.

Example: is_abundant(12) returns true (proper divisors sum: 1+2+3+4+6 = 16 > 12)
"""
function is_abundant(n)
    return sum_divisors(n) - n > n
end

"""
    is_perfect(n)

Check if a number is perfect, which means the sum of its proper divisors equals the number itself.

Example: is_perfect(28) returns true (proper divisors sum: 1+2+4+7+14 = 28)
"""
function is_perfect(n)
    return sum_divisors(n) - n == n
end

"""
    is_amicable(a)

Check if a number is amicable. A number a is amicable if there exists a different
number b such that the sum of proper divisors of a equals b, and the sum of proper
divisors of b equals a.

Example: is_amicable(220) returns true (220 and 284 form an amicable pair)
"""
function is_amicable(a)
    b = sum_divisors(a) - a
    return a != b && sum_divisors(b) - b == a
end

end # module Divisors
