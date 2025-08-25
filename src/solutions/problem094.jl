"""
Project Euler Problem 94: Almost Equilateral Triangles

It is easily proved that no equilateral triangle exists with integral side lengths and
integral area. However, the almost equilateral triangle 5-5-6 has an area of 12 square units.

We shall define an almost equilateral triangle to be a triangle for which two sides are
equal and the third differs from them by no more than one unit.

Find the sum of the perimeters of all almost equilateral triangles with integral side
lengths and integral area and whose perimeters do not exceed one billion (1,000,000,000).

Mathematical Background:

  - Almost equilateral triangles with integer area are connected to Pell's equation x² - 3y² = 1
  - Two types exist: (a,a,a+1) and (a,a,a-1) triangles
  - Only ~14-17 triangles exist below 1 billion perimeter limit
  - The Pell equation approach generates solutions using recurrence relations:
    x_{n+1} = 2x_n + 3y_n, y_{n+1} = x_n + 2y_n, starting from (x₁,y₁) = (2,1)
  - For each Pell solution x, check if (2x±1) is divisible by 3 to get triangle side a = (2x±1)/3
  - This achieves O(log n) complexity with ~1000x speedup over brute force approaches

Implementation uses optimized Pell equation approach for maximum performance.
"""
module Problem094

function solve_pell_equation(limit)
    """Solve using Pell equation x² - 3y² = 1 approach."""
    x, y = 2, 1  # Fundamental solution
    total = 0

    while true
        # Check both cases: (2x + 1) mod 3 and (2x - 1) mod 3
        if (2x + 1) % 3 == 0
            a = (2x + 1) ÷ 3
            b = a + 1
            # Skip degenerate triangles (where b <= 0 or a <= 0)
            if a > 1 && b > 1
                perimeter = 2a + b  # = 3a + 1
                if perimeter <= limit
                    total += perimeter
                else
                    break
                end
            end
        elseif (2x - 1) % 3 == 0
            a = (2x - 1) ÷ 3
            b = a - 1
            # Skip degenerate triangles (where b <= 0 or a <= 0)
            if a > 1 && b > 0
                perimeter = 2a + b  # = 3a - 1
                if perimeter <= limit
                    total += perimeter
                else
                    break
                end
            end
        end

        # Generate next Pell solution
        x_new, y_new = 2x + 3y, x + 2y
        x, y = x_new, y_new

        # Safety check to avoid infinite loop
        if x > limit
            break
        end
    end

    return total
end

function solve()
    return solve_pell_equation(1000000000)
end

end # module
