using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0030

# Example from problem statement
@test sort(find_digit_power_numbers(4)) == [1634, 8208, 9474]
@test sum(find_digit_power_numbers(4)) == 19316

# See: https://mathworld.wolfram.com/NarcissisticNumber.html
@test sort(find_digit_power_numbers(3)) == [153, 370, 371, 407]

# Correct answer
@test_answer solve() "0030"
