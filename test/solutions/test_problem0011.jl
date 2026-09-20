using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0011

@test size(GRID) == (20, 20)

@test GRID[7, 9] == 26
@test GRID[8, 10] == 63
@test GRID[9, 11] == 78
@test GRID[10, 12] == 14

diagonal_product = GRID[7, 9] * GRID[8, 10] * GRID[9, 11] * GRID[10, 12]
@test diagonal_product == 26 * 63 * 78 * 14
@test diagonal_product == 1788696

@test find_greatest_product(GRID) >= diagonal_product

@test_answer solve() "0011"
