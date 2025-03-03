"""
Project Euler Problem 16: Power Digit Sum

2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

What is the sum of the digits of the number 2^1000?
"""
module Problem016

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
