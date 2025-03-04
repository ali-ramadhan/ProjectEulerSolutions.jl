"""
Project Euler Problem 30: Digit Fifth Powers

Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:
1634 = 1^4 + 6^4 + 3^4 + 4^4
8208 = 8^4 + 2^4 + 0^4 + 8^4
9474 = 9^4 + 4^4 + 7^4 + 4^4

As 1 = 1^4 is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.
"""
module Problem030

"""
    is_sum_of_digit_powers(n, power)

Check if a number is equal to the sum of its digits raised to the given power.
"""
function is_sum_of_digit_powers(n, power)
    digit_power_sum = sum(d^power for d in digits(n))
    return digit_power_sum == n
end

"""
    calculate_upper_bound(power)

Calculate the upper bound for the search space when looking for numbers that equal
the sum of their digits raised to a given power.

For a number with n digits:
- The maximum digit power sum possible is n × 9^power
- For a valid number, the digit power sum must have at least n digits
- We find the largest n where n × 9^power still has at least n digits
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

Find the sum of all numbers that can be written as the sum of the given power of their digits.

The function:
1. Determines a mathematically sound upper bound for the search
2. Identifies all numbers within the range that equal the sum of their digits raised to the given power
3. Returns the sum of all these special numbers
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
