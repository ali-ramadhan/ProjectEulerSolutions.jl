"""
Project Euler Problem 138: Special Isosceles Triangles

Consider the isosceles triangle with base length, b = 16, and legs, L = 17.

By using the Pythagorean theorem it can be seen that the height of the triangle,
h = √(17² - 8²) = 15, which is one less than the base length.

With b = 272 and L = 305, we get h = 273, which is one more than the base length, and this
is the second smallest isosceles triangle with the property that h = b ± 1.

Find ∑L for the twelve smallest isosceles triangles for which h = b ± 1 and b, L are
positive integers.

## Solution approach

This problem reduces to finding solutions to a generalized Pell equation. For an isosceles
triangle with base b and legs L, the height is h = √(L² - (b/2)²).

The constraint h = b ± 1 leads to the equation: L² - (b/2)² = (b ± 1)² 4L² = 5b² ± 8b + 4

This connects to solutions of the generalized Pell equation x² - 5y² = ±4. The solutions
follow a second-order linear recurrence: L_{n+1} = 18*L_n - L_{n-1} with initial values
L₁ = 17 and L₂ = 305 from the problem examples.

## Complexity analysis

Time complexity: O(n)
- Generate n terms using the linear recurrence relation
- Each recurrence step is O(1) with simple arithmetic

Space complexity: O(1)
- Only store current and previous L values in the recurrence

## Mathematical background

The generalized Pell equation x² - 5y² = ±4 has solutions that generate special isosceles
triangles. The fundamental solution to x² - 5y² = 1 is (x,y) = (9,4), and from this we can
derive solutions to the ±4 variants.

The recurrence L_{n+1} = 18*L_n - L_{n-1} arises from the characteristic equation of the
underlying Pell equation solutions, where 18 = 2*(9) comes from twice the x-coordinate of
the fundamental solution.

## Key insights

The problem reduces to a simple linear recurrence rather than complex Pell equation
manipulations, making the solution both elegant and computationally efficient. The large
coefficient 18 in the recurrence leads to exponentially growing L values.
"""
module Problem0138

export find_special_triangles, verify_triangle, solve

"""
    find_special_triangles(n)

Find the first n special isosceles triangles where h = b ± 1.
Uses the recurrence relation L_{n+1} = 18*L_n - L_{n-1} derived from
solutions to the generalized Pell equation x² - 5y² = ±4.
"""
function find_special_triangles(n)
    if n <= 0
        return 0
    end

    # Use the recurrence relation L_{n+1} = 18*L_n - L_{n-1}
    # with initial values L_1 = 17, L_2 = 305 from the problem examples

    if n == 1
        return 17
    elseif n == 2
        return 17 + 305
    end

    L = [17, 305]  # First two known values
    sum_L = 17 + 305

    for k in 3:n
        # The correct recurrence relation for the Pell equation x² - 5y² = ±4
        # L_{n+1} = 18*L_n - L_{n-1}
        next_L = 18 * L[2] - L[1]
        sum_L += next_L
        L[1], L[2] = L[2], next_L
        @info "Found triangle $k: L = $(L[2])"
    end

    return sum_L
end

"""
    verify_triangle(L)

Verify that a given L value corresponds to a valid special isosceles triangle.
Returns the base length b if valid, or nothing if invalid.
"""
function verify_triangle(L)
    # For a valid triangle, we need either:
    # Case 1: h = b - 1, so L² = (b/2)² + (b-1)²
    # Case 2: h = b + 1, so L² = (b/2)² + (b+1)²

    L² = L^2

    # Try to find integer b such that one of the cases holds
    for b in 1:2*L  # reasonable upper bound
        h1² = (b - 1)^2
        h2² = (b + 1)^2
        expected1 = (b ÷ 2)^2 + h1²  # Case h = b - 1
        expected2 = (b ÷ 2)^2 + h2²  # Case h = b + 1

        # Check if b is even (so b/2 is integer)
        if b % 2 == 0
            if 4 * L² == b^2 + 4 * h1²  # Multiply by 4 to avoid fractional b/2
                return b, b - 1  # Return (base, height)
            elseif 4 * L² == b^2 + 4 * h2²
                return b, b + 1  # Return (base, height)
            end
        end
    end

    return nothing
end

function solve()
    return find_special_triangles(12)
end

end # module
