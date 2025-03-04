"""
Project Euler Problem 37: Truncatable Primes

The number 3797 has an interesting property. Being prime itself, it is possible to
continuously remove digits from left to right, and remain prime at each stage:
3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.

Find the sum of the only eleven primes that are both truncatable from left to right
and right to left.

NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
"""
module Problem037

"""
    is_prime(n)

Check if n is prime using trial division with 6k±1 optimization.
"""
function is_prime(n)
    n <= 1 && return false
    n <= 3 && return true

    if n % 2 == 0 || n % 3 == 0
        return false
    end

    i = 5
    while i^2 <= n
        if n % i == 0 || n % (i + 2) == 0
            return false
        end
        i += 6
    end

    return true
end

"""
    is_truncatable_prime(p)

Check if a prime number `p` is truncatable from both left and right.
A truncatable prime is a prime where all its truncations (removing digits from either end)
are also prime.
"""
function is_truncatable_prime(p)
    # Single-digit primes are not considered truncatable
    p < 10 && return false

    # Check right truncations (dropping the rightmost digit)
    num = p ÷ 10
    while num > 0
        !is_prime(num) && return false
        num = num ÷ 10
    end

    # Check left truncations (dropping the leftmost digit)
    str_p = string(p)
    for i in 2:length(str_p)  # Start from 2 to skip the original number
        num = parse(Int, str_p[i:end])
        !is_prime(num) && return false
    end

    return true
end

"""
    find_truncatable_primes(count)

Find the specified count of truncatable primes.
Returns a vector containing all the truncatable primes found.
"""
function find_truncatable_primes(count)
    truncatable_primes = Int[]
    num = 11  # Starting from 11 as single-digit primes are not considered

    while length(truncatable_primes) < count
        if is_prime(num) && is_truncatable_prime(num)
            push!(truncatable_primes, num)
        end
        num += 2
    end

    return truncatable_primes
end

function solve()
    return sum(find_truncatable_primes(11))
end

end # module
