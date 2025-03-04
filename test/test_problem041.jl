using ProjectEulerSolutions.Problem041: is_prime, digits_to_number, find_largest_pandigital_prime, solve

@test is_prime(2143)

@test digits_to_number([5]) == 5
@test digits_to_number([1, 2, 3]) == 123
@test digits_to_number([2, 1, 4, 3]) == 2143
@test digits_to_number([7, 6, 5, 4, 3, 2, 1]) == 7654321

@test solve() == 7652413
