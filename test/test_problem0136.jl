using Test
using ProjectEulerSolutions.Problem0135: count_solutions
using ProjectEulerSolutions.Problem0136: count_values_with_one_solution, solve

# Test specific forms that should have exactly one solution based on forum insights
@test count_solutions(3) == 1   # prime ≡ 3 (mod 4)
@test count_solutions(7) == 1   # prime ≡ 3 (mod 4)
@test count_solutions(11) == 1  # prime ≡ 3 (mod 4)
@test count_solutions(4) == 1   # n = 4 (special case)
@test count_solutions(12) == 1  # n = 4p with p = 3
@test count_solutions(16) == 1  # n = 16 (special case)
@test count_solutions(48) == 1  # n = 16p with p = 3

# Test forms that should NOT have exactly one solution
@test count_solutions(5) == 0   # prime ≡ 1 (mod 4)
@test count_solutions(9) == 0   # composite, not valid form
@test count_solutions(15) == 3  # composite with multiple solutions
@test count_solutions(1) == 0   # No solutions possible

# Critical test case from forum discussions - n=32 has exactly 2 solutions
@test count_solutions(32) == 2  # Important edge case

# Test the example case from the problem description
@test count_solutions(20) == 1  # 13² - 10² - 7² = 20

# Verify that there are 25 values below 100 with exactly one solution
@test count_values_with_one_solution(100) == 25

# Test the optimized algorithm on smaller scales
@test count_values_with_one_solution(100) == 25  # Known result from problem statement
@test count_values_with_one_solution(1000) > 0   # Should return positive count
@test count_values_with_one_solution(10000) > 0  # Should work efficiently even for larger inputs

# Correct answer
@test solve() == 2544559
