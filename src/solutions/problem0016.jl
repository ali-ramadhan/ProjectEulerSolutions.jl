"""
Project Euler Problem 16: Power Digit Sum

Problem description: https://projecteuler.net/problem=16
Solution description: https://aliramadhan.me/blog/project-euler/problem-0016/
"""
module Problem0016

export sum_of_digits, power_digit_sum, solve

function sum_of_digits(n)
    sum = 0
    for digit in string(n)
        sum += parse(Int, digit)
    end
    return sum
end

function power_digit_sum(base, exponent)
    big_num = BigInt(base)^exponent
    return sum_of_digits(big_num)
end

function solve()
    return power_digit_sum(2, 1000)
end

end # module
