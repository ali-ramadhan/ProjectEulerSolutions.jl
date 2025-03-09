using ProjectEulerSolutions.Problem060: is_prime, concat_numbers, find_prime_pair_set, solve

@test concat_numbers(3, 7) == 37
@test concat_numbers(7, 3) == 73
@test concat_numbers(109, 673) == 109673
@test concat_numbers(673, 109) == 673109

# Test the 4-prime example from the problem statement
set4, sum4 = find_prime_pair_set(4, 1000)
@test sum4 == 792
@test sort(set4) == [3, 7, 109, 673]

@test solve() == 26033
