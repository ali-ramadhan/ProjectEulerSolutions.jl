# HackerRank ProjectEuler+ Problem 31: Coin Sums
# https://www.hackerrank.com/contests/projecteuler/challenges/euler031/problem
#
# Project Euler: https://projecteuler.net/problem=31
# Solution: https://aliramadhan.me/blog/project-euler/problem-0031/
#
# Problem Statement:
#   In England the currency is made up of pound, £, and pence, p, and there are
#   eight coins in general circulation:
#
#     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
#
#   It is possible to make £2 in the following way:
#
#     1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
#
#   How many different ways can V p be made using any number of coins? As the
#   result can be large print answer mod (10^9 + 7).
#
# Input Format:
#   The first line contains an integer T, i.e., number of test cases.
#   Next T lines will contain an integer V.
#
#   Note: N is given as p and not £
#
# Constraints:
#   1 <= T <= 10^4
#   1 <= V <= 10^5
#
# Output Format:
#   Print the values corresponding to each test case.
#
# Sample Input:
#   3
#   10
#   15
#   20
#
# Sample Output:
#   11
#   22
#   41

const MOD = 1_000_000_007
const MAX_VALUE = 100_000
const COINS = [1, 2, 5, 10, 20, 50, 100, 200]

function precompute_coin_combinations()
    # ways[amount+1] = number of ways to make 'amount'
    ways = zeros(Int, MAX_VALUE + 1)

    # Base case: 1 way to make 0 (use no coins)
    ways[1] = 1

    for coin in COINS
        for amount in coin:MAX_VALUE
            ways[amount + 1] = mod(ways[amount + 1] + ways[amount + 1 - coin], MOD)
        end
    end

    return ways
end

const WAYS = precompute_coin_combinations()

T = parse(Int, readline())

for _ in 1:T
    V = parse(Int, readline())
    println(WAYS[V + 1])
end
