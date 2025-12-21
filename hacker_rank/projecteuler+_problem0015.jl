# HackerRank ProjectEuler+ Problem 15: Lattice Paths
# https://www.hackerrank.com/contests/projecteuler/challenges/euler015/problem
#
# Project Euler: https://projecteuler.net/problem=15
# Solution: https://aliramadhan.me/blog/project-euler/problem-0015/
#
# Problem Statement:
#   Starting in the top left corner of a 2x2 grid, and only being able to move
#   to the right and down, there are exactly 6 routes to the bottom right
#   corner.
#
#   How many such routes are there through a NxM grid? As number of ways can be
#   very large, print it modulo (10^9 + 7).
#
# Input Format:
#   The first line contains an integer T, i.e., number of test cases.
#   Next T lines will contain integers N and M.
#
# Constraints:
#   1 ≤ T ≤ 10^3
#   1 ≤ N ≤ 500
#   1 ≤ M ≤ 500
#
# Output Format:
#   Print the values corresponding to each test case.
#
# Sample Input:
#   2
#   2 2
#   3 2
#
# Sample Output:
#   6
#   10

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
