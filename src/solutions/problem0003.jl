"""
Project Euler Problem 3: Largest Prime Factor

The prime factors of 13195 are 5, 7, 13 and 29.
What is the largest prime factor of the number 600851475143?

## Solution approach

Use the `prime_factors` utility function from Utils.Primes, which employs trial 
division to efficiently find all prime factors of a number by testing divisibility 
up to √n and collecting the prime divisors. Once all prime factors are obtained, 
return the maximum value using Julia's built-in maximum function.

## Complexity analysis

Time complexity: O(√n)
- The prime_factors function uses trial division up to √n, making this the dominant
  complexity factor.

Space complexity: O(log n)
- Storage for the list of prime factors, which is logarithmic in the input size.
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
