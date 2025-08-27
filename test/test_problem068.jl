using Test
using ProjectEulerSolutions.Problem068: is_valid_configuration, ngon_string, solve

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

# Test the final solution
@test solve() == "6531031914842725"
