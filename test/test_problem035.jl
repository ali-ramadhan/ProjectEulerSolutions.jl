using ProjectEulerSolutions.Problem035:
    is_circular_prime, count_circular_primes_below, generate_primes_below, solve

primes, is_prime_arr = generate_primes_below(1000)

@test is_circular_prime(2, is_prime_arr) == true
@test is_circular_prime(3, is_prime_arr) == true
@test is_circular_prime(5, is_prime_arr) == true
@test is_circular_prime(7, is_prime_arr) == true

@test is_circular_prime(11, is_prime_arr) == true  # 11 is a circular prime
@test is_circular_prime(13, is_prime_arr) == true  # 13 and 31 are both prime
@test is_circular_prime(17, is_prime_arr) == true  # 17 and 71 are both prime
@test is_circular_prime(37, is_prime_arr) == true  # 37 and 73 are both prime
@test is_circular_prime(79, is_prime_arr) == true  # 79 and 97 are both prime
@test is_circular_prime(197, is_prime_arr) == true # 197, 971, 719 are all prime

@test is_circular_prime(19, is_prime_arr) == false  # 91 is not prime
@test is_circular_prime(23, is_prime_arr) == false  # 32 is not prime
@test is_circular_prime(41, is_prime_arr) == false  # 14 is not prime
@test is_circular_prime(83, is_prime_arr) == false  # 38 is not prime

@test count_circular_primes_below(100) == 13

@test solve() == 55
