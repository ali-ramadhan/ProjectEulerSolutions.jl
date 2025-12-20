"""
Project Euler Problem 20: Factorial Digit Sum

Problem description: https://projecteuler.net/problem=20
Solution description: https://aliramadhan.me/blog/project-euler/problem-0020/
"""
module Problem0020

export sum_of_factorial_digits, solve

function sum_of_factorial_digits(n)
    fact = factorial(big(n))
    digits_sum = sum(parse(Int, c) for c in string(fact))
    return digits_sum
end

function solve()
    return sum_of_factorial_digits(100)
end

end # module
