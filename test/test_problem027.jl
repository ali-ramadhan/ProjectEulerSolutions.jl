using ProjectEulerSolutions.Problem027: count_consecutive_primes, is_prime, find_quadratic_with_most_primes, solve

@test !is_prime(1)
@test is_prime(2)
@test is_prime(3)
@test !is_prime(4)
@test is_prime(5)
@test is_prime(41)
@test is_prime(1601)

# Example 1 from the problem: n² + n + 41 (a = 1, b = 41)
@test count_consecutive_primes(1, 41) == 40

# Example 2 from the problem: n² - 79n + 1601 (a = -79, b = 1601)
@test count_consecutive_primes(-79, 1601) == 80

@test solve() == -59231
