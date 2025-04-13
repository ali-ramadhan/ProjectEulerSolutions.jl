"""
Project Euler Problem 76: Counting Summations

It is possible to write five as a sum in exactly six different ways:
4 + 1
3 + 2
3 + 1 + 1
2 + 2 + 1
2 + 1 + 1 + 1
1 + 1 + 1 + 1 + 1

How many different ways can one hundred be written as a sum of at least two positive integers?
"""
module Problem076

"""
    count_partition_ways(n)

Count the number of different ways n can be written as a sum of at least two positive integers.
This uses dynamic programming to compute the number of partitions of n excluding the partition [n] itself.

The number of partitions of n is known as p(n) in number theory. This function computes p(n) - 1, 
since we exclude the partition [n].

Mathematically, this implements a dynamic programming algorithm based on the recurrence relation:
p(n) = sum of p(n-k) for k from 1 to n, where p(0) = 1.

This is because each partition of n either includes at least one k or doesn't include any k.
The dp array stores the number of ways to partition each value from 0 to n.

For example, p(5) = 7 (the partitions are [5], [4,1], [3,2], [3,1,1], [2,2,1], [2,1,1,1], [1,1,1,1,1]), 
so count_partition_ways(5) returns 6.

Time complexity: O(n²)
Space complexity: O(n)
"""
function count_partition_ways(n)
    dp = zeros(Int, n+1)
    dp[1] = 1  # There's 1 way to partition 0 (by not selecting any number)
    
    for j in 1:n
        for i in j:n
            dp[i+1] += dp[i+1-j]
        end
    end
    
    return dp[n+1] - 1  # Subtracting 1 to exclude the partition [n]
end

function solve()
    return count_partition_ways(100)
end

end # module
