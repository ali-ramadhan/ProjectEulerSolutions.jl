"""
Utilities module for Project Euler solutions.

This module contains common mathematical functions and algorithms that are
reused across multiple Project Euler problems, helping to eliminate code duplication
and provide a centralized location for optimized implementations.
"""
module Utils

export save_benchmark

include("Benchmarks.jl")
include("Primes.jl")
include("Divisors.jl")
include("Digits.jl")
include("NumberTheory.jl")
include("Sequences.jl")

using .Benchmarks
using .Primes
using .Divisors
using .Digits
using .NumberTheory
using .Sequences

end # module Utils
