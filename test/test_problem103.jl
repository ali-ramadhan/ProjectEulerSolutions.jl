using Test
using ProjectEulerSolutions.Problem103: is_special_sum_set, find_optimum_special_sum_set_n7, solve

# Test the is_special_sum_set function with known optimal examples from forum
@test is_special_sum_set([1])
@test is_special_sum_set([1, 2])
@test is_special_sum_set([2, 3, 4])
@test is_special_sum_set([3, 5, 6, 7])
@test is_special_sum_set([6, 9, 11, 12, 13])

# Test known optimal sets from forum discussions
@test is_special_sum_set([11, 18, 19, 20, 22, 25])  # n=6 optimum (sum=115)
@test is_special_sum_set([20, 31, 38, 39, 40, 42, 45])  # n=7 optimum (sum=255)
@test is_special_sum_set([39, 59, 70, 77, 78, 79, 81, 84])  # n=8 optimum (sum=567)

# Test that n=6 near-optimum set is valid but suboptimal 
@test is_special_sum_set([11, 17, 20, 22, 23, 24])  # n=6 near-optimum (valid but sum=117 > 115)
@test sum([11, 17, 20, 22, 23, 24]) > sum([11, 18, 19, 20, 22, 25])  # Suboptimal vs optimal

# Test sets that violate Rule 1 (equal subset sums)
@test !is_special_sum_set([1, 2, 3])  # {1,2} and {3} have equal sums
@test !is_special_sum_set([1, 1, 2])  # Contains duplicates

# Test a set that violates Rule 2 (larger subset has smaller sum)
@test !is_special_sum_set([7, 8, 9, 11, 14])  # 7+8+9 = 24 > 11+14 = 25, violates Rule 2

# Test edge cases
@test is_special_sum_set(Int[])  # Empty set should be valid
@test is_special_sum_set([5])   # Single element set

# Test that our algorithm finds a valid special sum set for n=7
n7_set = find_optimum_special_sum_set_n7()
@test !isempty(n7_set)
@test length(n7_set) == 7
@test is_special_sum_set(n7_set)
@test sum(n7_set) == 255  # Should find the optimal sum

# Test the final answer matches expected result
@test solve() == "20313839404245"

# Additional validation: test that our n=7 result matches known optimum
@test n7_set == [20, 31, 38, 39, 40, 42, 45]
