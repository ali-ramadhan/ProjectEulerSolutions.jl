"""
Project Euler Problem 80: Square Root Digital Expansion

It is well known that if the square root of a natural number is not an integer, then it is irrational.
The decimal expansion of such square roots is infinite without any repeating pattern at all.

The square root of two is 1.41421356237309504880..., and the digital sum of the first one hundred decimal digits is 475.

For the first one hundred natural numbers, find the total of the digital sums of the first one hundred decimal digits for all the irrational square roots.
"""
module Problem080

"""
    is_perfect_square(n)

Check if a number is a perfect square.
"""
function is_perfect_square(n)
    root = isqrt(n)
    return root^2 == n
end

"""
    digit_sum_of_sqrt(n, digits_count)

Calculate the sum of the first `digits_count` digits of the square root of `n`,
including the integer part and decimal places.

Uses a string-based approach for better performance, converting the square root
to a string and summing the digits directly. Sets BigFloat precision based on
log₂(10) ≈ 3.32, which represents the number of bits needed to store one
decimal digit. We use 4 bits per digit as a safety margin to ensure sufficient
precision for all calculations.
"""
function digit_sum_of_sqrt(n, digits_count)
    precision_bits = ceil(Int, digits_count * 4)
    setprecision(BigFloat, precision_bits)

    sqrt_n = sqrt(BigFloat(n))

    sqrt_str = string(sqrt_n)
    sqrt_str = replace(sqrt_str, "." => "")

    digit_sum = 0
    for i in 1:min(length(sqrt_str), digits_count)
        digit_sum += parse(Int, sqrt_str[i])
    end

    return digit_sum
end

"""
    sum_square_root_digital_expansions(limit, digits_count)

Calculate the total of the digital sums of the first `digits_count` decimal digits
for all the irrational square roots among the first `limit` natural numbers.
"""
function sum_square_root_digital_expansions(limit, digits_count)
    total_sum = 0

    for n in 1:limit
        if !is_perfect_square(n)
            total_sum += digit_sum_of_sqrt(n, digits_count)
        end
    end

    return total_sum
end

function solve()
    return sum_square_root_digital_expansions(100, 100)
end

end # module
