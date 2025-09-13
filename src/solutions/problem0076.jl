"""
Project Euler Problem 76: Counting Summations

It is possible to write five as a sum in exactly six different ways:
4 + 1
3 + 2
3 + 1 + 1
2 + 2 + 1
2 + 1 + 1 + 1
1 + 1 + 1 + 1 + 1

How many different ways can one hundred be written as a sum of at least two positive
integers?

## Solution approach

This is the integer partition problem. We need p(n) - 1, where p(n) is the partition
function (total ways to partition n) and we subtract 1 to exclude the trivial partition [n].

We use dynamic programming where dp[i] represents the number of ways to partition i. For
each number j from 1 to n, we update all values dp[i] where i ≥ j by adding dp[i-j].

## Complexity analysis

Time complexity: O(n²)
- Two nested loops: outer from 1 to n, inner from j to n

Space complexity: O(n)
- Array to store partition counts for each value up to n
"""
module Problem0076

"""
    count_partition_ways(n)

Count the number of different ways n can be written as a sum of at least two positive integers.
Returns p(n) - 1 where p(n) is the partition function.
"""
function count_partition_ways(n)
    dp = zeros(Int, n+1)
    dp[1] = 1  # There's 1 way to partition 0 (by not selecting any number)

    for j in 1:n
        for i in j:n
            dp[i + 1] += dp[i + 1 - j]
        end
    end

    return dp[n + 1] - 1  # Subtracting 1 to exclude the partition [n]
end

function solve()
    result = count_partition_ways(100)
    @info "Number 100 can be partitioned in $result ways, (excluding trivial partition)"
    return result
end

end # module
