"""
Project Euler Problem 56: Powerful Digit Sum

A googol (10^100) is a massive number: one followed by one-hundred zeros;
100^100 is almost unimaginably large: one followed by two-hundred zeros.
Despite their size, the sum of the digits in each number is only 1.

Considering natural numbers of the form, a^b, where a, b < 100,
what is the maximum digital sum?
"""
module Problem056

"""
    digit_sum(n)

Calculate the sum of digits of the number n.
"""
function digit_sum(n)
    return sum(parse(Int, d) for d in string(n))
end

"""
    max_digital_sum(limit)

Find the maximum digital sum for a^b where a, b < limit.
Returns the maximum sum found.
"""
function max_digital_sum(limit)
    max_sum = 0
    max_a = 0
    max_b = 0

    for a in 1:(limit - 1)
        # Skip a=1 as 1^b = 1 always
        a == 1 && continue

        # Skip cases where a is a multiple of 10, as the digit sum
        # of powers of 10 is always 1
        a % 10 == 0 && continue

        for b in 1:(limit - 1)
            power = big(a)^b
            current_sum = digit_sum(power)

            if current_sum > max_sum
                max_sum = current_sum
                max_a = a
                max_b = b
            end
        end
    end

    return max_sum
end

function solve()
    return max_digital_sum(100)
end

end # module
