using ProjectEulerSolutions.Problem0100: find_blue_discs, solve
using Test

# Test finding blue discs for the known examples
@test find_blue_discs(21) == 15   # For B=15, R=6 (total=21), should return 15
@test find_blue_discs(120) == 85  # For B=85, R=35 (total=120), should return 85
@test find_blue_discs(121) == 493  # Next solution after (85,120) is (493,697)

# Correct answer
@test solve() == 756872327473
