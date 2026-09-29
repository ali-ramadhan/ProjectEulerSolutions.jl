using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0004

for largest_palindrome in (largest_palindrome_product, largest_palindrome_product_naive,
                           largest_palindrome_product_fermat)
    # Test example from problem description
    @test largest_palindrome(10, 99).palindrome == 9009
    @test largest_palindrome(10, 99).factors == (91, 99)

    # Test type genericity
    @test largest_palindrome(Int32(10), Int32(99)).palindrome == Int32(9009)
    @test largest_palindrome(Int64(100), Int64(999)).palindrome == Int64(906609)

    # Correct answer
    @test_answer solve(largest_palindrome) "0004"
end

# 6-digit factors take hours with the naive search, so only the fast one is tested there
@test largest_palindrome_product(Int128(100000), Int128(999999)).palindrome == Int128(999000000999)

# The palindrome-first search finds the same palindrome and factors as the loop for 2- to 8-digit factors
for n in 2:8
    lower, upper = 10^(n - 1), 10^n - 1
    @test largest_palindrome_product_fermat(lower, upper) == largest_palindrome_product(lower, upper)
end

# Beyond that the loop is slow, so check against known answers. For 9-digit factors u*v carries into the top half.
@test largest_palindrome_product_fermat(10^8, 10^9 - 1) ==
      (palindrome=999900665566009999, factors=(999920317, 999980347))
@test largest_palindrome_product_fermat(10^9, 10^10 - 1).palindrome == 99999834000043899999
@test largest_palindrome_product_fermat(10^11, 10^12 - 1).palindrome == 999999000000000000999999

# The palindrome-first search only handles the full range of n-digit factors with n ≥ 2
@test_throws ArgumentError largest_palindrome_product_fermat(1, 9)
@test_throws ArgumentError largest_palindrome_product_fermat(123, 456)

# Test max_product constraint (HackerRank version)
@test largest_palindrome_product(100, 999, max_product=900000).palindrome == 888888
@test largest_palindrome_product(100, 999, max_product=900000).factors == (924, 962)

# Both approaches find the same palindrome over assorted ranges. The factors can differ when a
# palindrome has several factor pairs since the two searches visit pairs in different orders.
for (lower, upper) in [(1, 9), (1, 99), (10, 99), (50, 150), (100, 999), (123, 456), (1, 999)]
    @test largest_palindrome_product(lower, upper).palindrome ==
          largest_palindrome_product_naive(lower, upper).palindrome
end

# Correct answer
@test_answer solve() "0004"
