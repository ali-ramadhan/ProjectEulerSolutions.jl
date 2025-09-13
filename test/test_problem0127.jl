using Test
using ProjectEulerSolutions.Problem0127:
    compute_radicals_sieve, create_sorted_radical_list, find_abc_hits_sum, solve

# Test radical computation with known values
radicals = compute_radicals_sieve(32)
@test radicals[1] == 1      # rad(1) = 1
@test radicals[2] == 2      # rad(2) = 2
@test radicals[4] == 2      # rad(4) = rad(2²) = 2
@test radicals[8] == 2      # rad(8) = rad(2³) = 2
@test radicals[6] == 6      # rad(6) = rad(2×3) = 2×3 = 6
@test radicals[12] == 6     # rad(12) = rad(2²×3) = 2×3 = 6
@test radicals[30] == 30    # rad(30) = rad(2×3×5) = 2×3×5 = 30

# Test the example case (5, 27, 32) from the problem description
# rad(5×27×32) = rad(4320) should be 30
@test radicals[5] == 5      # rad(5) = 5
@test radicals[27] == 3     # rad(27) = rad(3³) = 3
@test radicals[32] == 2     # rad(32) = rad(2⁵) = 2

# Test sorted radical list functionality
sorted_pairs = create_sorted_radical_list(radicals)
@test sorted_pairs[1] == (1, 1)  # First pair should be (1, rad(1)=1)
@test issorted(sorted_pairs, by = pair -> pair[2])  # Should be sorted by radical

# Test for c < 1000 from the problem description (31 hits, sum = 12523)
@test find_abc_hits_sum(1000) == 12523

# Additional benchmarks from Project Euler forum
# Test for c < 100000 should give 418 hits with sum = 14125034
@test find_abc_hits_sum(100_000) == 14125034

# Correct answer
@test solve() == 18407904
