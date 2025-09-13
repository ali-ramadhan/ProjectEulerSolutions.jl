"""
Project Euler Problem 73: Counting Fractions in a Range

Consider the fraction, n/d, where n and d are positive integers. If n < d and HCF(n, d) = 1,
it is called a reduced proper fraction.

If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:
1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5,
5/6, 6/7, 7/8

It can be seen that there are 3 fractions between 1/3 and 1/2.

How many fractions lie between 1/3 and 1/2 in the sorted set of reduced proper fractions
for d ≤ 12,000?

## Solution approach

For each denominator d, we find the range of numerators n such that 1/3 < n/d < 1/2. This
gives us: d/3 < n < d/2. We iterate through valid numerators in this range and check if
gcd(n,d) = 1.

We start from d=5 since smaller denominators cannot have fractions in the range (1/3, 1/2).

## Complexity analysis

Time complexity: O(d² * log(max(n,d)))
- For each denominator d, we check at most d/6 numerators
- Each gcd computation takes O(log(max(n,d)))

Space complexity: O(1)
- Only stores a few variables for counting
"""
module Problem0073

"""
    count_fractions_in_range(limit, lower_bound, upper_bound)

Count the number of reduced proper fractions n/d in the specified range.
"""
function count_fractions_in_range(limit, lower_bound, upper_bound)
    count = 0
    for d in 5:limit
        # Find the range of numerators n such that lower_bound < n/d < upper_bound
        lower_n = ceil(Int, d * lower_bound)
        if lower_n == d * lower_bound
            lower_n += 1
        end

        upper_n = floor(Int, d * upper_bound)
        if upper_n == d * upper_bound
            upper_n -= 1
        end

        if lower_n <= upper_n  # Skip if range is empty
            for n in lower_n:upper_n
                if gcd(n, d) == 1
                    count += 1
                end
            end
        end
    end
    return count
end

function solve()
    result = count_fractions_in_range(12000, 1/3, 1/2)
    @info "Found $result reduced proper fractions between 1/3 and 1/2 for d ≤ 12,000"
    return result
end

end # module
