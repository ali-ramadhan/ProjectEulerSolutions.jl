"""
Project Euler Problem 35: Circular Primes

The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.
There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
How many circular primes are there below one million?
"""
module Problem035

"""
    generate_primes_below(limit)

Generate all prime numbers below the given limit using the Sieve of Eratosthenes.
Returns a list of prime numbers and a boolean array indicating primality.
"""
function generate_primes_below(limit)
    is_prime = fill(true, limit)
    is_prime[1] = false

    for i in 2:isqrt(limit)
        if is_prime[i]
            for j in i^2:i:limit
                is_prime[j] = false
            end
        end
    end

    return [i for i in 1:limit-1 if is_prime[i]], is_prime
end

"""
    has_even_digit(n)

Check if a number n has any even digits (0, 2, 4, 6, 8).
This is used to optimize the circular prime check since any multi-digit number
containing an even digit can't be a circular prime (except for single-digit 2).
"""
function has_even_digit(n)
    n_str = string(n)
    return any(c -> c in "02468", n_str)
end

"""
    rotations(n)

Generate all rotations of the digits of n.
For example, if n=197, returns [197, 971, 719].
"""
function rotations(n)
    n_str = string(n)
    len = length(n_str)
    rotations = Int[]

    for i in 1:len
        rotated = n_str[i:end] * n_str[1:i-1]
        push!(rotations, parse(Int, rotated))
    end

    return rotations
end

"""
    is_circular_prime(n, is_prime)

Check if n is a circular prime, i.e., if all rotations of its digits are prime.
is_prime is a boolean array where is_prime[i] is true if i is prime.
"""
function is_circular_prime(n, is_prime)
    if n >= length(is_prime) || !is_prime[n]
        return false
    end

    # Single-digit primes are circular by definition
    if n < 10
        return true
    end

    if has_even_digit(n)
        return false
    end

    for rotation in rotations(n)
        if rotation >= length(is_prime) || !is_prime[rotation]
            return false
        end
    end

    return true
end

"""
    count_circular_primes_below(limit)

Count the number of circular primes below the given limit.
"""
function count_circular_primes_below(limit)
    primes, is_prime_arr = generate_primes_below(limit)

    count = 0
    for prime in primes
        if is_circular_prime(prime, is_prime_arr)
            count += 1
        end
    end

    return count
end

function solve()
    return count_circular_primes_below(1_000_000)
end

end # module
