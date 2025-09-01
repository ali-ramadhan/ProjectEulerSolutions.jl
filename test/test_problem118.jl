using Test
using ProjectEulerSolutions.Problem118:
    count_prime_permutations, digits_to_number, unique_permutations,
    generate_set_partitions, solve

# Helper function to create cache for testing
function test_count_prime_permutations(digits)
    cache = Dict{Vector{Int}, Int}()
    return count_prime_permutations(digits, cache)
end

# Test helper functions

# Test digits_to_number function
@test digits_to_number([1, 2, 3]) == 123
@test digits_to_number([5]) == 5
@test digits_to_number([4, 7]) == 47

# Test unique_permutations function
perms_12 = unique_permutations([1, 2])
@test length(perms_12) == 2
@test [1, 2] in perms_12
@test [2, 1] in perms_12

# Test with single element
perms_5 = unique_permutations([5])
@test length(perms_5) == 1
@test [5] in perms_5

# Test count_prime_permutations with known cases
@test test_count_prime_permutations([2]) == 1      # 2 is prime
@test test_count_prime_permutations([3]) == 1      # 3 is prime
@test test_count_prime_permutations([2, 3]) == 1   # only 23 is prime (32 is even)
@test test_count_prime_permutations([4]) == 0      # 4 is not prime
@test test_count_prime_permutations([6]) == 0      # 6 is not prime (divisible by 3)

# Test divisibility by 3 pruning
@test test_count_prime_permutations([1, 2, 3]) == 0  # sum = 6, divisible by 3
@test test_count_prime_permutations([4, 5, 6]) == 0  # sum = 15, divisible by 3
@test test_count_prime_permutations([1, 5, 9]) == 0  # sum = 15, divisible by 3

# Test that the example set uses digits 1-9 exactly once
example_digits = [2, 5, 4, 7, 8, 9, 6, 3, 1]  # from {2, 5, 47, 89, 631}
@test sort(example_digits) == collect(1:9)

# Test set partitioning with small example
partitions_12 = generate_set_partitions([1, 2])
@test length(partitions_12) == 2  # Bell number B(2) = 2
# Should have [[1,2]] and [[1],[2]]
partition_sizes = [length(p) for p in partitions_12]
@test 1 in partition_sizes  # one partition with single subset
@test 2 in partition_sizes  # one partition with two subsets

# Verify Bell numbers for small cases
@test length(generate_set_partitions([])) == 1        # B(0) = 1
@test length(generate_set_partitions([1])) == 1       # B(1) = 1
@test length(generate_set_partitions([1,2])) == 2     # B(2) = 2
@test length(generate_set_partitions([1,2,3])) == 5   # B(3) = 5

# Test mathematical insight: no 9-digit pandigital primes
# (since 1+2+...+9 = 45 is divisible by 3)
@test test_count_prime_permutations(collect(1:9)) == 0

# Correct answer
@test solve() == 44680
