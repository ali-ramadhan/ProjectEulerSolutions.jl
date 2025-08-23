using ProjectEulerSolutions.Problem006: solve
using ProjectEulerSolutions.Utils.Sequences: sum_of_squares, square_of_sum

@test sum_of_squares(10) == 385
@test square_of_sum(10) == 3025
@test square_of_sum(10) - sum_of_squares(10) == 2640

@test solve() == 25164150
