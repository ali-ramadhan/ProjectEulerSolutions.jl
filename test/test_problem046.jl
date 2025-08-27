using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes
using ProjectEulerSolutions.Problem046: is_prime_plus_twice_square, solve

# Test examples from problem description
primes, is_prime_list = sieve_of_eratosthenes(100; return_array=true)
twice_squares = Set(2 * s^2 for s in 1:10)

@test is_prime_plus_twice_square(9, primes, twice_squares)   # 9 = 7 + 2×1²
@test is_prime_plus_twice_square(15, primes, twice_squares)  # 15 = 7 + 2×2²
@test is_prime_plus_twice_square(21, primes, twice_squares)  # 21 = 3 + 2×3²
@test is_prime_plus_twice_square(25, primes, twice_squares)  # 25 = 7 + 2×3²
@test is_prime_plus_twice_square(27, primes, twice_squares)  # 27 = 19 + 2×2²
@test is_prime_plus_twice_square(33, primes, twice_squares)  # 33 = 31 + 2×1²

# Correct answer
@test solve() == 5777
