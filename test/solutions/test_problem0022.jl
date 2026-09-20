using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0022

@test name_value("COLIN") == 53

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
