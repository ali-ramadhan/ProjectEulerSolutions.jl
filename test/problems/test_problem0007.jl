using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0007

@test find_nth_prime(1) == 2
@test find_nth_prime(2) == 3
@test find_nth_prime(3) == 5
@test find_nth_prime(4) == 7
@test find_nth_prime(5) == 11
@test find_nth_prime(6) == 13

# Correct answer
@test_answer solve() "0007"
