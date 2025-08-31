using Test
using ProjectEulerSolutions.Problem113:
    count_increasing_numbers, count_decreasing_numbers, count_overlap_adjustment,
    count_non_bouncy_numbers, solve

# Test the basic functions with expected values from the corrected formula
@test count_increasing_numbers(1) == binomial(BigInt(10), BigInt(9)) - 1  # C(10,9) - 1 = 10 - 1 = 9
@test count_decreasing_numbers(1) == binomial(BigInt(11), BigInt(10)) - 1  # C(11,10) - 1 = 11 - 1 = 10  
@test count_overlap_adjustment(1) == 10

# For numbers below 100 (1-2 digits), there should be no bouncy numbers
#
# 1-digit: all 9 numbers (1-9) are non-bouncy
# 2-digit increasing: 11,12,13,...,19,22,23,...,99
# 2-digit decreasing: 10,20,21,30,31,32,40,41,42,43,...,99
#
# The problem states "Clearly there cannot be any bouncy numbers below one-hundred"
# So all 99 numbers from 1-99 should be non-bouncy
@test count_non_bouncy_numbers(2) == 99

# From problem description
@test count_non_bouncy_numbers(6) == 12951
@test count_non_bouncy_numbers(10) == 277032

# Correct answer
@test solve() == 51161058134250
