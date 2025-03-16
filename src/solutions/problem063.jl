"""
Project Euler Problem 63: Powerful Digit Counts

The 5-digit number, 16807 = 7^5, is also a fifth power. Similarly, the 9-digit number,
134217728 = 8^9, is a ninth power.

How many n-digit positive integers exist which are also an nth power?
"""
module Problem063

"""
    count_powerful_digit_numbers()

Count the number of n-digit positive integers that are also an nth power.
For a number x^n to have exactly n digits, it must satisfy: 10^(n-1) ≤ x^n < 10^n
This constrains x to be less than 10 and n to be at most 1 / (1 - log10(x)).
"""
function count_powerful_digit_numbers()
    count = 0
    for x in 1:9  # x must be less than 10
        # For x^n to have exactly n digits, we need:
        # n ≤ 1 / (1 - log10(x))
        max_n = floor(Int, 1 / (1 - log10(x)))
        count += max_n
    end
    return count
end

function solve()
    return count_powerful_digit_numbers()
end

end # module
