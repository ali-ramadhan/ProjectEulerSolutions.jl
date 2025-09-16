"""
Project Euler Problem 135: Same differences

Given the positive integers, x, y, and z, are consecutive terms of an arithmetic
progression, the least value of the positive integer, n, for which the equation, x² - y² -
z² = n, has exactly two solutions is n = 27:

34² - 27² - 20² = 12² - 9² - 6² = 27.

It turns out that n = 1155 is the least value which has exactly ten solutions.

How many values of n less than one million have exactly ten distinct solutions?

## Solution approach

Since x, y, z are consecutive terms of an arithmetic progression, we can write:
- y = x - d
- z = x - 2d

where d is the common difference.

Substituting into x² - y² - z² = n: x² - (x-d)² - (x-2d)² = n x² - (x² - 2xd + d²) - (x² -
4xd + 4d²) = n -x² + 6xd - 5d² = n

Rearranging: n = x(6d - x) - 5d² = (3d - x)(x + d)

Let u = 3d - x and v = x + d. Then:
- n = uv
- x = (3v - u)/4
- d = (u + v)/4

For x, y, z to be positive integers:
1. Both x and d must be integers: u + v ≡ 0 (mod 4) and 3v - u ≡ 0 (mod 4)
2. This simplifies to: u ≡ v (mod 4)
3. x > 0: 3v > u
4. y > 0: x > d, which gives 3v - u > u + v, so v > u
5. z > 0: x > 2d, which gives 3v - u > 2(u + v), so v > 3u

Therefore, for each n, we need to count divisor pairs (u, v) where:
- n = uv
- u ≡ v (mod 4)
- v > 3u > 0

## Complexity analysis

Time complexity: O(n√n)
- For each n up to limit, we find all divisors which takes O(√n) time
- Total iterations: ∑(√i) for i=1 to n ≈ O(n^(3/2))

Space complexity: O(1)
- Only storing counters and temporary variables

## Key insights

The key insight is transforming the Diophantine equation into a factorization problem. The
constraints u ≡ v (mod 4) and v > 3u significantly reduce the search space.
"""
module Problem0135

export count_solutions

"""
    count_solutions(n)

Count the number of distinct solutions to x² - y² - z² = n where x, y, z
are consecutive terms of an arithmetic progression.

From the equation x² - (x-d)² - (x-2d)² = n, we derive:
n = (2d - k)(2d + k) = uv where k = √(4d² - n)

For each divisor pair (u, v) of n where u ≤ v:
- d = (u + v)/4 must be a positive integer
- k = (v - u)/2 must be a positive integer
- Both solutions x₁ = (u + 5v)/4 and x₂ = (5u + v)/4 must be positive integers
- y = x - d and z = x - 2d must be positive
"""
function count_solutions(n)
    count = 0

    # Find all divisor pairs (u, v) where n = u * v and u ≤ v
    for u in 1:isqrt(n)
        if n % u == 0
            v = n ÷ u

            # Check if d = (u + v)/4 is a positive integer
            if (u + v) % 4 != 0
                continue
            end

            d = (u + v) ÷ 4
            if d ≤ 0
                continue
            end

            # Check if k = (v - u)/2 is a non-negative integer
            if (v - u) % 2 != 0
                continue
            end

            k = (v - u) ÷ 2
            if k < 0
                continue
            end

            # Calculate the two potential x values
            x1_num = u + 5 * v
            x2_num = 5 * u + v

            # Check if x values are positive integers and count distinct solutions
            solutions_found = 0

            if x1_num % 4 == 0
                x1 = x1_num ÷ 4
                if x1 > 2 * d  # Ensure y = x1 - d > 0 and z = x1 - 2d > 0
                    solutions_found += 1
                end
            end

            if x2_num % 4 == 0
                x2 = x2_num ÷ 4
                if x2 > 2 * d && x1_num != x2_num  # Ensure distinct solutions
                    solutions_found += 1
                end
            end

            count += solutions_found
        end
    end

    return count
end

"""
    count_values_with_k_solutions(limit, k)

Count how many values of n < limit have exactly k distinct solutions.
This is a generic helper function that can be used by both Problem 135 and 136.
"""
function count_values_with_k_solutions(limit, k)
    count = 0

    for n in 1:(limit - 1)
        if count_solutions(n) == k
            count += 1
        end

        # Progress logging for large computations
        if n % 100000 == 0
            @info "Processed n up to $n, found $count values with $k solutions"
        end
    end

    @info "Found $count values with exactly $k solutions"
    return count
end

"""
    count_values_with_ten_solutions(limit)

Count how many values of n < limit have exactly ten distinct solutions.
"""
function count_values_with_ten_solutions(limit)
    return count_values_with_k_solutions(limit, 10)
end

function solve()
    return count_values_with_ten_solutions(1000000)
end

end # module
