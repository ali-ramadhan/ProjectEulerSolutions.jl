using Test
using ProjectEulerSolutions.Problem0135: count_solutions, count_values_with_ten_solutions, solve

# Test the example cases from the problem description
@test count_solutions(27) == 2
@test count_solutions(1155) == 10

# Test some small values to verify the algorithm
@test count_solutions(1) == 0    # No solutions possible
@test count_solutions(4) == 1    # x=3, y=2, z=1: 9-4-1=4
@test count_solutions(5) == 0    # No valid solutions

# Test intermediate cases - let's find actual values
@test count_solutions(9) == 0    # Check actual value
@test count_solutions(45) == 0   # Check actual value

# Verify that n=1155 is indeed the least value with exactly 10 solutions
# by checking that no smaller value has 10 solutions
function verify_1155_is_least()
    for n in 1:1154
        if count_solutions(n) == 10
            return false
        end
    end
    return true
end
@test verify_1155_is_least()

# Correct answer
@test solve() == 4989
