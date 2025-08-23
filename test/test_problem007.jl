using ProjectEulerSolutions.Problem007: find_nth_prime, solve

@test find_nth_prime(1) == 2
@test find_nth_prime(2) == 3
@test find_nth_prime(3) == 5
@test find_nth_prime(4) == 7
@test find_nth_prime(5) == 11
@test find_nth_prime(6) == 13

@test solve() == 104743
