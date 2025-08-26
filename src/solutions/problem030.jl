"""
Project Euler Problem 30: Digit Fifth Powers

Surprisingly there are only three numbers that can be written as the sum of fourth powers of
their digits:
1634 = 1^4 + 6^4 + 3^4 + 4^4
8208 = 8^4 + 2^4 + 0^4 + 8^4
9474 = 9^4 + 4^4 + 7^4 + 4^4

As 1 = 1^4 is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers of their
digits.

## Solution approach

We systematically search for numbers that equal the sum of their digits raised to the fifth
power:
1. Calculate an upper bound: find the largest n where n × 9^5 has at least n digits
2. For each number from 2 to this upper bound, check if it equals the sum of its digits to
   the fifth power
3. Sum all numbers that satisfy this property

The upper bound calculation ensures we don't miss any valid numbers while avoiding
unnecessary computation.

## Complexity analysis

Time complexity: O(U × d)
- U is the upper bound (≈ 6 × 9^5 = 354294 for fifth powers)
- For each number, we process d digits to compute the digit power sum
- d is at most log₁₀(U) ≈ 6 for our problem

Space complexity: O(k)
- We store k numbers that satisfy the condition (small constant)
- The digits() function uses temporary space proportional to the number of digits
"""
module Problem030

"""
    is_sum_of_digit_powers(n, power)

Check if a number equals the sum of its digits raised to the given power.
"""
function is_sum_of_digit_powers(n, power)
    digit_power_sum = sum(d^power for d in digits(n))
    return digit_power_sum == n
end

"""
    calculate_upper_bound(power)

Calculate the upper bound where n × 9^power has at least n digits.
"""
function calculate_upper_bound(power)
    n = 1
    while length(digits(n * 9^power)) >= n
        n += 1
    end
    return (n-1) * 9^power
end

"""
    find_sum_of_digit_power_numbers(power)

Find the sum of all numbers that equal the sum of their digits raised to the given power.
"""
function find_sum_of_digit_power_numbers(power)
    upper_bound = calculate_upper_bound(power)
    digit_power_numbers = [n for n in 2:upper_bound if is_sum_of_digit_powers(n, power)]
    return sum(digit_power_numbers)
end

function solve()
    return find_sum_of_digit_power_numbers(5)
end

end # module
