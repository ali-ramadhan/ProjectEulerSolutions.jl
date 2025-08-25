"""
Project Euler Problem 6: Sum Square Difference

The sum of the squares of the first ten natural numbers is,
1² + 2² + ... + 10² = 385.

The square of the sum of the first ten natural numbers is,
(1 + 2 + ... + 10)² = 55² = 3025.

Hence the difference between the sum of the squares of the first ten natural numbers and the
square of the sum is 3025 - 385 = 2640.

Find the difference between the sum of the squares of the first one hundred natural numbers
and the square of the sum.

## Solution approach

This problem can be solved efficiently using closed-form mathematical formulas:
1. Sum of squares of first n numbers: n(n+1)(2n+1)/6
2. Square of sum of first n numbers: (n(n+1)/2)²

We calculate both values for n=100 and return their difference.

## Complexity analysis

Time complexity: O(1)
- Both formulas are evaluated in constant time using arithmetic operations

Space complexity: O(1)
- Only a few variables are needed to store intermediate results
"""
module Problem006

using ProjectEulerSolutions.Utils.Sequences: sum_of_squares, square_of_sum

function solve()
    return square_of_sum(100) - sum_of_squares(100)
end

end # module
