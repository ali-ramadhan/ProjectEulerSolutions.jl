"""
Project Euler Problem 6: Sum Square Difference

The sum of the squares of the first ten natural numbers is,
1² + 2² + ... + 10² = 385.

The square of the sum of the first ten natural numbers is,
(1 + 2 + ... + 10)² = 55² = 3025.

Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 - 385 = 2640.

Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
"""
module Problem006

"""
    sum_of_squares(n)

Calculate the sum of squares of the first n natural numbers.
"""
function sum_of_squares(n)
    return n * (n + 1) * (2 * n + 1) ÷ 6
end

"""
    square_of_sum(n)

Calculate the square of the sum of the first n natural numbers.
"""
function square_of_sum(n)
    sum = n * (n + 1) ÷ 2
    return sum^2
end

"""
    sum_square_difference(n)

Find the difference between the square of the sum and the sum of squares
of the first n natural numbers.
"""
function sum_square_difference(n)
    return square_of_sum(n) - sum_of_squares(n)
end

function solve()
    return sum_square_difference(100)
end

end # module