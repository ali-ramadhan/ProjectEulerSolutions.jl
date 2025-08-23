"""
Project Euler Problem 10: Summation of Primes

The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
Find the sum of all the primes below two million.
"""
module Problem010

using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes

"""
    sum_of_primes_below(limit)

Calculate the sum of all prime numbers below limit using the Sieve of Eratosthenes.
"""
function sum_of_primes_below(limit)
    primes = sieve_of_eratosthenes(limit)
    return sum(primes)
end

function solve()
    return sum_of_primes_below(2_000_000)
end

end # module
