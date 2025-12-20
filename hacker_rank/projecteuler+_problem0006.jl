# HackerRank ProjectEuler+ Problem 6: Sum Square Difference
# https://www.hackerrank.com/contests/projecteuler/challenges/euler006/problem
#
# Project Euler: https://projecteuler.net/problem=6
# Solution: https://aliramadhan.me/blog/project-euler/problem-0006/

function sum_square_difference(n)
    return div(n * (n + 1) * (n - 1) * (3n + 2), 12)
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(sum_square_difference(N))
end
