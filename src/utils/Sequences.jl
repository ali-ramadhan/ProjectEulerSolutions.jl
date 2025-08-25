"""
Mathematical sequence utilities for Project Euler solutions.

This module provides functions for generating and working with common
mathematical sequences like Fibonacci, triangular numbers, etc.
"""
module Sequences

export fibonacci_sequence,
    triangle_number, pentagonal_number, hexagonal_number, sum_of_squares, square_of_sum

"""
    fibonacci_sequence(limit)

Generate Fibonacci numbers up to the given limit.
Returns an array of Fibonacci numbers.

Example: fibonacci_sequence(100) returns [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
"""
function fibonacci_sequence(limit)
    fibs = Int[]
    a, b = 1, 1

    while a <= limit
        push!(fibs, a)
        a, b = b, a + b
    end

    return fibs
end

"""
    triangle_number(n)

Calculate the nth triangular number: T(n) = n(n+1)/2.
Triangular numbers are 1, 3, 6, 10, 15, 21, 28, ...

Example: triangle_number(5) returns 15
"""
function triangle_number(n)
    return n * (n + 1) ÷ 2
end

"""
    pentagonal_number(n)

Calculate the nth pentagonal number: P(n) = n(3n-1)/2.
Pentagonal numbers are 1, 5, 12, 22, 35, 51, ...

Example: pentagonal_number(4) returns 22
"""
function pentagonal_number(n)
    return n * (3n - 1) ÷ 2
end

"""
    hexagonal_number(n)

Calculate the nth hexagonal number: H(n) = n(2n-1).
Hexagonal numbers are 1, 6, 15, 28, 45, 66, ...

Example: hexagonal_number(4) returns 28
"""
function hexagonal_number(n)
    return n * (2n - 1)
end

"""
    sum_of_squares(n)

Calculate the sum of squares of the first n natural numbers: 1² + 2² + ... + n².
Uses the formula: n(n+1)(2n+1)/6

Example: sum_of_squares(3) returns 14 (1² + 2² + 3² = 1 + 4 + 9)
"""
function sum_of_squares(n)
    return n * (n + 1) * (2n + 1) ÷ 6
end

"""
    square_of_sum(n)

Calculate the square of the sum of the first n natural numbers: (1 + 2 + ... + n)².
Uses the formula: (n(n+1)/2)²

Example: square_of_sum(3) returns 36 ((1 + 2 + 3)² = 6² = 36)
"""
function square_of_sum(n)
    sum = n * (n + 1) ÷ 2
    return sum^2
end

end # module Sequences
