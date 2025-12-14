"""
Project Euler Problem 3: Largest Prime Factor

Problem description: https://projecteuler.net/problem=3
Solution description: https://aliramadhan.me/blog/project-euler/problem-0003/
"""
module Problem0003

using ProjectEulerSolutions.Utils.Primes: prime_factors

function largest_prime_factor(n)
    return maximum(prime_factors(n))
end

function solve()
    return largest_prime_factor(600851475143)
end

end # module
