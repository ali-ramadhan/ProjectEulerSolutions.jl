# Project Euler #23: Non-Abundant Sums
# https://www.hackerrank.com/contests/projecteuler/challenges/euler023/problem
#
# Project Euler: https://projecteuler.net/problem=23
# Solution: https://aliramadhan.me/blog/project-euler/problem-0023/
#
# Problem:
#   A perfect number is a number for which the sum of its proper divisors is
#   exactly equal to the number. For example, the sum of the proper divisors of
#   28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
#
#   A number n is called deficient if the sum of its proper divisors is less
#   than n and it is called abundant if this sum exceeds n.
#
#   As 12 is the smallest abundant number (1 + 2 + 3 + 4 + 6 = 16), the smallest
#   number that can be written as the sum of two abundant numbers is 24. By
#   mathematical analysis, it can be shown that all integers greater than 28123
#   can be written as the sum of two abundant numbers. However, this upper limit
#   cannot be reduced any further by analysis even though it is known that the
#   greatest number that cannot be expressed as the sum of two abundant numbers
#   is less than this limit.
#
#   Given N, print YES if it can be expressed as sum of two abundant numbers,
#   else print NO.
#
# Input Format:
#   First line contains T, number of test cases.
#   Next T lines each contain an integer N.
#
# Constraints:
#   1 <= T <= 100
#   0 <= N <= 10^5
#
# Output Format:
#   Print YES or NO for each test case.

const MAX_N = 100000

function sum_proper_divisors_sieve(limit)
    sums = ones(Int, limit)
    sums[1] = 0
    for i in 2:div(limit, 2)
        for j in (2 * i):i:limit
            sums[j] += i
        end
    end
    return sums
end

function precompute_abundant_sums(limit)
    divisor_sums = sum_proper_divisors_sieve(limit)

    # Find all abundant numbers up to limit
    abundant_nums = [n for n in 1:limit if divisor_sums[n] > n]

    # Mark which numbers can be expressed as sum of two abundant numbers
    can_be_sum = falses(limit)
    for i in eachindex(abundant_nums)
        for j in i:lastindex(abundant_nums)
            s = abundant_nums[i] + abundant_nums[j]
            if s <= limit
                can_be_sum[s] = true
            else
                break
            end
        end
    end

    return can_be_sum
end

const CAN_BE_ABUNDANT_SUM = precompute_abundant_sums(MAX_N)

function solve(n)
    if n < 1 || n > MAX_N
        return "NO"
    end
    return CAN_BE_ABUNDANT_SUM[n] ? "YES" : "NO"
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(solve(N))
end
