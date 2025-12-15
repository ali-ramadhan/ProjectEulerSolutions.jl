"""
Divisor utilities for Project Euler solutions.

This module provides functions for working with divisors of integers,
including proper divisors, divisor counting, and related concepts.
"""
module Divisors

export divisors, sum_divisors, num_divisors, is_abundant, is_perfect, is_amicable

"""
    divisors(n)

Return a vector containing all divisors of n (including 1 and n).
Divisors are returned in sorted order.

Example: divisors(12) returns [1, 2, 3, 4, 6, 12]
"""
function divisors(n)
    divs = Int[]
    sqrt_n = isqrt(n)

    for i in 1:sqrt_n
        if n % i == 0
            push!(divs, i)
            push!(divs, n ÷ i)
        end
    end

    if sqrt_n^2 == n
        pop!(divs)
    end

    return sort(divs)
end

"""
    num_divisors(n)

Return the number of divisors of n (including 1 and n).

Example: num_divisors(12) returns 6 (divisors: 1, 2, 3, 4, 6, 12)
"""
function num_divisors(n)
    count = 0
    sqrt_n = isqrt(n)

    for i in 1:sqrt_n
        if n % i == 0
            count += 2
        end
    end

    if sqrt_n^2 == n
        count -= 1
    end

    return count
end

"""
    sum_divisors(n)

Return the sum of all divisors of n (including 1 and n).

Example: sum_divisors(12) returns 28 (1 + 2 + 3 + 4 + 6 + 12)
"""
function sum_divisors(n)
    total = 0
    sqrt_n = isqrt(n)

    for i in 1:sqrt_n
        if n % i == 0
            total += i + n ÷ i
        end
    end

    if sqrt_n^2 == n
        total -= sqrt_n
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
