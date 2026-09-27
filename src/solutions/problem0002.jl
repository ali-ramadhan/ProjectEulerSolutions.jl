"""
Project Euler Problem 2: Even Fibonacci numbers

Problem description: https://projecteuler.net/problem=2
Solution description: https://aliramadhan.me/blog/project-euler/problem-0002/
"""
module Problem0002

export sum_even_fibonacci, sum_even_fibonacci_naive, solve

# Generate every Fibonacci number up to the limit and sum the even ones
function sum_even_fibonacci_naive(limit)
    result = 0

    a, b = 0, 1
    while a ≤ limit
        iseven(a) && (result += a)
        a, b = b, a + b
    end

    return result
end

# Generate only the even Fibonacci numbers, using F(n) = 4F(n-3) + F(n-6)
function sum_even_fibonacci(limit)
    limit < 2 && return 0
    limit < 8 && return 2

    a, b = 2, 8
    result = a + b

    while (c = 4b + a) ≤ limit
        result += c
        a, b = b, c
    end

    return result
end

function solve(solve_func=sum_even_fibonacci)
    return solve_func(4_000_000)
end

end # module
