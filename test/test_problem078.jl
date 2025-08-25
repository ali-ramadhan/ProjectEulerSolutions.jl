using ProjectEulerSolutions.Problem078:
    partition_number, find_divisible_partition, calculate_partition_numbers, solve

# Test the core partition calculation function
partition_sequence = calculate_partition_numbers(10)
@test length(partition_sequence) == 11  # p(0) through p(10)
@test partition_sequence[1] == 1  # p(0) = 1
@test partition_sequence[6] == 7  # p(5) = 7

# Test finding a value divisible by a number
@test find_divisible_partition(5) <= 30  # p(30) is divisible by 5

# Test the calculation function with the divisibility criterion
_, divisible_index = calculate_partition_numbers(; target_mod = 5, divisible_by = 5)
@test divisible_index <= 30  # p(30) is divisible by 5

# Test the main solution function
@test solve() == 55374
