using ProjectEulerSolutions.Problem065: e_continued_fraction_terms, calculate_convergent, sum_of_digits_in_numerator, solve

# Test the e continued fraction terms
@test e_continued_fraction_terms(1) == [BigInt(2)]
@test e_continued_fraction_terms(2) == [BigInt(2), BigInt(1)]
@test e_continued_fraction_terms(4) == [BigInt(2), BigInt(1), BigInt(2), BigInt(1)]
@test e_continued_fraction_terms(10) == [BigInt(2), BigInt(1), BigInt(2), BigInt(1),  BigInt(1),
                                         BigInt(4), BigInt(1), BigInt(1), BigInt(6), BigInt(1)]

# Test the convergent calculations for first few terms
@test calculate_convergent([BigInt(2)]) == (BigInt(2), BigInt(1))
@test calculate_convergent([BigInt(2), BigInt(1)]) == (BigInt(3), BigInt(1))
@test calculate_convergent([BigInt(2), BigInt(1), BigInt(2)]) == (BigInt(8), BigInt(3))
@test calculate_convergent([BigInt(2), BigInt(1), BigInt(2), BigInt(1)]) == (BigInt(11), BigInt(4))

# Test the convergent calculations for all 10 expected values
expected_convergents = [
    (BigInt(2), BigInt(1)),     # 1st convergent = 2/1
    (BigInt(3), BigInt(1)),     # 2nd convergent = 3/1
    (BigInt(8), BigInt(3)),     # 3rd convergent = 8/3
    (BigInt(11), BigInt(4)),    # 4th convergent = 11/4
    (BigInt(19), BigInt(7)),    # 5th convergent = 19/7
    (BigInt(87), BigInt(32)),   # 6th convergent = 87/32
    (BigInt(106), BigInt(39)),  # 7th convergent = 106/39
    (BigInt(193), BigInt(71)),  # 8th convergent = 193/71
    (BigInt(1264), BigInt(465)), # 9th convergent = 1264/465
    (BigInt(1457), BigInt(536))  # 10th convergent = 1457/536
]

for i in 1:10
    terms = e_continued_fraction_terms(i)
    @test calculate_convergent(terms) == expected_convergents[i]
end

# Test the sum of digits function as given in the problem statement
@test sum_of_digits_in_numerator(10) == 17

# Test the final solution
@test solve() == 272
