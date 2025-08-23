using Test
using ProjectEulerSolutions.Problem088: find_minimal_product_sums, solve

# Test small cases from the problem description
minimal_small = find_minimal_product_sums(12)

# Test specific minimal product-sum numbers
@test minimal_small[2] == 4  # k=2: 4 = 2×2 = 2+2
@test minimal_small[3] == 6  # k=3: 6 = 1×2×3 = 1+2+3
@test minimal_small[4] == 8  # k=4: 8 = 1×1×2×4 = 1+1+2+4
@test minimal_small[5] == 8  # k=5: 8 = 1×1×2×2×2 = 1+1+2+2+2
@test minimal_small[6] == 12 # k=6: 12 = 1×1×1×1×2×6 = 1+1+1+1+2+6

# Test the sum for k=2 to 6 (should be 30, but 8 counted once)
unique_values_6 = Set([minimal_small[k] for k in 2:6])
@test sum(unique_values_6) == 30

# Test that the complete set for k=2 to 12 gives sum 61
unique_values_12 = Set([minimal_small[k] for k in 2:12])
@test sum(unique_values_12) == 61

# Verify the complete set is {4, 6, 8, 12, 15, 16}
@test unique_values_12 == Set([4, 6, 8, 12, 15, 16])

# Test main solve function
# This will compute the actual answer for k=2 to 12000
@test solve() == 7587457
