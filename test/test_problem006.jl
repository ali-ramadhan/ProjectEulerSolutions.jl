using ProjectEulerSolutions.Problem006: sum_of_squares, square_of_sum, sum_square_difference, solve

@test sum_of_squares(10) == 385
@test square_of_sum(10) == 3025
@test sum_square_difference(10) == 2640

@test solve() == 25164150
