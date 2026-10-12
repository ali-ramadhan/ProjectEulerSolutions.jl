using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0007
using ProjectEulerSolutions.Utils.Primes: sieve_of_eratosthenes

@test find_nth_prime(1) == 2
@test find_nth_prime(2) == 3
@test find_nth_prime(3) == 5
@test find_nth_prime(4) == 7
@test find_nth_prime(5) == 11
@test find_nth_prime(6) == 13

# Counting primes agrees with trial division and, further out, with the sieve
@test all(find_nth_prime_counting(n) == find_nth_prime(n) for n in 1:1000)
primes = sieve_of_eratosthenes(10^6)
@test all(find_nth_prime_counting(n) == primes[n] for n in 1:97:length(primes))
@test find_nth_prime_counting(length(primes)) == primes[end]

# The 10ᵏth primes (OEIS A006988)
@test find_nth_prime_counting(10^6) == 15_485_863
@test find_nth_prime_counting(10^9) == 22_801_763_489
@test find_nth_prime_counting(10_001) == find_nth_prime(10_001)

# Correct answer
@test_answer solve() "0007"
