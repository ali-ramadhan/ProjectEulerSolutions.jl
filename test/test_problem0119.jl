using Test
using ProjectEulerSolutions.Problem0119: solve, find_digit_power_sum_numbers
using ProjectEulerSolutions.Utils.Digits: digit_sum

# Test the examples from the problem description
@test digit_sum(512) == 8
@test digit_sum(614656) == 28

# Test that we can find the sequence correctly
numbers = find_digit_power_sum_numbers(15)

# Verify the known values from the problem
@test length(numbers) >= 10  # Should have at least 10 numbers
@test numbers[1] == 81
@test numbers[2] == 512     # a₂ = 512
@test numbers[10] == 614656 # a₁₀ = 614656

# Correct answer
@test solve() == 248155780267521
