using Test
using ProjectEulerSolutions.Problem075: is_valid_pair, generate_pythagorean_triple, solve

# Test valid pairs for generating primitive Pythagorean triples
@test is_valid_pair(2, 1) == true   # gcd(2,1)=1, not both odd
@test is_valid_pair(3, 2) == true   # gcd(3,2)=1, not both odd
@test is_valid_pair(3, 1) == false  # both are odd
@test is_valid_pair(4, 2) == false  # gcd(4,2)=2

# Test generating Pythagorean triples
a, b, c, p = generate_pythagorean_triple(2, 1)
@test (a, b, c) == (3, 4, 5)  # Classic 3-4-5 triangle
@test p == 12  # Perimeter

a, b, c, p = generate_pythagorean_triple(3, 2)
@test (a, b, c) == (5, 12, 13)  # 5-12-13 triangle
@test p == 30  # Perimeter

@test solve() == 161667
