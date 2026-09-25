using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Utils.Digits: digit_rotations
using ProjectEulerSolutions.Utils.Primes: is_prime
using ProjectEulerSolutions.Problem0035: candidate, find_circular_primes, solve

# The thirteen circular primes below 100 from the problem statement, whose sum 446 is the HackerRank sample
@test find_circular_primes(100) == [2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, 97]
@test sum(find_circular_primes(100)) == 446

# Rotations may be at or above N: 13 and 17 count below 20 because 31 and 71 are prime, but 19 does not as 91 = 7 × 13
@test find_circular_primes(20) == [2, 3, 5, 7, 11, 13, 17]

# The bound is exclusive
@test find_circular_primes(10) == [2, 3, 5, 7]
@test find_circular_primes(11) == [2, 3, 5, 7]
@test find_circular_primes(12) == [2, 3, 5, 7, 11]

# The d-digit candidates are the 4^d numbers made of the digits 1, 3, 7 and 9, in increasing order
candidates = [candidate(k, 3) for k in 0:4^3-1]
@test candidates == [n for n in 100:999 if all(digit -> digit in (1, 3, 7, 9), digits(n))]

# Agrees with brute force over every prime below each limit
brute_force(N) = [p for p in 2:N-1 if is_prime(p) && all(is_prime, digit_rotations(p))]
for N in (100, 1000, 12_345, 10^5, 10^6)
    @test find_circular_primes(N) == brute_force(N)
end

# There are no circular primes with 7 to 9 digits, so the result saturates
@test find_circular_primes(10^9) == find_circular_primes(10^6)

# Correct answer
@test_answer solve() "0035"
