using Test
using ProjectEulerSolutions.Problem124: compute_radicals_sieve, solve

# Test radical computation for small examples from the problem description
@test compute_radicals_sieve(10) == [1, 2, 3, 2, 5, 6, 7, 2, 3, 10]

# Test specific radical values mentioned in the problem
radicals_10 = compute_radicals_sieve(10)
@test radicals_10[1] == 1   # rad(1) = 1
@test radicals_10[2] == 2   # rad(2) = 2
@test radicals_10[3] == 3   # rad(3) = 3
@test radicals_10[4] == 2   # rad(4) = 2 (4 = 2²)
@test radicals_10[5] == 5   # rad(5) = 5
@test radicals_10[6] == 6   # rad(6) = 2 × 3 = 6
@test radicals_10[7] == 7   # rad(7) = 7
@test radicals_10[8] == 2   # rad(8) = 2 (8 = 2³)
@test radicals_10[9] == 3   # rad(9) = 3 (9 = 3²)
@test radicals_10[10] == 10 # rad(10) = 2 × 5 = 10

# Test the sorting logic by manually checking the first few elements
# For n ≤ 10, the sorted order should give us E(4) = 8 and E(6) = 9
function compute_sorted_pairs(limit)
    radicals = compute_radicals_sieve(limit)
    pairs = [(n, radicals[n]) for n in 1:limit]
    sort!(pairs, by = pair -> (pair[2], pair[1]))
    return pairs
end

sorted_10 = compute_sorted_pairs(10)
# From the problem description table:
# k=1: n=1, rad=1
# k=2: n=2, rad=2
# k=3: n=4, rad=2
# k=4: n=8, rad=2
# k=5: n=3, rad=3
# k=6: n=9, rad=3
# k=7: n=5, rad=5
# k=8: n=6, rad=6
# k=9: n=7, rad=7
# k=10: n=10, rad=10

@test sorted_10[1][1] == 1   # E(1) = 1
@test sorted_10[2][1] == 2   # E(2) = 2
@test sorted_10[3][1] == 4   # E(3) = 4
@test sorted_10[4][1] == 8   # E(4) = 8
@test sorted_10[5][1] == 3   # E(5) = 3
@test sorted_10[6][1] == 9   # E(6) = 9

# Test additional radical values for validation
radicals_504 = compute_radicals_sieve(504)
@test radicals_504[504] == 42  # rad(504) = 2 × 3 × 7 = 42 (from problem description)

# Test edge cases
@test compute_radicals_sieve(1) == [1]
@test compute_radicals_sieve(2) == [1, 2]

# Correct answer
@test solve() == 21417
