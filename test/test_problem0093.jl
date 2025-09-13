using Test
using ProjectEulerSolutions.Problem0093: all_expressions, consecutive_length, solve

results = all_expressions(1, 2, 3, 4)

@test 8 in results    # (4 * (1 + 3)) / 2
@test 14 in results   # 4 * (3 + 1 / 2)
@test 19 in results   # 4 * (2 + 3) - 1
@test 36 in results   # 3 * 4 * (2 + 1)

consecutive = consecutive_length(results)
@test consecutive == 28

@test consecutive_length(Set([1, 2, 3, 5, 6])) == 3  # 1,2,3 consecutive
@test consecutive_length(Set([2, 3, 4, 5])) == 0     # starts from 2, not 1
@test consecutive_length(Set([1, 3, 4, 5])) == 1     # only 1 consecutive from start

results_1258 = all_expressions(1, 2, 5, 8)
@test 44 in results_1258  # Requires intermediate 5.5 (e.g., 8 * (5 + 1/2))
@test consecutive_length(results_1258) == 51

results_1256 = all_expressions(1, 2, 5, 6)
consecutive_1256 = consecutive_length(results_1256)
@test consecutive_1256 < 51  # Should be around 43

# Correct answer
@test solve() == "1258"
