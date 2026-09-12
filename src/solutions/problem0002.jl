"""
Project Euler Problem 2: Even Fibonacci numbers

Problem description: https://projecteuler.net/problem=2
Solution description: https://aliramadhan.me/blog/project-euler/problem-0002/
"""
module Problem0002

export sum_even_fibonacci, solve

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

function solve()
    return sum_even_fibonacci(4_000_000)
end

end # module
