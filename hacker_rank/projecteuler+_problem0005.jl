# HackerRank ProjectEuler+ Problem 5: Smallest Multiple
# https://www.hackerrank.com/contests/projecteuler/challenges/euler005/problem
#
# Project Euler: https://projecteuler.net/problem=5
# Solution: https://aliramadhan.me/blog/project-euler/problem-0005/
#
# Problem Statement:
#   2520 is the smallest number that can be divided by each of the numbers from
#   1 to 10 without any remainder. What is the smallest positive number that is
#   evenly divisible (divisible with no remainder) by all of the numbers from
#   1 to N?
#
# Input Format:
#   First line contains T that denotes the number of test cases.
#   This is followed by T lines, each containing an integer, N.
#
# Constraints:
#   1 ≤ T ≤ 10
#   1 ≤ N ≤ 40
#
# Output Format:
#   Print the required answer for each test case.
#
# Sample Input:
#   2
#   3
#   10
#
# Sample Output:
#   6
#   2520

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
