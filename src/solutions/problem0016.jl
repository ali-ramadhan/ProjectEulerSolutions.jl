"""
Project Euler Problem 16: Power Digit Sum

2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

What is the sum of the digits of the number 2^1000?

## Solution approach

We use Julia's BigInt arithmetic to compute 2^1000 exactly, then convert to
a string and sum the individual digit characters.

## Complexity analysis

Time complexity: O(d)
- Computing 2^1000 takes O(log(1000)) time using fast exponentiation
- Converting to string and summing digits takes O(d) time where d is the number of digits
- For 2^1000, d ≈ 302 digits

Space complexity: O(d)
- Stores the large integer result and its string representation
- Both require space proportional to the number of digits
"""
module Problem0016

"""
    sum_of_digits(n)

Calculate the sum of all digits in a given number.
"""
function sum_of_digits(n)
    sum = 0
    for digit in string(n)
        sum += parse(Int, digit)
    end
    return sum
end

"""
    power_digit_sum(base, exponent)

Calculate the sum of digits of base^exponent.
"""
function power_digit_sum(base, exponent)
    big_num = BigInt(base)^exponent
    return sum_of_digits(big_num)
end

function solve()
    return power_digit_sum(2, 1000)
end

end # module
