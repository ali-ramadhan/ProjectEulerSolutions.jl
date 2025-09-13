using Test
using ProjectEulerSolutions.Problem0066: pell_solution, find_d_with_largest_x, solve

# Test the pell_solution function with known examples from the problem statement
@test pell_solution(2) == (3, 2)
@test pell_solution(3) == (2, 1)
@test pell_solution(5) == (9, 4)
@test pell_solution(6) == (5, 2)
@test pell_solution(7) == (8, 3)

# Test the example from the problem where D=13
@test pell_solution(13) == (649, 180)

# Test that perfect squares return (0, 0) as they have no solutions
@test pell_solution(4) == (0, 0)
@test pell_solution(9) == (0, 0)
@test pell_solution(16) == (0, 0)

# Test the find_d_with_largest_x function with the example from the problem
@test find_d_with_largest_x(7)[1] == 5

@test solve() == 661

# See: https://projecteuler.net/thread=66#4273
@test find_d_with_largest_x(10_000)[1] == 9949

# See: https://projecteuler.net/thread=66;page=2#5225
@test find_d_with_largest_x(100_000)[1] == 92821
