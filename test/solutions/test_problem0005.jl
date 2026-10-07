using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0005

# Test example from problem description
@test smallest_multiple(10) == 2520
@test smallest_multiple_primorial(10) == 2520

# The primorial method agrees with the iterated lcm
for n in [1:100; 1000; 4321]
    @test smallest_multiple_primorial(n) == smallest_multiple(big(n))
end
@test smallest_multiple_primorial(20) == smallest_multiple(20)
@test smallest_multiple_primorial(BigInt(88)) == smallest_multiple(Int128(88))
@test ndigits(smallest_multiple_primorial(100_000)) == 43452

# Correct answer
@test_answer solve() "0005"
