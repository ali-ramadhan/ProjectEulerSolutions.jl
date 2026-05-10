# HackerRank ProjectEuler+ Problem 33: Digit Cancelling Fractions
# https://www.hackerrank.com/contests/projecteuler/challenges/euler033/problem
#
# Project Euler: https://projecteuler.net/problem=33
# Solution: https://aliramadhan.me/blog/project-euler/problem-0033/
#
# Problem Statement:
#   The fraction 49/98 is a curious fraction. An inexperienced mathematician
#   while attempting to simplify it may incorrectly believe that 49/98 = 4/8 is
#   obtained by cancelling the 9s.
#
#   We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
#
#   Which means fractions where trailing 0's are cancelled are trivial. So we
#   will ignore all the cases where we have to cancel 0's.
#
#   You will be given 2 integers N and K. N represents the number of digits in
#   Numerator and Denominator, and K represents the exact number of digits to
#   be "cancelled" from Numerator and Denominator. Find every non-trivial
#   fraction,
#   (1) where numerator is less than denominator,
#   (2) and the value of the reduced fraction is equal to the original
#       fraction.
#
#   Sum all the Numerators and the Denominators of the original fractions, and
#   print them separated by a space.
#
# Input Format:
#   Input contains two integers N K.
#
# Constraints:
#   2 <= N <= 4
#   1 <= K <= N - 1
#
# Output Format:
#   Display 2 space separated integers that denote the sum of the Numerators
#   and the sum of the Denominators respectively of original fractions.
#   Note: You do not have to reduce the Numerator and Denominator.
#
# Sample Input:
#   2 1
#
# Sample Output:
#   110 322

function k_subsets(n, k)
    result = Vector{Vector{Int}}()
    pos = collect(1:k)
    while true
        push!(result, copy(pos))
        i = k
        while i > 0 && pos[i] == n - k + i
            i -= 1
        end
        i == 0 && break
        pos[i] += 1
        for j in (i + 1):k
            pos[j] = pos[j - 1] + 1
        end
    end
    return result
end

function find_curious_fractions(N, K)
    lo = 10^(N - 1)
    hi = 10^N - 1

    # Group numbers by (cancelled_digits, ratio) where ratio = n // remaining,
    # emitting pairs as each group grows.
    groups = Dict{Tuple{Vector{Int},Rational{Int}},Vector{Int}}()
    result = Set{Tuple{Int,Int}}()
    position_sets = k_subsets(N, K)

    for n in lo:hi
        digs = digits(n; pad=N)
        # MSB-first; otherwise rem (built below in index order) ends up digit-reversed.
        reverse!(digs)

        for pos in position_sets
            cancelled = sort!([digs[p] for p in pos])
            0 in cancelled && continue

            rem = 0
            for i in 1:N
                i in pos && continue
                rem = 10rem + digs[i]
            end
            rem == 0 && continue

            members = get!(Vector{Int}, groups, (cancelled, n // rem))
            n in members && continue  # same n via two pos sets (e.g. 11 with K=1)
            for m in members
                push!(result, (m, n))
            end
            push!(members, n)
        end
    end

    return collect(result)
end

N, K = parse.(Int, split(readline()))
fractions = find_curious_fractions(N, K)
println(sum(first, fractions), " ", sum(last, fractions))
