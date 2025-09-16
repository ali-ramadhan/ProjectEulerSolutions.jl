using Test
using ProjectEulerSolutions.Problem0139: count_tileable_pythagorean_triangles, solve

# Test small cases to verify our approach
# For small perimeters, manually verify some results
small_count = count_tileable_pythagorean_triangles(100)
@test small_count >= 3  # Should find at least (3,4,5), (6,8,10), (9,12,15)

# Test that the count increases with larger limits
medium_count = count_tileable_pythagorean_triangles(1000)
@test medium_count > small_count

# Correct answer
@test solve() == 10057761
