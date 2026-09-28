using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Utils.Primes: is_prime, sieve_of_eratosthenes
using ProjectEulerSolutions.Problem0037: find_right_truncatable_primes, find_truncatable_primes, solve

right_truncatable_primes = find_right_truncatable_primes()
truncatable_primes = find_truncatable_primes()

# 3797 from the problem statement is truncatable, but its right truncation 379 is not as its last digit 9 is not prime
@test 3797 in truncatable_primes
@test 379 in right_truncatable_primes
@test 379 ∉ truncatable_primes

# There are 83 right-truncatable primes and the largest is 73939133 (https://oeis.org/A024770)
@test length(right_truncatable_primes) == 83
@test last(right_truncatable_primes) == 73939133

# The eleven truncatable primes, which with 2, 3, 5 and 7 are the two-sided primes (https://oeis.org/A020994)
@test truncatable_primes == [23, 37, 53, 73, 313, 317, 373, 797, 3137, 3797, 739397]

# The number of right-truncatable primes (https://oeis.org/A076586) and of two-sided primes, which include the one-digit
# primes (https://oeis.org/A323390), in bases 2 to 20. The trees in base 14 and in bases 17 and up outgrow Int.
right_truncatable_counts = [0, 4, 7, 14, 36, 19, 68, 68, 83, 89, 179, 176, 439, 373, 414, 473, 839, 1010, 1577]
two_sided_counts = [0, 2, 3, 5, 9, 7, 22, 8, 15, 6, 35, 11, 37, 17, 22, 12, 69, 12, 68]
for b in 2:20
    B = (b == 14 || b >= 17) ? big(b) : b
    @test length(find_right_truncatable_primes(base=B)) == right_truncatable_counts[b-1]

    truncatable = find_truncatable_primes(base=B)
    @test length(truncatable) + count(is_prime, 2:b-1) == two_sided_counts[b-1]

    # In an odd base a number has the same parity as its digit sum, which leaves room for at most 3 digits
    if isodd(b)
        @test all(p -> ndigits(p; base=b) <= 3, truncatable)
    end
end

# The arithmetic is done in the type of the base, so a BigInt base gives BigInts, and base 14's tree outgrowing Int
# throws instead of silently wrapping around
@test find_truncatable_primes(base=big(10)) == find_truncatable_primes()
@test eltype(find_truncatable_primes(base=big(10))) == BigInt
@test_throws OverflowError find_truncatable_primes(base=14)

# Correct answer
@test_answer solve() "0037"
