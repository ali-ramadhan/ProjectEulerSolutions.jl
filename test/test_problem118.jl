using Test
using ProjectEulerSolutions.Problem118: solve, form_number, could_be_prime, find_prime_partitions!

# Test helper functions

# Test form_number function
@test form_number([1, 2, 3, 4], 1, 2) == 12
@test form_number([1, 2, 3, 4], 2, 4) == 234
@test form_number([5], 1, 1) == 5

# Test could_be_prime function
@test could_be_prime(2) == true
@test could_be_prime(5) == true
@test could_be_prime(17) == true
@test could_be_prime(13) == true
@test could_be_prime(4) == false  # ends in 4
@test could_be_prime(6) == false  # ends in 6
@test could_be_prime(10) == false # ends in 0
@test could_be_prime(15) == false # ends in 5, but 15 is not prime anyway

# Test that the example set uses digits 1-9 exactly once
example_digits = [2, 5, 4, 7, 8, 9, 6, 3, 1]
@test sort(example_digits) == collect(1:9)

# Test partition finding with a smaller example
# Let's test with digits [2, 3] which can form {2, 3} or {23}
# Both 2, 3, and 23 are prime
prime_sets_23 = Set{Vector{Int}}()
digits_23 = [2, 3]
find_prime_partitions!(digits_23, 1, Int[], prime_sets_23)

# Should find [2, 3] and [23]
@test length(prime_sets_23) == 2
@test [2, 3] in prime_sets_23
@test [23] in prime_sets_23

# Correct answer
@test solve() == 44680
