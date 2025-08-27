using ProjectEulerSolutions.Problem049: get_sorted_digits, solve

@test get_sorted_digits(1487) == get_sorted_digits(4817)
@test get_sorted_digits(4817) == get_sorted_digits(8147)
@test get_sorted_digits(1234) != get_sorted_digits(2345)

known_sequence = (1487, 4817, 8147)
@test get_sorted_digits(known_sequence[1]) == get_sorted_digits(known_sequence[2])
@test get_sorted_digits(known_sequence[2]) == get_sorted_digits(known_sequence[3])
@test known_sequence[2] - known_sequence[1] == known_sequence[3] - known_sequence[2]

@test solve() == 296962999629
