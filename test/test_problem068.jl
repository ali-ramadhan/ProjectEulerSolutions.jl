using Test
using ProjectEulerSolutions.Problem068:
    is_valid_configuration, ngon_string, find_max_magic_5gon, solve

# Test the validity of the solution for the 3-gon ring example from the problem statement
outer_3gon = [4, 6, 5]
inner_3gon = [3, 2, 1]
@test is_valid_configuration(outer_3gon, inner_3gon) == 9
@test ngon_string(outer_3gon, inner_3gon) == "432621513"

# Test alternative 3-gon configuration from the problem statement
outer_3gon2 = [4, 5, 6]
inner_3gon2 = [2, 3, 1]
@test is_valid_configuration(outer_3gon2, inner_3gon2) == 9
@test ngon_string(outer_3gon2, inner_3gon2) == "423531612"

# Test the logical deduction: outer {6,7,8,9,10} and inner {1,2,3,4,5} with magic sum 14
# This should be a valid configuration for the maximum solution
outer_max = [6, 7, 8, 9, 10]
inner_max = [1, 2, 3, 4, 5]
# The exact arrangement will be determined by the algorithm, but the sum should be 14
# We'll test a specific valid arrangement that produces the known answer
outer_solution = [6, 10, 9, 8, 7]  # One valid arrangement
inner_solution = [5, 3, 1, 4, 2]   # Corresponding inner arrangement
@test is_valid_configuration(outer_solution, inner_solution) == 14

# Test that the optimized function finds the correct maximum
@test find_max_magic_5gon() == "6531031914842725"

# Test the final solution
@test solve() == "6531031914842725"

# Test edge case: verify that putting 10 in inner ring would create 17-digit string
# (This is more of a conceptual test - we don't implement this case but verify our logic)
outer_17digit = [6, 7, 8, 9, 5]  # 10 not in outer
inner_17digit = [1, 2, 3, 4, 10] # 10 in inner
if is_valid_configuration(outer_17digit, inner_17digit) > 0
    string_17 = ngon_string(outer_17digit, inner_17digit)
    @test length(string_17) == 17  # Verify it would be 17 digits
end
