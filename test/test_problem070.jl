using ProjectEulerSolutions.Problem070: are_permutations, find_totient_permutation, solve

# Test the permutation checking function
@test are_permutations(123, 321) == true
@test are_permutations(123, 213) == true
@test are_permutations(123, 124) == false
@test are_permutations(8319823, 8313928) == true

# Test the example from the problem
@test are_permutations(87109, 79180) == true

# Test the solution
@test solve() == 8319823
