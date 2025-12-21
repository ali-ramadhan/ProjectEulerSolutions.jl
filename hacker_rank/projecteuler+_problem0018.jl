# HackerRank ProjectEuler+ Problem 18: Maximum Path Sum I
# https://www.hackerrank.com/contests/projecteuler/challenges/euler018/problem
#
# Project Euler: https://projecteuler.net/problem=18
# Solution: https://aliramadhan.me/blog/project-euler/problem-0018/
#
# Problem Statement:
# By starting at the top of the triangle below and moving to adjacent numbers
# on the row below, the maximum total from top to bottom is 23.
#
#       3
#      7 4
#     2 4 6
#    8 5 9 3
#
# That is, 3 + 7 + 4 + 9 = 23.
#
# Find the maximum total from top to bottom of the triangle given in input.
#
# Input Format:
# - First line contains T (number of test cases)
# - For each test case:
#   - First line contains N (number of rows in the triangle)
#   - Next N lines contain the triangle rows (i-th line has i numbers)
#
# Constraints:
# - 1 <= T <= 10
# - 1 <= N <= 15
# - numbers in [0, 100)
#
# Output Format:
# For each test case, print the maximum path sum on a new line.

function max_path_sum(triangle)
    max_sums = deepcopy(triangle)

    # Start from the second-to-last row and work upwards
    for i in (length(max_sums) - 1):-1:1
        for j in 1:length(max_sums[i])
            # Add the maximum of the two adjacent values in the row below
            max_sums[i][j] += max(max_sums[i + 1][j], max_sums[i + 1][j + 1])
        end
    end

    # The top of the triangle now contains the maximum path sum
    return max_sums[1][1]
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    triangle = Vector{Vector{Int}}(undef, N)
    for i in 1:N
        triangle[i] = parse.(Int, split(readline()))
    end
    println(max_path_sum(triangle))
end
