using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0002

@test sum_even_fibonacci(0) == 0
@test sum_even_fibonacci(1) == 0
for limit in 2:7
    @test sum_even_fibonacci(limit) == 2
end
@test sum_even_fibonacci(8) == 10
@test sum_even_fibonacci(9) == 10
@test sum_even_fibonacci(34) == 44

# Correct answer
@test_answer solve() "0002"
