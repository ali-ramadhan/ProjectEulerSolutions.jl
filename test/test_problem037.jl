using Test
using ProjectEulerSolutions.Problem037: is_truncatable_prime, find_truncatable_primes, solve

# Single-digit primes are not considered truncatable
@test !is_truncatable_prime(2)
@test !is_truncatable_prime(3)
@test !is_truncatable_prime(5)
@test !is_truncatable_prime(7)

@test !is_truncatable_prime(11) # 1 is not prime
@test !is_truncatable_prime(19) # 1 is not prime, 9 is not prime
@test is_truncatable_prime(3797) # Example from problem statement
@test is_truncatable_prime(73)   # 7 and 3 are both prime
@test is_truncatable_prime(313)  # 31, 13, and 3 are all prime

@test length(find_truncatable_primes(11)) == 11

@test solve() == 748317
