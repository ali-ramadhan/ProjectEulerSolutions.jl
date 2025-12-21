"""
Project Euler Problem 21: Amicable Numbers

Problem description: https://projecteuler.net/problem=21
Solution description: https://aliramadhan.me/blog/project-euler/problem-0021/
"""
module Problem0021

export sum_of_amicable_numbers, solve

using ProjectEulerSolutions.Utils.Divisors: sum_proper_divisors_sieve

function sum_of_amicable_numbers(limit)
    divisor_sums = sum_proper_divisors_sieve(limit)
    total = 0
    for a in 2:(limit - 1)
        b = divisor_sums[a]
        if b != a && b >= 1 && b <= limit && divisor_sums[b] == a
            total += a
        end
    end
    return total
end

function solve()
    return sum_of_amicable_numbers(10000)
end

end # module
