using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0004

for largest_palindrome in (largest_palindrome_product, largest_palindrome_product_naive)
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
