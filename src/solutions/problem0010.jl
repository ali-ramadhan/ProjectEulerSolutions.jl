"""
Project Euler Problem 10: Summation of Primes

Problem description: https://projecteuler.net/problem=10
Solution description: https://aliramadhan.me/blog/project-euler/problem-0010/
"""
module Problem0010

export sum_of_primes_below, solve

using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes

function sum_of_primes_below(limit)
    primes = sieve_of_eratosthenes(limit)
    return primes, sum(primes)
end

function solve()
    primes, result = sum_of_primes_below(2_000_000)
    @info "Sum of $(length(primes)) primes below 2,000,000 is $result"
    return result
end

end # module
