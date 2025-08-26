using Test
using ProjectEulerSolutions.Problem103: is_special_sum_set, find_optimum_special_sum_set, solve

# Test the is_special_sum_set function with known examples
@test is_special_sum_set([1])
@test is_special_sum_set([1, 2])
@test is_special_sum_set([2, 3, 4])
@test is_special_sum_set([3, 5, 6, 7])
@test is_special_sum_set([6, 9, 11, 12, 13])

# Test the known optimum set for n=6
@test is_special_sum_set([11, 18, 19, 20, 22, 25])

# Test some non-special sum sets
@test !is_special_sum_set([1, 2, 3])  # {1,2} and {3} have equal sums
@test !is_special_sum_set([1, 1, 2])  # Contains duplicates and violates rules

# Test edge cases
@test is_special_sum_set(Int[])  # Empty set should be valid

# Test that the solution for n=7 gives a valid special sum set
n7_set = find_optimum_special_sum_set(7)
if !isempty(n7_set)
    @test is_special_sum_set(n7_set)
    @test length(n7_set) == 7
end

# Test the actual solution
@test solve() == "20313839404245"