using Test
using ProjectEulerSolutions.Problem0140: generate_pell_solutions, solution_to_n, find_golden_nuggets, solve

# Test that fundamental solutions satisfy y² - 5k² = 44
@test 7^2 - 5*1^2 == 44
@test 8^2 - 5*2^2 == 44
@test 13^2 - 5*5^2 == 44
@test 17^2 - 5*7^2 == 44

# Test Pell recurrence preserves the equation
solutions = generate_pell_solutions(7, 1, 3)
for (y, k) in solutions
    @test y^2 - 5*k^2 == 44
end

# Test solution_to_n function
@test solution_to_n(7, 1) == 0  # (7-7)/5 = 0
@test solution_to_n(17, 7) == 2  # (17-7)/5 = 2
@test solution_to_n(112, 50) == 21  # (112-7)/5 = 21
@test solution_to_n(217, 97) == 42  # (217-7)/5 = 42
@test solution_to_n(83, 37) === nothing  # (83-7)/5 not an integer
@test solution_to_n(8, 2) === nothing  # (8-7)/5 not an integer

# Test first few golden nuggets are correct
nuggets = find_golden_nuggets(10)
@test nuggets[1] == 2
@test nuggets[2] == 5
@test nuggets[3] == 21
@test nuggets[4] == 42
@test nuggets[5] == 152
@test nuggets[6] == 296

# Test that the 20th golden nugget is 211345365 (from problem statement)
nuggets_20 = find_golden_nuggets(20)
@test nuggets_20[20] == 211345365

# Test the final answer
@test solve() == 5673835352990
