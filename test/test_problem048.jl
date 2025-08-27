using ProjectEulerSolutions.Problem048: last_ten_digits_of_self_powers, solve

@test last_ten_digits_of_self_powers(10, 10^20) == 10405071317

@test solve() == 9110846700
