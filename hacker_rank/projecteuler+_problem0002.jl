# HackerRank ProjectEuler+ Problem 2: Even Fibonacci Numbers
# https://www.hackerrank.com/contests/projecteuler/challenges/euler002/problem
#
# Project Euler: https://projecteuler.net/problem=2
# Solution: https://aliramadhan.me/blog/project-euler/problem-0002/

function sum_even_fibonacci(limit)
    if limit < 2
        return 0
    end

    # Even Fibonacci numbers follow the recurrence: E(n) = 4*E(n-1) + E(n-2)
    # Starting with E(1) = 2, E(2) = 8
    a, b = 2, 8
    result = a

    if b > limit
        return result
    end
    result += b

    while (c = 4b + a) <= limit
        result += c
        a, b = b, c
    end

    return result
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(sum_even_fibonacci(N))
end
