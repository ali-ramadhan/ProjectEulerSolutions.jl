module AnswerHashing

using SHA
using TOML
using Test

export @test_answer, verify_answer, hash_answer

const ANSWERS_FILE = joinpath(@__DIR__, "..", "..", "test", "answers.toml")

function hash_answer(answer)
    return bytes2hex(sha256(string(answer)))
end

# Problem numbers ("0012") are hashed under [problems] and bonus problem names ("root13") under [bonus].
answer_category(problem_id) = occursin(r"^\d{4}$", problem_id) ? "problems" : "bonus"

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

function verify_answer(problem_id, answer)
    category = answer_category(problem_id)
    computed_hash = hash_answer(answer)
    hashes = load_hashes()
    expected = get(get(hashes, category, Dict()), problem_id, nothing)

    # Auto-record if no hash exists, except on CI where the recorded hash would be thrown away with the
    # checkout and a missing (or forgotten) entry would otherwise pass with whatever answer was computed.
    if expected === nothing
        if get(ENV, "CI", "false") == "true"
            error("No answer hash recorded for $category/$problem_id. Answer hashes are not auto-recorded " *
                  "on CI: run the tests locally to record it, then commit test/answers.toml.")
        end

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

end
