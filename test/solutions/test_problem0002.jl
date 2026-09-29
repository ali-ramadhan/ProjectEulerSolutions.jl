using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0002

for sum_even_fibs in (sum_even_fibonacci, sum_even_fibonacci_naive)
    @test sum_even_fibs(0) == 0
    @test sum_even_fibs(1) == 0
    for limit in 2:7
        @test sum_even_fibs(limit) == 2
    end
    @test sum_even_fibs(8) == 10
    @test sum_even_fibs(9) == 10
    @test sum_even_fibs(34) == 44

    # Correct answer
    @test_answer solve(sum_even_fibs) "0002"
end

# Both approaches agree over a wide range of limits
for limit in [0:100; 10 .^ (3:15)]
    @test sum_even_fibonacci(limit) == sum_even_fibonacci_naive(limit)
end

# Correct answer
@test_answer solve() "0002"
