"""
Project Euler Problem 20: Factorial Digit Sum

n! means n × (n - 1) × ... × 3 × 2 × 1.

For example, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
and the sum of the digits in the number 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

Find the sum of the digits in the number 100!.
"""
module Problem020

"""
    sum_of_factorial_digits(n)

Calculate the sum of the digits in the factorial of n.
"""
function sum_of_factorial_digits(n)
    fact = factorial(big(n))
    digits_sum = sum(parse(Int, c) for c in string(fact))
    return digits_sum
end

function solve()
    return sum_of_factorial_digits(100)
end

end # module
