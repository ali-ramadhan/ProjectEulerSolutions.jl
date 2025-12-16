using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0022: parse_names, name_value, compute_name_scores, solve

@test name_value("COLIN") == 53
@test name_value("COLIN") * 938 == 49714

sample_content = "\"ALICE\",\"BOB\",\"COLIN\",\"DAVE\""
parsed_names = parse_names(sample_content)
@test parsed_names == ["ALICE", "BOB", "COLIN", "DAVE"]

expected_score =
    1 * name_value("ALICE") +
    2 * name_value("BOB") +
    3 * name_value("COLIN") +
    4 * name_value("DAVE")

@test compute_name_scores(parsed_names) == expected_score

# Correct answer
@test_answer solve() "0022"
