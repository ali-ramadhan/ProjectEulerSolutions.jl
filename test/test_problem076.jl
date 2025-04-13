using ProjectEulerSolutions.Problem076: count_partition_ways, solve

@test count_partition_ways(1) == 0  # No way to represent 1 as a sum of at least 2 positive integers
@test count_partition_ways(2) == 1  # 2 = 1+1
@test count_partition_ways(3) == 2  # 3 = 1+2 or 1+1+1
@test count_partition_ways(4) == 4  # 4 = 1+3, 2+2, 1+1+2, 1+1+1+1
@test count_partition_ways(5) == 6  # Given example in the problem statement

@test solve() == 190569291
