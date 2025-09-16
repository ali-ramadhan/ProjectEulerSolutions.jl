"""
Project Euler Bonus Problem: Root13

The decimal expansion of the square root of two is 1.4142135623730...

If we define S(n, d) to be the sum of the first d digits in the fractional part of the
decimal expansion of √n, it can be seen that S(2, 10) = 4 + 1 + 4 + ... + 3 = 31.

It can be confirmed that S(2, 100) = 481.

Find S(13, 1000).

Note: Instead of just using arbitrary precision floats, try to be creative with your method.

## Solution approach

This problem asks us to compute decimal digits of a square root without using arbitrary
precision arithmetic. The most elegant approach is to implement the digit-by-digit square
root algorithm (long division method for square roots).

This algorithm works by:
1. Finding the integer part of √n
2. Using a recurrence relation to compute each decimal digit one by one
3. Maintaining exact arithmetic throughout using only integers

The algorithm is based on the identity:
If √n = a.d₁d₂d₃..., then at each step we solve:
(20 × partial_result + digit) × digit ≤ current_remainder × 100

## Complexity analysis

Time complexity: O(d)
- We compute exactly d decimal digits, each requiring O(1) operations

Space complexity: O(1)
- Only storing the current remainder and partial results

## Mathematical background

The digit-by-digit square root algorithm is a classical method that computes square roots
without floating-point arithmetic. It's based on the algebraic identity:

(a + b)² = a² + 2ab + b²

When we have a partial result and want to find the next digit, we use this identity to
determine what digit makes the square closest to (but not exceeding) our target.

## Key insights

Using integer arithmetic throughout avoids floating-point precision issues and gives us
exact results for each digit. This is much more reliable than using arbitrary precision
libraries and aligns with the "creative method" hint in the problem.
"""
module BonusRoot13

function compute_sqrt_digits(n::Int, num_decimal_digits::Int)
    integer_part = isqrt(n)

    remainder = BigInt(n - integer_part * integer_part)
    quotient_so_far = BigInt(integer_part)

    digits = Int[]

    for i in 1:num_decimal_digits
        remainder *= 100

        digit = 0

        for d in 0:9
            test_divisor = 20 * quotient_so_far + d
            test_product = test_divisor * d

            if test_product <= remainder
                digit = d
            else
                break
            end
        end

        divisor = 20 * quotient_so_far + digit
        remainder -= divisor * digit
        quotient_so_far = quotient_so_far * 10 + digit

        push!(digits, digit)
    end

    return digits
end

function sum_sqrt_decimal_digits(n::Int, num_digits::Int)
    digits = compute_sqrt_digits(n, num_digits)
    return sum(digits)
end

function solve()
    return sum_sqrt_decimal_digits(13, 1000)
end

end # module
