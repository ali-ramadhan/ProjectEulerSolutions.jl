using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0004

for largest_palindrome in (largest_palindrome_product, largest_palindrome_product_naive,
                           largest_palindrome_product_fermat)
    # Test example from problem description
    @test largest_palindrome(2).palindrome == 9009
    @test largest_palindrome(2).factors == (91, 99)

    # Test type genericity
    @test largest_palindrome(2, Int32).palindrome == Int32(9009)
    @test largest_palindrome(3, Int128).palindrome == Int128(906609)

    # Correct answer
    @test_answer solve(largest_palindrome) "0004"
end

# 6-digit factors take hours with the naive search, so only the fast one is tested there
@test largest_palindrome_product(6).palindrome == 999000000999

# The palindrome-first search finds the same palindrome and factors as the loop for 2- to 8-digit factors
for n in 2:8
    @test largest_palindrome_product_fermat(n) == largest_palindrome_product(n)
end

# Beyond that the loop is slow, so check against known answers. For 9-digit factors u*v carries into the top half.
@test largest_palindrome_product_fermat(9) == (palindrome=999900665566009999, factors=(999920317, 999980347))
@test largest_palindrome_product_fermat(10).palindrome == 99999834000043899999
@test largest_palindrome_product_fermat(12).palindrome == 999999000000000000999999

# The palindrome-first search only looks at 2n-digit palindromes, so it needs n ≥ 2
@test_throws ArgumentError largest_palindrome_product_fermat(1)

# Test max_product constraint (HackerRank version)
@test largest_palindrome_product(3, max_product=900000).palindrome == 888888
@test largest_palindrome_product(3, max_product=900000).factors == (924, 962)

# Both searches over pairs find the same palindrome. The factors can differ when a palindrome has several factor
# pairs since the two searches visit pairs in different orders.
for n in 1:3
    @test largest_palindrome_product(n).palindrome == largest_palindrome_product_naive(n).palindrome
end

# Correct answer
@test_answer solve() "0004"
