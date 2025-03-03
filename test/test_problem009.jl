using ProjectEulerSolutions.Problem009: find_pythagorean_triplet, solve

a, b, c = find_pythagorean_triplet()
@test a + b + c == 1000
@test a^2 + b^2 == c^2
@test a < b < c

@test solve() == 31875000
