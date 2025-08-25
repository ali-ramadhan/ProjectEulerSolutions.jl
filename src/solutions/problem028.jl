"""
Project Euler Problem 28: Number Spiral Diagonals

Starting with the number 1 and moving to the right in a clockwise direction a 5 × 5 spiral is formed as follows:

21 22 23 24 25
20  7  8  9 10
19  6  1  2 11
18  5  4  3 12
17 16 15 14 13

It can be verified that the sum of the numbers on the diagonals is 101.

What is the sum of the numbers on the diagonals in a 1001 × 1001 spiral formed in the same way?
"""
module Problem028

"""
    diagonal_sum(n)

Calculate the sum of the numbers on the diagonals in an n × n spiral,
where n is odd (representing the side length of the spiral).

For a spiral of size (2k+1) × (2k+1), the diagonal numbers follow a pattern:

  - The center is 1

  - Each subsequent ring adds 4 diagonal numbers
  - The corners of each ring k have values:

      + Bottom-right: (2k+1)²
      + Bottom-left: (2k+1)² - 2k
      + Top-left: (2k+1)² - 4k
      + Top-right: (2k+1)² - 6k

Using this pattern, we can derive a closed-form formula to calculate the sum directly.
"""
function diagonal_sum(n)
    if n % 2 == 0
        error("Spiral size must be odd")
    end

    rings = (n - 1) ÷ 2

    # For each ring k, the sum of its diagonal numbers is 4(2k+1)² - 12k
    # This simplifies to 16k² + 4k + 4
    # So the total sum is 1 + Σ(16k² + 4k + 4) for k = 1 to rings

    # Using the formulas for sum of k and sum of k²:
    # Sum of k from 1 to n = n(n+1)/2
    # Sum of k² from 1 to n = n(n+1)(2n+1)/6

    sum_k = rings * (rings + 1) ÷ 2
    sum_k² = rings * (rings + 1) * (2 * rings + 1) ÷ 6

    total_sum = 1 + 16 * sum_k² + 4 * sum_k + 4 * rings

    return total_sum
end

function solve()
    return diagonal_sum(1001)
end

end # module
