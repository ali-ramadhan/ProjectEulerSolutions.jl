using ProjectEulerSolutions.Problem072: count_reduced_proper_fractions, solve

# Test with example from problem statement
@test count_reduced_proper_fractions(8) == 21

# Test the full solution
@test solve() == 303963552391
