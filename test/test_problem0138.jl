using Test
using ProjectEulerSolutions.Problem0138: find_special_triangles, verify_triangle, solve

# Test the examples given in the problem
@test verify_triangle(17) == (16, 15)  # First example: b=16, L=17, h=15=b-1
@test verify_triangle(305) == (272, 273)  # Second example: b=272, L=305, h=273=b+1

# Test smaller triangle sums
@test find_special_triangles(1) == 17  # Should give the first L value
@test find_special_triangles(2) == 17 + 305  # Should give sum of first two L values

# Test the third L value from the recurrence
@test find_special_triangles(3) == 17 + 305 + 5473

# Test verification function with invalid inputs
@test verify_triangle(1) === nothing  # Too small to form valid triangle
@test verify_triangle(2) === nothing  # Too small

# Test that the third triangle is valid
@test verify_triangle(5473) == (4896, 4895)

# Correct answer
@test solve() == 1118049290473932
