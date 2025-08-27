using Test
using ProjectEulerSolutions.Problem105: is_special_sum_set, parse_sets_file, solve

# Test the two example sets from the problem description
@test is_special_sum_set([81, 88, 75, 42, 87, 84, 86, 65]) == false
@test is_special_sum_set([157, 150, 164, 119, 79, 159, 161, 139, 158]) == true

# Test some basic special sum sets
@test is_special_sum_set([1]) == true
@test is_special_sum_set([1, 2]) == true
@test is_special_sum_set([2, 3, 4]) == true

# Test edge cases
@test is_special_sum_set(Int[]) == true
@test is_special_sum_set([1, 2, 2]) == false  # Not sorted properly but should handle it

# Test parsing functionality - verify we can read the data file
filename = joinpath(@__DIR__, "..", "data", "0105_sets.txt")
sets = parse_sets_file(filename)
@test length(sets) == 100
@test sets[1] == [81, 88, 75, 42, 87, 84, 86, 65]
@test sets[2] == [157, 150, 164, 119, 79, 159, 161, 139, 158]

# Test that the example special sum set has the expected sum
@test sum([157, 150, 164, 119, 79, 159, 161, 139, 158]) == 1286

# Test the final solve function
@test solve() == 73702
