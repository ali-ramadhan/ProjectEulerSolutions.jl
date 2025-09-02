using Test
using ProjectEulerSolutions.Problem122: compute_addition_chain_lengths, sum_minimum_multiplications, solve

# Helper function to get minimum multiplications for a single value
function get_min_multiplications(k)
    return compute_addition_chain_lengths(k)[k]
end

# Test basic cases
@test get_min_multiplications(1) == 0  # n^1 = n requires 0 multiplications
@test get_min_multiplications(2) == 1  # n^2 = n × n requires 1 multiplication
@test get_min_multiplications(3) == 2  # n^3 = n^2 × n requires 2 multiplications
@test get_min_multiplications(4) == 2  # n^4 = n^2 × n^2 requires 2 multiplications

# Test the key example from the problem description
@test get_min_multiplications(15) == 5

# Test powers of 2 (binary method should be optimal)
@test get_min_multiplications(8) == 3   # n^8 = ((n^2)^2)^2
@test get_min_multiplications(16) == 4  # n^16 = (((n^2)^2)^2)^2
@test get_min_multiplications(32) == 5  # n^32 follows binary method

# Critical test cases identified in Project Euler forum discussions
# These are the values that cause simple heuristics to fail
@test get_min_multiplications(77) == 8   # Critical case: Knuth's power tree fails here
@test get_min_multiplications(154) == 9  # Critical case: Factor method m(2k) = m(k)+1 fails here
@test get_min_multiplications(191) == 11 # Critical case: Deepest search required

# Test some other known cases
@test get_min_multiplications(7) == 4   # n^7 requires 4 steps in optimal addition chain
@test get_min_multiplications(12) == 4  # n^12 can be done in 4 steps


# Test batch computation consistency with smaller set
min_mults_small = compute_addition_chain_lengths(20)
for k in 1:20
    @test min_mults_small[k] == get_min_multiplications(k)
end

# Test larger batch including critical cases
min_mults_large = compute_addition_chain_lengths(200)
@test min_mults_large[77] == 8  # m(77) is a critical case where simple methods fail
@test min_mults_large[154] == 9  # Factor method failure case
@test min_mults_large[191] == 11  # Deepest search case

# Correct answer
@test solve() == 1582
