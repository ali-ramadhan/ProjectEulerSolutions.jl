module AnswerHashing

using SHA
using TOML
using Test

export @test_answer, verify_answer, hash_answer

const ANSWERS_FILE = joinpath(@__DIR__, "..", "..", "test", "answers.toml")

function hash_answer(answer)
    return bytes2hex(sha256(string(answer)))
end

function load_hashes()
    isfile(ANSWERS_FILE) ? TOML.parsefile(ANSWERS_FILE) : Dict("problems" => Dict(), "bonus" => Dict())
end

function save_hashes(hashes)
    open(ANSWERS_FILE, "w") do io
        println(io, "# SHA256 hashes of correct answers")
        println(io, "# New hashes are auto-recorded when tests run")
        println(io)
        TOML.print(io, hashes; sorted=true)
    end
end

function verify_answer(problem_id, answer; category="problems")
    computed_hash = hash_answer(answer)
    hashes = load_hashes()
    expected = get(get(hashes, category, Dict()), problem_id, nothing)

    # Auto-record if no hash exists
    if expected === nothing
        haskey(hashes, category) || (hashes[category] = Dict{String,String}())
        hashes[category][problem_id] = computed_hash
        save_hashes(hashes)
        @info "Recorded new hash for $category/$problem_id: $answer -> $computed_hash"
        return true
    end

    return computed_hash == expected
end

macro test_answer(solve_expr, problem_id)
    quote
        @test verify_answer($(esc(problem_id)), $(esc(solve_expr)))
    end
end

macro test_answer(solve_expr, problem_id, category)
    quote
        @test verify_answer($(esc(problem_id)), $(esc(solve_expr)); category=$(esc(category)))
    end
end

end
