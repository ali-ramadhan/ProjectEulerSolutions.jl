# HackerRank ProjectEuler+ Problem 15: Lattice Paths
# https://www.hackerrank.com/contests/projecteuler/challenges/euler015/problem
#
# Project Euler: https://projecteuler.net/problem=15
# Solution: https://aliramadhan.me/blog/project-euler/problem-0015/

function count_lattice_paths(n, m)
    return binomial(n + m, n) % (10^9 + 7)
end

T = parse(Int, readline())
for _ in 1:T
    line = split(readline())
    N = parse(BigInt, line[1])
    M = parse(BigInt, line[2])
    println(count_lattice_paths(N, M))
end
