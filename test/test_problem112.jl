using Test
using ProjectEulerSolutions.Problem112: is_increasing, is_decreasing, is_bouncy, solve

# Test increasing numbers
@test is_increasing(134468) == true  # Example from problem
@test is_increasing(123) == true
@test is_increasing(1234) == true
@test is_increasing(1) == true
@test is_increasing(11) == true
@test is_increasing(1223) == true

# Test decreasing numbers
@test is_decreasing(66420) == true  # Example from problem
@test is_decreasing(321) == true
@test is_decreasing(4321) == true
@test is_decreasing(1) == true
@test is_decreasing(11) == true
@test is_decreasing(4433) == true

# Test bouncy numbers
@test is_bouncy(155349) == true  # Example from problem
@test is_bouncy(132) == true
@test is_bouncy(1321) == true
@test is_bouncy(1234321) == true

# Test that single digits are not bouncy
@test is_bouncy(1) == false
@test is_bouncy(5) == false
@test is_bouncy(9) == false

# Test that some two-digit numbers are not bouncy
@test is_bouncy(12) == false  # increasing
@test is_bouncy(21) == false  # decreasing
@test is_bouncy(11) == false  # both increasing and decreasing

# Test edge cases for classification functions
@test is_increasing(1211) == false  # has decrease
@test is_decreasing(2112) == false  # has increase

# Test that we can distinguish between the three types
@test is_increasing(123) && !is_decreasing(123) && !is_bouncy(123)
@test !is_increasing(321) && is_decreasing(321) && !is_bouncy(321)
@test !is_increasing(132) && !is_decreasing(132) && is_bouncy(132)

# Correct answer
@test solve() == 1587000
