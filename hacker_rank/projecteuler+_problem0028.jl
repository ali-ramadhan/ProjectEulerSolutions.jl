# Project Euler #28: Number Spiral Diagonals
# https://www.hackerrank.com/contests/projecteuler/challenges/euler028/problem
#
# Project Euler: https://projecteuler.net/problem=28
# Solution: https://aliramadhan.me/blog/project-euler/problem-0028/
#
# Starting with the number 1 and moving to the right in a clockwise direction
# a 5 by 5 spiral is formed as follows:
#
#   21 22 23 24 25
#   20  7  8  9 10
#   19  6  1  2 11
#   18  5  4  3 12
#   17 16 15 14 13
#
# It can be verified that the sum of the numbers on the diagonals is 101.
# What is the sum of the numbers on the diagonals in a N x N (N is odd) spiral
# formed in the same way?
#
# As the sum will be huge you have to print the result mod (10^9 + 7).
#
# Input Format:
#   First line contains T, the number of test cases.
#   Next T lines each contain an integer N.
#
# Constraints:
#   1 <= T <= 10^5
#   1 <= N < 10^18, N is odd
#
# Output Format:
#   Print the values corresponding to each test case.
#
# Sample Input:
#   2
#   3
#   5
#
# Sample Output:
#   25
#   101

const MOD = 1_000_000_007

function diagonal_sum(n)
    # m = (n - 1) / 2
    # The formula simplifies to: (16m^3 + 30m^2 + 26m + 3) / 3
    m = div(n - 1, 2)
    result = div(16 * m^3 + 30 * m^2 + 26 * m + 3, 3)
    return mod(result, MOD)
end

# Read number of test cases
T = parse(Int, readline())

for _ in 1:T
    N = parse(BigInt, readline())
    println(diagonal_sum(N))
end
