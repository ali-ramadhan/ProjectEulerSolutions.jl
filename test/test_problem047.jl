using ProjectEulerSolutions.Problem047:
    count_distinct_prime_factors, find_consecutive_with_distinct_prime_factors, solve

@test count_distinct_prime_factors(2) == 1
@test count_distinct_prime_factors(4) == 1  # 2²
@test count_distinct_prime_factors(6) == 2  # 2×3
@test count_distinct_prime_factors(8) == 1  # 2³
@test count_distinct_prime_factors(12) == 2  # 2²×3
@test count_distinct_prime_factors(14) == 2  # 2×7
@test count_distinct_prime_factors(15) == 2  # 3×5
@test count_distinct_prime_factors(644) == 3  # 2²×7×23
@test count_distinct_prime_factors(645) == 3  # 3×5×43
@test count_distinct_prime_factors(646) == 3  # 2×17×19

@test find_consecutive_with_distinct_prime_factors(2, 2) == 14
@test find_consecutive_with_distinct_prime_factors(3, 3) == 644

@test solve() == 134043
