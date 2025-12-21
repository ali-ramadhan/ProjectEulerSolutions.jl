using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0019

@test !is_leap_year(1900)
@test is_leap_year(1904)
@test is_leap_year(2000)
@test !is_leap_year(2001)

@test days_in_month(1, 2000) == 31  # January
@test days_in_month(2, 2000) == 29  # February in leap year
@test days_in_month(2, 2001) == 28  # February in non-leap year
@test days_in_month(4, 2000) == 30  # April
@test days_in_month(12, 2000) == 31 # December

# There are 2 Sundays on the first of the month in 1900 (but not part of the problem period)
@test count_sundays_on_first(1900, 1900) == 2

# Correct answer
@test_answer solve() "0019"
