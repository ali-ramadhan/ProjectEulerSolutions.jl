using ProjectEulerSolutions.Problem032: is_pandigital_product, find_pandigital_products, solve

@test is_pandigital_product(39, 186, 7254) == true

@test is_pandigital_product(12, 345, 4140) == false
@test is_pandigital_product(2, 345, 690) == false
@test is_pandigital_product(11, 111, 1221) == false

@test solve() == 45228
