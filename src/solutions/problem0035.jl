"""
Project Euler Problem 35: Circular Primes

Problem description: https://projecteuler.net/problem=35
Solution description: https://aliramadhan.me/blog/project-euler/problem-0035/
"""
module Problem0035

export find_circular_primes, solve

using ProjectEulerSolutions.Utils.Digits: rotate_digits
using ProjectEulerSolutions.Utils.Primes: is_prime, MillerRabin

# Some rotation of a number ends in each of its digits, so a circular prime with two or more digits cannot contain
# an even digit or a 5.
const CIRCULAR_DIGITS = (1, 3, 7, 9)

# The k-th d-digit candidate for k in 0:4^d-1: the digits of k in base 4 relabelled 0, 1, 2, 3 -> 1, 3, 7, 9.
# The relabelling preserves order, so the candidates come out in increasing order.
function candidate(k, d)
    n = 0
    place = 1
    for _ in 1:d
        k, i = divrem(k, 4)
        n += CIRCULAR_DIGITS[i + 1] * place
        place *= 10
    end
    return n
end

# A number and its rotations are either all circular primes or none are, so each rotation class is tested once,
# from its smallest member. Rotations at or above N must still be prime, but only members below N are collected.
function search_rotation_classes!(result, d, N, mr)
    for k in 0:4^d-1
        p = candidate(k, d)
        p >= N && break

        # Skip p unless it is the smallest of its rotations
        r = rotate_digits(p, d)
        minimal = true
        while r != p
            r < p && (minimal = false; break)
            r = rotate_digits(r, d)
        end
        minimal || continue

        # Rotating until we return to p visits each distinct rotation once
        r = p
        circular = true
        while true
            is_prime(r, mr) || (circular = false; break)
            r = rotate_digits(r, d)
            r == p && break
        end
        circular || continue

        r = p
        while true
            r < N && push!(result, r)
            r = rotate_digits(r, d)
            r == p && break
        end
    end
    return result
end

function find_circular_primes(N)
    result = [p for p in (2, 3, 5, 7) if p < N]

    for d in 2:ndigits(N - 1)
        mr = MillerRabin(10^d - 1)
        search_rotation_classes!(result, d, N, mr)
    end

    return result
end

function solve()
    circular_primes = find_circular_primes(10^6)
    @info "$(length(circular_primes)) circular primes below 10^6 with a sum of $(sum(circular_primes))"
    return length(circular_primes)
end

end # module
