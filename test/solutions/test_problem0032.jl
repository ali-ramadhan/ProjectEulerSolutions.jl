using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0032: get_valid_digit_cases, is_pandigital_product, digit_bounds, find_pandigital_products, solve

# digit_bounds
@test digit_bounds(1) == (1, 9)
@test digit_bounds(2) == (10, 99)
@test digit_bounds(3) == (100, 999)
@test digit_bounds(4) == (1000, 9999)

# get_valid_digit_cases: for n=9, valid cases are (1,4,4) and (2,3,4)
cases_9 = get_valid_digit_cases(9)
@test (1, 4, 4) in cases_9
@test (2, 3, 4) in cases_9
@test length(cases_9) == 2

# get_valid_digit_cases: for n=4, the only valid case is (1,1,2)
cases_4 = get_valid_digit_cases(4)
@test (1, 1, 2) in cases_4
@test length(cases_4) == 1

const MASK_9 = (1 << 9) - 1
const MASK_4 = (1 << 4) - 1

# Known pandigital products from the problem: 39 × 186 = 7254
@test is_pandigital_product(39, 186, 7254, MASK_9) == true

# All seven unique pandigital products
@test is_pandigital_product(4, 1738, 6952, MASK_9) == true
@test is_pandigital_product(4, 1963, 7852, MASK_9) == true
@test is_pandigital_product(12, 483, 5796, MASK_9) == true
@test is_pandigital_product(18, 297, 5346, MASK_9) == true
@test is_pandigital_product(28, 157, 4396, MASK_9) == true
@test is_pandigital_product(48, 159, 7632, MASK_9) == true

# Contains a zero digit → false
@test is_pandigital_product(12, 345, 4140, MASK_9) == false

# Too few total digits → false
@test is_pandigital_product(2, 345, 690, MASK_9) == false

# Repeated digits → false
@test is_pandigital_product(11, 111, 1221, MASK_9) == false

# All digits present but wrong product (not a*b=c) still pandigital check-wise
# is_pandigital_product only checks digits, not the multiplication
@test is_pandigital_product(123, 45, 6789, MASK_9) == true   # digits are 1-9 pandigital
@test is_pandigital_product(123, 45, 6788, MASK_9) == false  # repeated digit 8

# Smaller pandigital: 1-4 pandigital (mask = 0xf)
@test is_pandigital_product(1, 2, 3, MASK_4) == false  # only covers digits 1,2,3
@test is_pandigital_product(3, 4, 12, MASK_4) == true   # digits: 3,4,1,2

# find_pandigital_products for small n values
@test find_pandigital_products(4) == 12  # 3 × 4 = 12 is the only 1-4 pandigital product

# Correct answer
@test_answer solve() "0032"
