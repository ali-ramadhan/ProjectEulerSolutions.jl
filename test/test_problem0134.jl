using Test
using ProjectEulerSolutions.Problem0134: find_smallest_s, count_digits, solve

# Test digit counting helper function
@test count_digits(19) == 2
@test count_digits(5) == 1
@test count_digits(123) == 3
@test count_digits(1) == 1

# Test the main example from the problem description
@test find_smallest_s(19, 23) == 1219

# Test other small prime pairs
@test find_smallest_s(5, 7) == 35  # 35 ends with 5 and is divisible by 7
@test find_smallest_s(7, 11) == 77  # 77 ends with 7 and is divisible by 11
@test find_smallest_s(11, 13) == 611  # 611 ends with 11 and is divisible by 13

# Test with larger primes
@test find_smallest_s(97, 101) == 9797  # Should end with 97 and be divisible by 101

# Verify the solution properties for the main example
let s = find_smallest_s(19, 23)
    @test s % 23 == 0  # divisible by p2
    @test s % 100 == 19  # ends with p1's digits
end

# Verify properties for another test case
let s = find_smallest_s(11, 13)
    @test s % 13 == 0  # divisible by p2
    @test s % 100 == 11  # ends with p1's digits
end

# Test that our solution is indeed the smallest such number
let s = find_smallest_s(19, 23)
    # Check that no smaller positive number satisfies both conditions
    for test_n in 119:100:(s-1)  # numbers ending in 19
        @test test_n % 23 != 0 || test_n >= s
    end
end

# Correct answer
@test solve() == 18613426663617118
