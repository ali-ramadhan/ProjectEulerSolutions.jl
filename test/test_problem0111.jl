using Test
using ProjectEulerSolutions.Problem0111: find_primes_with_repeated_digit, solve
using ProjectEulerSolutions.Utils.Primes: is_prime

# Test all 10 cases from the 4-digit table in the problem description
# Expected values from the problem statement table
expected_4digit_results = [
    (0, 2, 13, 67061),   # digit 0: M(4,0)=2, N(4,0)=13, S(4,0)=67061
    (1, 3, 9, 22275),    # digit 1: M(4,1)=3, N(4,1)=9, S(4,1)=22275
    (2, 3, 1, 2221),     # digit 2: M(4,2)=3, N(4,2)=1, S(4,2)=2221
    (3, 3, 12, 46214),   # digit 3: M(4,3)=3, N(4,3)=12, S(4,3)=46214
    (4, 3, 2, 8888),     # digit 4: M(4,4)=3, N(4,4)=2, S(4,4)=8888
    (5, 3, 1, 5557),     # digit 5: M(4,5)=3, N(4,5)=1, S(4,5)=5557
    (6, 3, 1, 6661),     # digit 6: M(4,6)=3, N(4,6)=1, S(4,6)=6661
    (7, 3, 9, 57863),    # digit 7: M(4,7)=3, N(4,7)=9, S(4,7)=57863
    (8, 3, 1, 8887),     # digit 8: M(4,8)=3, N(4,8)=1, S(4,8)=8887
    (9, 3, 7, 48073)     # digit 9: M(4,9)=3, N(4,9)=7, S(4,9)=48073
]

for (digit, expected_M, expected_N, expected_S) in expected_4digit_results
    M, N, S = find_primes_with_repeated_digit(digit, 4)
    @test M == expected_M
    @test N == expected_N
    @test S == expected_S
end

# Verify the sum of all S(4,d) equals 273700 as stated in the problem
total_4digit_sum = sum(expected_S for (_, _, _, expected_S) in expected_4digit_results)
@test total_4digit_sum == 273700

# Test M(10,d) values based on forum consensus
expected_M_values = [
    (0, 8), (1, 9), (2, 8), (3, 9), (4, 9),
    (5, 9), (6, 9), (7, 9), (8, 8), (9, 9)
]

for (digit, expected_M) in expected_M_values
    M, N, S = find_primes_with_repeated_digit(digit, 10)
    @test M == expected_M
end

# Test N(10,d) values based on forum data
expected_N_values = [
    (0, 8), (1, 11), (2, 39), (3, 7), (4, 1),
    (5, 1), (6, 1), (7, 9), (8, 32), (9, 8)
]

for (digit, expected_N) in expected_N_values
    M, N, S = find_primes_with_repeated_digit(digit, 10)
    @test N == expected_N
end

# Test S(10,d) values based on forum data
expected_S_values = [
    (0, 38000000042), (1, 12882626601), (2, 97447914665), (3, 23234122821), (4, 4444444447),
    (5, 5555555557), (6, 6666666661), (7, 59950904793), (8, 285769942206), (9, 78455389922)
]

for (digit, expected_S) in expected_S_values
    M, N, S = find_primes_with_repeated_digit(digit, 10)
    @test S == expected_S
end

# Test total number of primes (should be 117 based on forum data)
total_primes = sum(expected_N for (_, expected_N) in expected_N_values)
@test total_primes == 117

# Correct answer
@test solve() == 612407567715
