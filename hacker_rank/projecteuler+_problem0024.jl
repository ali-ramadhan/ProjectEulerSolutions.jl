# HackerRank ProjectEuler+ Problem 24: Lexicographic Permutations
# https://www.hackerrank.com/contests/projecteuler/challenges/euler024/problem
#
# Project Euler: https://projecteuler.net/problem=24
# Solution: https://aliramadhan.me/blog/project-euler/problem-0024/
#
# Problem Statement:
#   A permutation is an ordered arrangement of objects. For example, dabc is
#   one possible permutation of the word abcd. If all of the permutations are
#   listed alphabetically, we call it lexicographic order. The lexicographic
#   permutations of abc are:
#
#       abc, acb, bac, bca, cab, cba
#
#   What is the Nth lexicographic permutation of the word abcdefghijklm?
#
# Input Format:
#   First line contains T, number of test cases.
#   Next T lines each contain an integer N.
#
# Constraints:
#   1 <= T <= 1000
#   1 <= N <= 13!
#
# Output Format:
#   Print the Nth lexicographic permutation for each test case.
#
# Sample Input:
#   2
#   1
#   2
#
# Sample Output:
#   abcdefghijklm
#   abcdefghijkml

function find_nth_permutation(elements, n)
    elements = collect(elements)

    # Convert to 0-based indexing
    n = n - 1

    result = similar(elements, 0)

    for i in length(elements):-1:1
        fact = factorial(i - 1)

        idx = div(n, fact) + 1
        push!(result, elements[idx])

        deleteat!(elements, idx)

        n = n % fact
    end

    return result
end

function solve(n)
    letters = 'a':'m'
    perm = find_nth_permutation(letters, n)
    return join(perm)
end

T = parse(Int, readline())
for _ in 1:T
    N = parse(Int, readline())
    println(solve(N))
end
