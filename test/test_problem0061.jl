using Test
using ProjectEulerSolutions.Problem0061: generate_figurate_numbers, find_cyclical_set, solve

@test generate_figurate_numbers(3, 1, 20) == [1, 3, 6, 10, 15]
@test generate_figurate_numbers(4, 1, 30) == [1, 4, 9, 16, 25]
@test generate_figurate_numbers(5, 1, 40) == [1, 5, 12, 22, 35]
@test generate_figurate_numbers(6, 1, 50) == [1, 6, 15, 28, 45]
@test generate_figurate_numbers(7, 1, 60) == [1, 7, 18, 34, 55]
@test generate_figurate_numbers(8, 1, 70) == [1, 8, 21, 40, 65]

@test 8128 in generate_figurate_numbers(3, 1000, 10000)
@test 2882 in generate_figurate_numbers(5, 1000, 10000)
@test 8281 in generate_figurate_numbers(4, 1000, 10000)

@test solve() == 28684
