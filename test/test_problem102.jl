using Test
using ProjectEulerSolutions.Problem102: triangle_area_signed, contains_origin, solve

# Test triangle area calculation
@test triangle_area_signed(0, 0, 1, 0, 0, 1) == 0.5
@test triangle_area_signed(0, 0, 0, 1, 1, 0) == -0.5

# Test the two example triangles from the problem description
# Triangle ABC: A(-340,495), B(-153,-910), C(835,-947) - contains origin
@test contains_origin(-340, 495, -153, -910, 835, -947) == true

# Triangle XYZ: X(-175,41), Y(-421,-714), Z(574,-645) - does not contain origin
@test contains_origin(-175, 41, -421, -714, 574, -645) == false

# Test some edge cases
# Triangle with origin as vertex should not contain origin (boundary case)
@test contains_origin(0, 0, 1, 0, 0, 1) == false

# Small triangle around origin should contain it
@test contains_origin(-1, -1, 1, -1, 0, 1) == true

# Test that solve returns the correct answer
@test solve() == 228
