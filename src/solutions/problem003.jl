"""
Project Euler Problem 3: Largest Prime Factor

The prime factors of 13195 are 5, 7, 13 and 29.
What is the largest prime factor of the number 600851475143?
"""
module Problem003

using ProjectEulerSolutions.Utils.Primes: prime_factors

"""
    largest_prime_factor(n)

Find the largest prime factor of the integer n.
"""
function largest_prime_factor(n)
    return maximum(prime_factors(n))
end

function solve()
    return largest_prime_factor(600851475143)
end

end # module
