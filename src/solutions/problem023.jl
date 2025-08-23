"""
Project Euler Problem 23: Non-Abundant Sums

A perfect number is a number for which the sum of its proper divisors is exactly equal to the number.
For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than n
and it is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number
that can be written as the sum of two abundant numbers is 24. By mathematical analysis,
it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers.
However, this upper limit cannot be reduced any further by analysis even though it is known that
the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
"""
module Problem023

using ProjectEulerSolutions.Utils.Divisors: is_abundant

"""
    find_abundant_numbers(limit)

Find all abundant numbers up to the given limit.
"""
function find_abundant_numbers(limit)
    abundant_nums = Int[]

    for n in 1:limit
        if is_abundant(n)
            push!(abundant_nums, n)
        end
    end

    return abundant_nums
end

"""
    sum_non_abundant_sums(limit)

Calculate the sum of all positive integers up to 'limit' which cannot be written
as the sum of two abundant numbers.
"""
function sum_non_abundant_sums(limit)
    abundant_nums = find_abundant_numbers(limit)

    can_be_sum = falses(limit)

    for i in 1:length(abundant_nums)
        for j in i:length(abundant_nums)
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
    return sum_non_abundant_sums(28123)
end

end # module
