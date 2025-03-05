using ProjectEulerSolutions.Problem045: is_pentagonal, hexagonal, find_next_tri_pent_hex, solve

@test is_pentagonal(1)
@test is_pentagonal(5)
@test is_pentagonal(12)
@test is_pentagonal(22)
@test is_pentagonal(35)
@test !is_pentagonal(2)
@test !is_pentagonal(7)

@test hexagonal(1) == 1
@test hexagonal(2) == 6
@test hexagonal(3) == 15
@test hexagonal(4) == 28
@test hexagonal(143) == 40755

@test is_pentagonal(40755)

@test solve() == 1533776805
