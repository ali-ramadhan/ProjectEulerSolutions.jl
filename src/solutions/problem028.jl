"""
Project Euler Problem 28: Number Spiral Diagonals

Starting with the number 1 and moving to the right in a clockwise direction a 5 × 5 spiral
is formed as follows:

21 22 23 24 25
20  7  8  9 10
19  6  1  2 11
18  5  4  3 12
17 16 15 14 13

It can be verified that the sum of the numbers on the diagonals is 101.

What is the sum of the numbers on the diagonals in a 1001 × 1001 spiral formed in the same
way?

## Solution approach

We derive a mathematical formula for the diagonal sum without constructing the spiral:
1. The center is always 1
2. Each ring k adds 4 corner values following the pattern:
   - Bottom-right: (2k+1)²
   - Bottom-left: (2k+1)² - 2k
   - Top-left: (2k+1)² - 4k
   - Top-right: (2k+1)² - 6k
3. The sum for ring k is 4(2k+1)² - 12k = 16k² + 4k + 4
4. Total sum = 1 + Σ(16k² + 4k + 4) for k = 1 to (n-1)/2

Using summation formulas, this reduces to a closed-form expression.

## Complexity analysis

Time complexity: O(1)
- We compute the result using a closed-form mathematical formula
- All operations are constant time arithmetic

Space complexity: O(1)
- We only store a few intermediate variables for the calculation
"""
module Problem028

"""
    diagonal_sum(n)

Calculate the sum of the numbers on the diagonals in an n × n spiral,
where n is odd (representing the side length of the spiral).

Uses the closed-form formula: 1 + 16k²/3 + 26k/3 + 4k + 1
where k = (n-1)/2 is the number of rings.
"""
function diagonal_sum(n)
    if n % 2 == 0
        error("Spiral size must be odd")
    end

    rings = (n - 1) ÷ 2

    sum_k = rings * (rings + 1) ÷ 2
    sum_k² = rings * (rings + 1) * (2 * rings + 1) ÷ 6

    total_sum = 1 + 16 * sum_k² + 4 * sum_k + 4 * rings

    return total_sum
end

function solve()
    return diagonal_sum(1001)
end

end # module
