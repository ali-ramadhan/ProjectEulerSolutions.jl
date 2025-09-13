"""
Project Euler Problem 37: Truncatable Primes

The number 3797 has an interesting property. Being prime itself, it is possible to
continuously remove digits from left to right, and remain prime at each stage: 3797, 797,
97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.

Find the sum of the only eleven primes that are both truncatable from left to right and
right to left.

NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

## Solution approach

We need to find primes where all left and right truncations are also prime. We
systematically check numbers starting from 11 (since single-digit primes are excluded).

For each candidate prime, we perform two types of truncations:
1. Right truncation: Remove rightmost digit repeatedly (3797 → 379 → 37 → 3)
2. Left truncation: Remove leftmost digit repeatedly (3797 → 797 → 97 → 7)

We verify that all intermediate results are prime. Since the problem states there are
exactly eleven such primes, we can stop once we find them all.

Optimization: We only check odd numbers ≥ 11 since even numbers (except 2) cannot be prime.

## Complexity analysis

Time complexity: O(n × d × √p)
- Where n is the search range (we find all 11 within reasonable bounds)
- d is the average number of digits per candidate (log₁₀(n))
- √p is the cost of primality testing using trial division for numbers up to p
- We perform d truncations per candidate, each requiring primality testing

Space complexity: O(k)
- Where k = 11 (the number of truncatable primes to find)
- We store the found primes in a vector and use minimal working space
- No large data structures required
"""
module Problem0037

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
    truncatable_primes = find_truncatable_primes(11)
    @info "Found all 11 truncatable primes: $truncatable_primes"
    return sum(truncatable_primes)
end

end # module
