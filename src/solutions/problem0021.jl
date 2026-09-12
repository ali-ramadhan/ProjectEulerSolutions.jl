"""
Project Euler Problem 21: Amicable Numbers

Problem description: https://projecteuler.net/problem=21
Solution description: https://aliramadhan.me/blog/project-euler/problem-0021/
"""
module Problem0021

export sum_of_amicable_numbers, solve

using ProjectEulerSolutions.Utils.Divisors: sum_divisors, sum_proper_divisors_sieve

function sum_of_amicable_numbers(limit)
    divisor_sums = sum_proper_divisors_sieve(limit)
    total = 0
    for a in 2:(limit - 1)
        b = divisor_sums[a]
        (b == a || b < 1) && continue
        # Only a must be below the limit; its amicable partner may be larger.
        partner_sum = b <= limit ? divisor_sums[b] : sum_divisors(b) - b
        if partner_sum == a
            total += a
        end
    end
    return total
end

function solve()
    return sum_of_amicable_numbers(10000)
end

end # module
