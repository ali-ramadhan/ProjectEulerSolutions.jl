"""
Project Euler Bonus Problem: Root13

Problem description: https://projecteuler.net/problem=root13
Solution description: https://aliramadhan.me/blog/project-euler/bonus-root13/
"""
module BonusRoot13

export sum_sqrt_decimal_digits, solve

function compute_sqrt_digits(n, num_decimal_digits)
    integer_part = isqrt(n)

    R = BigInt(n - integer_part^2)
    p = BigInt(integer_part)

    digits = Int[]

    for _ in 1:num_decimal_digits
        R *= 100
        d = 0

        for digit in 0:9
            test_divisor = 20 * p + digit
            test_product = test_divisor * digit

            if test_product <= R
                d = digit
            else
                break
            end
        end

        divisor = 20 * p + d
        R -= divisor * d
        p = p * 10 + d

        push!(digits, d)
    end

    return digits
end

function sum_sqrt_decimal_digits(n, num_digits)
    digits = compute_sqrt_digits(n, num_digits)
    return sum(digits)
end

function solve()
    return sum_sqrt_decimal_digits(13, 1000)
end

end # module
