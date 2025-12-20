# HackerRank ProjectEuler+ Problem 5: Smallest Multiple
# https://www.hackerrank.com/contests/projecteuler/challenges/euler005/problem
#
# Project Euler: https://projecteuler.net/problem=5
# Solution: https://aliramadhan.me/blog/project-euler/problem-0005/

function smallest_multiple(n)
    result = 1
    for i in 2:n
        result = lcm(result, i)
    end
    return result
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(smallest_multiple(N))
end
