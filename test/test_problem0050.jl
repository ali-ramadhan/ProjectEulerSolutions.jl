using ProjectEulerSolutions.Problem0050: find_longest_consecutive_prime_sum, solve

prime_100, length_100 = find_longest_consecutive_prime_sum(100)
@test prime_100 == 41
@test length_100 == 6

prime_1000, length_1000 = find_longest_consecutive_prime_sum(1000)
@test prime_1000 == 953
@test length_1000 == 21

@test solve() == 997651
