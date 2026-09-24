"""
Project Euler Problem 34: Digit Factorials

Problem description: https://projecteuler.net/problem=34
Solution description: https://aliramadhan.me/blog/project-euler/problem-0034/
"""
module Problem0034

export find_digit_factorial_divisors, solve

using ProjectEulerSolutions.Utils.Digits: digit_factorial_sum

# A number with d digits cannot have a digit factorial sum greater than d * 9!, but when d > 7 all d-digit numbers
# are larger than d * 9! so we only need to search numbers with d ≤ 7.
const MAX_DIGITS = 7

# Check every d-digit number between lo and hi-1.
function search_numbers!(result, lo, hi)
    for n in lo:hi-1
        S = digit_factorial_sum(n)
        S % n == 0 && push!(result, (n, S ÷ n))
    end
    return result
end

# Check the multisets of d digits, picking the digits from 9 downward. For each sum S (the digit factorial sum of the
# multiset), check every divisor k of S that is within the range [lo, hi) and verify that n = S ÷ k has the desired
# properties. A d-digit n can only divide a sum S ≥ lo, so a branch stops as soon as its remaining slots, which hold
# digits no larger than m, can't lift S to lo. Stopping early like this follows PierrotLeFou
# (https://projecteuler.net/thread=34;page=8#453769) and Jonny (https://projecteuler.net/thread=34;page=8#456005).
function search_sums!(result, slots, lo, hi, max_digit=9, S=0)
    if slots == 0
        for k in (S ÷ hi + 1):(S ÷ lo)
            S % k == 0 || continue
            n = S ÷ k
            digit_factorial_sum(n) == S && push!(result, (n, k))
        end
        return result
    end

    for m in max_digit:-1:1
        S + slots * factorial(m) < lo && break
        search_sums!(result, slots - 1, lo, hi, m, S + factorial(m))
    end

    return result
end

# Numbers below N with at least two digits that divide the sum of the factorials of their digits, as sorted pairs
# (n, k) with digit_factorial_sum(n) == k * n. The numbers equal to their digit factorial sum are the pairs with k == 1.
function find_digit_factorial_divisors(N)
    result = Tuple{Int,Int}[]

    for d in 2:min(MAX_DIGITS, ndigits(N - 1))
        lo = 10^(d - 1)
        hi = min(10^d, N)

        n_numbers = hi - lo
        n_sums = binomial(8 + d, d)
        S_avg = d * sum(factorial, 1:9) / 9  # each digit 1-9 appears d/9 times on average
        k_avg = S_avg / lo

        if n_numbers <= n_sums * k_avg
            search_numbers!(result, lo, hi)
        else
            search_sums!(result, d, lo, hi)
        end
    end

    return unique!(sort!(result))
end

function solve()
    pairs = find_digit_factorial_divisors(10^MAX_DIGITS)

    @info "$(length(pairs)) numbers divide the sum of the factorials of their digits, " *
          "none with more than $(ndigits(last(pairs)[1])) digits"

    return sum(n for (n, k) in pairs if k == 1)
end

end # module
