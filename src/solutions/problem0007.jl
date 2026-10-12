"""
Project Euler Problem 7: 10001st Prime

Problem description: https://projecteuler.net/problem=7
Solution description: https://aliramadhan.me/blog/project-euler/problem-0007/
"""
module Problem0007

export find_nth_prime, find_nth_prime_counting, solve

using ProjectEulerSolutions.Utils.Primes: is_prime, sieve_of_eratosthenes, prime_pi,
    inverse_logarithmic_integral

function find_nth_prime(n)
    count = 0
    num = 1

    while count < n
        num += 1
        if is_prime(num)
            count += 1
        end
    end

    return num
end

# Aim just below the nth prime with li⁻¹(n), count the primes up to there exactly, then sieve
# upwards until we've counted to n.
function find_nth_prime_counting(n)
    x = floor(Int, inverse_logarithmic_integral(n))
    count = prime_pi(x)

    # li(x) > π(x) for every 2 ≤ x < 10^19, so x is always below the nth prime
    count < n || error("li⁻¹($n) = $x is not below the nth prime")

    # The n - count primes we still need are about ln x apart, so a window twice as long as that
    # usually holds all of them
    window = 2 * (n - count) * ceil(Int, log(x)) + 100
    lo = x + 1
    while true
        primes = sieve_of_eratosthenes(lo, lo + window - 1)
        count + length(primes) >= n && return primes[n - count]
        count += length(primes)
        lo += window
    end
end

function solve()
    result = find_nth_prime(10001)
    @info "The 10,001st prime is $result"
    return result
end

end # module
