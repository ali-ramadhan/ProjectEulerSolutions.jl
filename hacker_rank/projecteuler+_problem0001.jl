# HackerRank ProjectEuler+ Problem 1: Multiples of 3 and 5
# https://www.hackerrank.com/contests/projecteuler/challenges/euler001/problem
#
# Project Euler: https://projecteuler.net/problem=1
# Solution: https://aliramadhan.me/blog/project-euler/problem-0001/

function sum_multiples(n, limit)
    if n >= limit
        return 0
    end
    k = div(limit - 1, n)  # Number of multiples of n below limit
    return div(n * k * (k + 1), 2)
end

function sum_multiples_two_inclusion_exclusion(a, b, limit)
    return sum_multiples(a, limit) +
           sum_multiples(b, limit) -
           sum_multiples(lcm(a, b), limit)
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(sum_multiples_two_inclusion_exclusion(3, 5, N))
end
