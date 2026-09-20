using Test

include(joinpath(@__DIR__, "..", "..", "src", "solutions", "bonus_heegner.jl"))
using .BonusHeegner: find_closest_cos_to_integer
include(joinpath(@__DIR__, "..", "..", "src", "utils", "AnswerHashing.jl"))
using .AnswerHashing: @test_answer

@testset "Threaded Heegner precision" begin
    original_precision = precision(BigFloat)
    for bits in (192, 320)
        setprecision(BigFloat, bits) do
            @test_answer find_closest_cos_to_integer(1000) "heegner"
            @test precision(BigFloat) == bits
        end
        @test precision(BigFloat) == original_precision
    end
end
