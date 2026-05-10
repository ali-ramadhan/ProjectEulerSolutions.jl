"""
Project Euler Problem 33: Digit Cancelling Fractions

Problem description: https://projecteuler.net/problem=33
Solution description: https://aliramadhan.me/blog/project-euler/problem-0033/
"""
module Problem0033

using Combinatorics: combinations

function find_curious_fractions(N, K)
    lo = 10^(N - 1)
    hi = 10^N - 1

    # Group numbers by (cancelled_digits, ratio) where ratio = n // leftover,
    # emitting pairs as each group grows.
    groups = Dict{Tuple{Vector{Int},Rational{Int}},Vector{Int}}()
    result = Set{Tuple{Int,Int}}()

    for n in lo:hi
        ds = digits(n; pad=N)

        # We want most significant bit first. Otherwise `rem` (built below) ends up digit-reversed.
        reverse!(ds)

        for pos in combinations(1:N, K)
            cancelled = sort!([ds[p] for p in pos])

            # Skip trivial cases like 30/50 or 410/790
            0 in cancelled && continue

            rem = 0
            for i in 1:N
                i in pos && continue
                rem = 10rem + ds[i]
            end
            rem == 0 && continue

            members = get!(Vector{Int}, groups, (cancelled, n // rem))

            # Don't hit the same butcket again (e.g. 11 with K=1).
            n in members && continue

            for m in members
                push!(result, (m, n))
            end
            push!(members, n)
        end
    end

    return sort!(collect(result))
end

function multiply_curious_fractions(N, K)
    fractions = find_curious_fractions(N, K)
    p = prod(BigInt(n) // BigInt(d) for (n, d) in fractions)
    return length(fractions), p
end

function solve()
    n, p = multiply_curious_fractions(2, 1)
    return denominator(p)
end

end # module
