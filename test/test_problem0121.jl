using Test
using ProjectEulerSolutions.Problem0121: calculate_winning_probability, solve

# Test the 4-turn example from the problem description
@test calculate_winning_probability(4) == 11//120

# Test that the maximum prize fund for 4 turns is 10
winning_prob_4 = calculate_winning_probability(4)
max_prize_4 = Int(floor(1 / winning_prob_4))
@test max_prize_4 == 10

# Test some edge cases
@test calculate_winning_probability(1) == 1//2  # 1 turn: need 1 blue, prob = 1/2
@test calculate_winning_probability(3) == 7//24  # 3 turns: need 2+ blue

# Correct answer
@test solve() == 2269
