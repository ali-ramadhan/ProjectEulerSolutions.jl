using ProjectEulerSolutions.Problem007: is_prime, find_nth_prime, solve

@test !is_prime(1)
@test is_prime(2)
@test is_prime(3)
@test !is_prime(4)
@test is_prime(5)
@test !is_prime(6)
@test is_prime(7)
@test !is_prime(9)
@test is_prime(11)
@test is_prime(13)

@test find_nth_prime(1) == 2
@test find_nth_prime(2) == 3
@test find_nth_prime(3) == 5
@test find_nth_prime(4) == 7
@test find_nth_prime(5) == 11
@test find_nth_prime(6) == 13

@test solve() == 104743
