using ProjectEulerSolutions.Problem043: find_special_pandigitals, solve

# Example from problem description
special_pandigitals = find_special_pandigitals()
@test 1406357289 in special_pandigitals

# Correct answer
@test solve() == 16695334890
