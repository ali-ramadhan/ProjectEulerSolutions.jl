using Test
using ProjectEulerSolutions.Problem0130: find_composite_repunit_numbers, solve
using ProjectEulerSolutions.Problem0129: compute_A
using ProjectEulerSolutions.Utils.Primes: is_prime

# Test that the given examples are correctly identified as composite repunit numbers
test_cases = [91, 259, 451, 481, 703]

for n in test_cases
    # Verify (n - 1) is divisible by A(n)
    @test (n - 1) % compute_A(n) == 0
end

# Test that the first few results match the given examples
@test find_composite_repunit_numbers(5) == test_cases

# Correct answer
@test solve() == 149253
