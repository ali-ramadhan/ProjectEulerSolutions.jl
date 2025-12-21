"""
Project Euler Problem 23: Non-Abundant Sums

Problem description: https://projecteuler.net/problem=23
Solution description: https://aliramadhan.me/blog/project-euler/problem-0023/
"""
module Problem0023

export find_abundant_numbers, sum_non_abundant_sums, solve

using ProjectEulerSolutions.Utils.Divisors: sum_proper_divisors_sieve

function find_abundant_numbers(limit)
    divisor_sums = sum_proper_divisors_sieve(limit)
    return [n for n in 1:limit if divisor_sums[n] > n]
end

function sum_non_abundant_sums(limit)
    abundant_nums = find_abundant_numbers(limit)

    can_be_sum = falses(limit)

    for i in eachindex(abundant_nums)
        for j in i:lastindex(abundant_nums)
            sum = abundant_nums[i] + abundant_nums[j]
            if sum <= limit
                can_be_sum[sum] = true
            else
                break
            end
        end
    end

    result = 0
    for i in 1:limit
        if !can_be_sum[i]
            result += i
        end
    end

    return result
end

function solve()
    return sum_non_abundant_sums(20161)  # Tighter bound per Wolfram MathWorld
end

end # module
