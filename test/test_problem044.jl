using ProjectEulerSolutions.Problem044: pentagonal, is_pentagonal, find_minimum_d, solve

@test pentagonal(1) == 1
@test pentagonal(2) == 5
@test pentagonal(3) == 12
@test pentagonal(4) == 22
@test pentagonal(5) == 35
@test pentagonal(6) == 51
@test pentagonal(7) == 70
@test pentagonal(8) == 92
@test pentagonal(9) == 117
@test pentagonal(10) == 145

@test is_pentagonal(1) == true
@test is_pentagonal(5) == true
@test is_pentagonal(12) == true
@test is_pentagonal(22) == true
@test is_pentagonal(35) == true

@test is_pentagonal(2) == false
@test is_pentagonal(3) == false
@test is_pentagonal(4) == false
@test is_pentagonal(6) == false

@test pentagonal(4) + pentagonal(7) == pentagonal(8)
@test is_pentagonal(pentagonal(7) - pentagonal(4)) == false

@test solve() == 5482660
