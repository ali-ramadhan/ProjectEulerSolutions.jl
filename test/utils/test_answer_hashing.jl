using Test
using TOML
using SHA: sha256
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Utils.AnswerHashing: ANSWERS_FILE

@testset "AnswerHashing" begin
    @testset "hash_answer" begin
        @test hash_answer(42) == bytes2hex(sha256("42"))
        @test hash_answer("42") == hash_answer(42)
        @test hash_answer(42) != hash_answer(43)
    end

    @testset "verify_answer" begin
        # A recorded hash only matches the right answer (which is deliberately not written down here).
        @test !verify_answer("0001", -1)
        @test !verify_answer("root13", -1)
    end

    @testset "missing hash on CI" begin
        # Neither id can ever have a recorded hash, so this only runs where recording is refused.
        withenv("CI" => "true") do
            @test_throws "No answer hash recorded for problems/0000" verify_answer("0000", 0)
            @test_throws "No answer hash recorded for bonus/not_a_problem" verify_answer("not_a_problem", 0)
        end

        # ...and nothing was written to answers.toml
        hashes = TOML.parsefile(ANSWERS_FILE)
        @test !haskey(hashes["problems"], "0000")
        @test !haskey(hashes["bonus"], "not_a_problem")
    end
end
