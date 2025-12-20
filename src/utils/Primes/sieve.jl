"""
    _sieve_of_eratosthenes(limit)

Internal function that generates the sieve boolean array for odd numbers.

Returns `(is_prime, limit)` where `is_prime[i]` indicates whether `2i + 1` is prime.
Returns `(Bool[], limit)` for `limit < 3`.
"""
function _sieve_of_eratosthenes(limit)
    limit < 3 && return (Bool[], limit)

    # index i represents the odd number 2i + 1
    max_index = (limit - 1) ÷ 2
    is_prime = fill(true, max_index)

    # For each prime p, mark odd multiples starting at p² which has index (p² - 1) ÷ 2.
    # The step between consecutive odd multiples is p.
    i = 1
    while (2i + 1)^2 <= limit
        if is_prime[i]
            p = 2i + 1
            for j in ((p^2 - 1) ÷ 2):p:max_index
                is_prime[j] = false
            end
        end
        i += 1
    end

    return is_prime, limit
end

"""
    sieve_of_eratosthenes(limit)

Generate all prime numbers up to and including the given limit using the Sieve of
Eratosthenes.

This implementation uses an odd-only sieve, storing only odd numbers to reduce memory
usage by approximately 50%. The algorithm efficiently identifies primes by eliminating
multiples in O(n log log n) time.

# Arguments
- `limit`: Upper bound for prime generation

# Returns
- Vector of prime numbers up to `limit`

# Examples
```julia
sieve_of_eratosthenes(10)  # returns [2, 3, 5, 7]
```
"""
function sieve_of_eratosthenes(limit)
    limit < 2 && return Int[]
    limit == 2 && return [2]

    is_prime, _ = _sieve_of_eratosthenes(limit)

    # Collect primes: 2 plus all odd primes
    primes = [2]
    for i in eachindex(is_prime)
        is_prime[i] && push!(primes, 2i + 1)
    end
    return primes
end

"""
    sum_sieve_of_eratosthenes(limit)

Calculate the sum of all prime numbers up to and including the given limit.

This is more memory-efficient than `sum(sieve_of_eratosthenes(limit))` as it
avoids allocating the primes vector.

# Arguments
- `limit`: Upper bound for prime summation

# Returns
- Sum of all primes up to `limit`

# Examples
```julia
sum_sieve_of_eratosthenes(10)  # returns 17 (2 + 3 + 5 + 7)
```
"""
function sum_sieve_of_eratosthenes(limit)
    limit < 2 && return 0
    limit == 2 && return 2

    is_prime, _ = _sieve_of_eratosthenes(limit)

    total = 2
    for i in eachindex(is_prime)
        is_prime[i] && (total += 2i + 1)
    end
    return total
end
