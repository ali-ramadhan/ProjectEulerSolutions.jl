using ProjectEulerSolutions.Problem008: product_of_digits, largest_product_in_series, solve

@test product_of_digits("9989") == 5832

@test largest_product_in_series(4)[1] == 5832

@test solve() == 23514624000
