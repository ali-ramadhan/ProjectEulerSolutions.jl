# Project Euler #26: Reciprocal Cycles
# https://www.hackerrank.com/contests/projecteuler/challenges/euler026/problem
#
# Project Euler: https://projecteuler.net/problem=26
# Solution: https://aliramadhan.me/blog/project-euler/problem-0026/
#
# A unit fraction contains 1 in the numerator. The decimal representation of
# the unit fractions with denominators 2 to 10 are given:
#
#   1/2  = 0.5
#   1/3  = 0.(3)
#   1/4  = 0.25
#   1/5  = 0.2
#   1/6  = 0.1(6)
#   1/7  = 0.(142857)
#   1/8  = 0.125
#   1/9  = 0.(1)
#   1/10 = 0.1
#
# Where 0.1(6) means 0.1666666..., and has a 1-digit recurring cycle.
# It can be seen that 1/7 has a 6-digit recurring cycle.
#
# Find the value of smallest d < N for which 1/d contains the longest
# recurring cycle in its decimal fraction part.
#
# Input Format:
#   First line contains T, the number of test cases.
#   Next T lines each contain an integer N.
#
# Constraints:
#   1 <= T <= 1000
#   4 <= N <= 10000
#
# Output Format:
#   Print the values corresponding to each test case.
#
# Sample Input:
#   2
#   5
#   10
#
# Sample Output:
#   3
#   7

function cycle_length(d)
    # Remove factors of 2 and 5 (they only affect termination, not cycle length)
    while d % 2 == 0
        d = div(d, 2)
    end
    while d % 5 == 0
        d = div(d, 5)
    end

    # No recurring cycle if only factors were 2 and 5
    d == 1 && return 0

    # Find smallest k where 10^k = 1 (mod d)
    remainder = 10 % d
    k = 1
    while remainder != 1
        remainder = (remainder * 10) % d
        k += 1
    end
    return k
end

function find_longest_cycle(limit)
    max_length = 0
    max_d = 0

    for d in 2:(limit - 1)
        length = cycle_length(d)
        if length > max_length
            max_length = length
            max_d = d
        end
    end

    return max_d
end

# Precompute answers for all possible N values
const MAX_N = 10000
const answers = Vector{Int}(undef, MAX_N)

function precompute!()
    best_d = 3
    best_length = cycle_length(3)

    for n in 4:MAX_N
        # Check if n-1 has a longer cycle than current best
        new_length = cycle_length(n - 1)
        if new_length > best_length
            best_d = n - 1
            best_length = new_length
        end
        answers[n] = best_d
    end
end

precompute!()

# Read number of test cases
T = parse(Int, readline())

for _ in 1:T
    N = parse(Int, readline())
    println(answers[N])
end
