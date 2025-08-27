"""
Mathematical sequence utilities for Project Euler solutions.

This module provides functions for generating and working with common
mathematical sequences like Fibonacci, triangular numbers, etc.
"""
module Sequences

export Fibonacci,
    triangle_number, pentagonal_number, hexagonal_number, sum_of_squares, square_of_sum,
    is_triangle_number, is_pentagonal

"""
    Fibonacci{T<:Integer}(limit::T)
    Fibonacci(limit::T) where T<:Integer
    Fibonacci{T}() where T<:Integer
    Fibonacci()

A parametric iterator for generating Fibonacci numbers up to a given limit.

The iterator supports any integer type T (Int, Int128, BigInt, etc.) for both the
limit and the generated sequence values. This allows for high-precision calculations
or performance optimization with specific integer types.

## Examples

```julia
# Basic usage with Int
for fib in Fibonacci(100)
    println(fib)
end

# Using Int128 for larger numbers
for fib in Fibonacci(Int128(10^20))
    println(fib)
end

# Using BigInt for arbitrary precision
for fib in Fibonacci{BigInt}(10^50)
    println(fib)
end

# Unlimited iteration (up to typemax)
for (i, fib) in enumerate(Fibonacci())
    i > 10 && break
    println(fib)
end
```
"""
struct Fibonacci{T<:Integer}
    limit::T
end

Fibonacci{T}() where T<:Integer = Fibonacci{T}(typemax(T))
Fibonacci() = Fibonacci{Int}(typemax(Int))

function Base.iterate(fib::Fibonacci{T}) where T
    zero(T) > fib.limit && return nothing
    return (zero(T), (zero(T), one(T)))
end

function Base.iterate(fib::Fibonacci{T}, state::Tuple{T, T}) where T
    current, next = state
    next > fib.limit && return nothing
    return (next, (next, current + next))
end

Base.eltype(::Type{Fibonacci{T}}) where T = T
Base.IteratorSize(::Type{Fibonacci{T}}) where T = Base.SizeUnknown()

"""
    triangle_number(n)

Calculate the nth triangular number: T(n) = n(n+1)/2.
Triangular numbers are 1, 3, 6, 10, 15, 21, 28, ...

## Derivation

Triangular numbers represent the number of dots that can be arranged in an equilateral
triangle. The nth triangular number is the sum of the first n natural numbers:

    T(n) = 1 + 2 + 3 + ... + n

Using the arithmetic series formula (Gauss method):
    T(n) = n(n+1)/2

Geometrically, this can be visualized as:
    T(1) = •           (1 dot)
    T(2) = • •         (3 dots total)
           •
    T(3) = • • •       (6 dots total)
           • •
           •

Each row k contributes k dots, so T(n) = Σ(k=1 to n) k = n(n+1)/2.

Example: triangle_number(5) returns 15
"""
function triangle_number(n)
    return n * (n + 1) ÷ 2
end

"""
    pentagonal_number(n)

Calculate the nth pentagonal number: P(n) = n(3n-1)/2.
Pentagonal numbers are 1, 5, 12, 22, 35, 51, ...

## Derivation

Pentagonal numbers represent the number of dots that can be arranged in a regular
pentagon pattern. They can be derived as a special case of polygonal numbers.

For a k-sided polygonal number, the general formula is:
    P(k,n) = n[(k-2)n - (k-4)]/2

For pentagons (k=5):
    P(5,n) = n[(5-2)n - (5-4)]/2 = n(3n-1)/2

Alternatively, pentagonal numbers can be constructed by the recurrence relation:
    P(1) = 1
    P(n) = P(n-1) + 3n - 2

This shows that each successive pentagonal number adds 3n-2 dots to form the next
pentagon layer. The pattern 3n-2 gives the differences: 2, 5, 8, 11, 14, ...
(arithmetic sequence with common difference 3).

Geometrically, pentagonal numbers extend triangular numbers by adding pentagonal
"shells" around a central dot.

Example: pentagonal_number(4) returns 22
"""
function pentagonal_number(n)
    return n * (3n - 1) ÷ 2
end

"""
    hexagonal_number(n)

Calculate the nth hexagonal number: H(n) = n(2n-1).
Hexagonal numbers are 1, 6, 15, 28, 45, 66, ...

## Derivation

Hexagonal numbers represent the number of dots that can be arranged in a regular
hexagon pattern. They can be derived using the general polygonal number formula.

For a k-sided polygonal number:
    P(k,n) = n[(k-2)n - (k-4)]/2

For hexagons (k=6):
    H(n) = n[(6-2)n - (6-4)]/2 = n(4n-2)/2 = n(2n-1)

Alternatively, hexagonal numbers have a beautiful relationship with triangular numbers.
Every hexagonal number is also a triangular number:
    H(n) = T(2n-1)

This can be verified:
    H(3) = 3(2·3-1) = 3·5 = 15
    T(5) = 5·6/2 = 15 ✓

So H(n) = n(2n-1) = T(2n-1)

The recurrence relation is:
    H(1) = 1
    H(n) = H(n-1) + 4n - 3

This shows each hexagonal layer adds 4n-3 dots, giving differences: 3, 7, 11, 15, ...
(arithmetic sequence with common difference 4).

Remarkably, every hexagonal number is also a triangular number: H(n) = T(2n-1).

Example: hexagonal_number(4) returns 28
"""
function hexagonal_number(n)
    return n * (2n - 1)
end

"""
    sum_of_squares(n)

Calculate the sum of squares of the first n natural numbers: 1² + 2² + ... + n².
Uses the formula: n(n+1)(2n+1)/6

## Derivation

The sum 1² + 2² + ... + n² can be derived using mathematical induction or by
considering the relationship:
    k³ - (k-1)³ = 3k² - 3k + 1

Summing from k=1 to n:
    n³ = 3(1² + 2² + ... + n²) - 3(1 + 2 + ... + n) + n
    n³ = 3S - 3·n(n+1)/2 + n

Where S = 1² + 2² + ... + n². Solving for S:
    S = (n³ + 3n(n+1)/2 - n)/3
    S = (2n³ + 3n² + 3n - 2n)/6
    S = (2n³ + 3n² + n)/6
    S = n(2n² + 3n + 1)/6
    S = n(n+1)(2n+1)/6

Example: sum_of_squares(3) returns 14 (1² + 2² + 3² = 1 + 4 + 9)
"""
function sum_of_squares(n)
    return n * (n + 1) * (2n + 1) ÷ 6
end

"""
    square_of_sum(n)

Calculate the square of the sum of the first n natural numbers: (1 + 2 + ... + n)².
Uses the formula: (n(n+1)/2)²

## Derivation

The sum of the first n natural numbers is a well-known arithmetic series:
    1 + 2 + 3 + ... + n

This can be derived by considering the sum S = 1 + 2 + ... + n twice:
    S = 1 + 2 + 3 + ... + (n-1) + n
    S = n + (n-1) + (n-2) + ... + 2 + 1

Adding these equations:
    2S = (n+1) + (n+1) + ... + (n+1)  [n terms]
    2S = n(n+1)
    S = n(n+1)/2

Therefore, the square of this sum is:
    (1 + 2 + ... + n)² = (n(n+1)/2)²

Example: square_of_sum(3) returns 36 ((1 + 2 + 3)² = 6² = 36)
"""
function square_of_sum(n)
    sum = n * (n + 1) ÷ 2
    return sum^2
end

"""
    is_triangle_number(n)

Check if a number is a triangle number using the inverse formula.
A number n is triangular if (-1 + √(1 + 8n))/2 is a positive integer.

## Derivation

For a triangle number T(k) = k(k+1)/2 = n, solving for k:
    k(k+1) = 2n
    k² + k - 2n = 0

Using the quadratic formula:
    k = (-1 ± √(1 + 8n))/2

Since k must be positive, we take the positive root:
    k = (-1 + √(1 + 8n))/2

If k is a positive integer, then n is a triangle number.

Example: is_triangle_number(6) returns true (T(3) = 6)
"""
function is_triangle_number(n)
    n <= 0 && return false
    x = (sqrt(1 + 8 * n) - 1) / 2
    return isinteger(x)
end

"""
    is_pentagonal(n)

Check if a number is a pentagonal number using the inverse formula.
A number n is pentagonal if (1 + √(1 + 24n))/6 is a positive integer.

## Derivation

For a pentagonal number P(k) = k(3k-1)/2 = n, solving for k:
    k(3k-1) = 2n
    3k² - k - 2n = 0

Using the quadratic formula:
    k = (1 ± √(1 + 24n))/6

Since k must be positive, we take the positive root:
    k = (1 + √(1 + 24n))/6

If k is a positive integer, then n is a pentagonal number.

Example: is_pentagonal(12) returns true (P(3) = 12)
"""
function is_pentagonal(n)
    n <= 0 && return false
    
    discriminant = 1 + 24 * n
    r = isqrt(discriminant)
    if r^2 != discriminant
        return false
    end
    
    if (1 + r) % 6 != 0
        return false
    end
    
    return true
end

end # module Sequences
