"""
Project Euler Problem 37: Truncatable Primes

Problem description: https://projecteuler.net/problem=37
Solution description: https://aliramadhan.me/blog/project-euler/problem-0037/
"""
module Problem0037

export find_right_truncatable_primes, find_truncatable_primes, solve

using Base.Checked: checked_add, checked_mul
using ProjectEulerSolutions.Utils.Primes: is_prime, MillerRabin

# Build a tree of right-truncatable primes by starting with all prime digits in `base` and keep appending prime digits.
# The tree is finite, so we grow all of it breadth-first, using the result vector as the queue which is sorted by
# construction.
function find_right_truncatable_primes(; base=10)
    mr = MillerRabin()
    last_digits = [d for d in 1:base-1 if gcd(d, base) == 1]
    primes = [p for p in 2:base-1 if is_prime(p, mr)]

    i = 1
    while i <= length(primes)
        parent = primes[i]
        for d in last_digits
            child = checked_add(checked_mul(base, parent), d)
            is_prime(child, mr) && push!(primes, child)
        end
        i += 1
    end

    return primes
end

# Check the suffixes of p, shortest first as they are the cheapest to test.
function is_left_truncatable(p, base, mr)
    m = base
    while m < p
        is_prime(p % m, mr) || return false
        m *= base
    end
    return true
end

# Every truncatable prime is right-truncatable, so the truncatable primes are the right-truncatable primes whose
# suffixes are all prime too.
function find_truncatable_primes(; base=10)
    mr = MillerRabin()
    return [
        p for p in find_right_truncatable_primes(; base)
        if p >= base && is_left_truncatable(p, base, mr)
    ]
end

function solve()
    right_truncatable = find_right_truncatable_primes()
    truncatable = find_truncatable_primes()
    @info "Searched all $(length(right_truncatable)) right-truncatable primes, the largest being " *
          "$(last(right_truncatable)), and found $(length(truncatable)) truncatable primes"
    return sum(truncatable)
end

end # module
