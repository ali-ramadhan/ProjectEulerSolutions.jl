using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0001: sum_multiples_two_generator, sum_multiples_two_ie, solve


for sum_multiples_two in (sum_multiples_two_generator, sum_multiples_two_ie)
    # Test example from problem description
    @test sum_multiples_two(3, 5, 10) == 23

    # Test edge cases and boundary conditions
    @test sum_multiples_two(3, 5, 1) == 0  # No multiples below 1
    @test sum_multiples_two(3, 5, 3) == 0  # No multiples below 3
    @test sum_multiples_two(3, 5, 4) == 3  # Only 3 is below 4
    @test sum_multiples_two(3, 5, 6) == 8  # 3 + 5 = 8
end

# Correct answer
@test_answer solve() "0001"
