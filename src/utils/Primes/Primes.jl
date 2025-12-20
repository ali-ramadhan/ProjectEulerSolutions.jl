"""
Prime number utilities for Project Euler solutions.

This module provides optimized implementations of common prime number algorithms
that are used across multiple Project Euler problems.
"""
module Primes

export is_prime, TrialDivision, MillerRabin
export sieve_of_eratosthenes, sum_sieve_of_eratosthenes, prime_factors

#####
##### Primality tests
#####

abstract type PrimalityTest end

include("trial_division.jl")
include("miller_rabin.jl")

const DEFAULT_PRIMALITY_TEST = TrialDivision()

is_prime(n) = is_prime(n, DEFAULT_PRIMALITY_TEST)

#####
##### Sieve and factorization
#####

include("sieve.jl")
include("prime_factors.jl")

end # module Primes
