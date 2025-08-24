"""
Project Euler Problem 94: Almost Equilateral Triangles

It is easily proved that no equilateral triangle exists with integral side lengths and
integral area. However, the almost equilateral triangle 5-5-6 has an area of 12 square units.

We shall define an almost equilateral triangle to be a triangle for which two sides are
equal and the third differs from them by no more than one unit.

Find the sum of the perimeters of all almost equilateral triangles with integral side
lengths and integral area and whose perimeters do not exceed one billion (1,000,000,000).
"""
module Problem094

function has_integer_area(a, b)
    """Check if triangle with sides (a, a, b) has integer area using Heron's formula."""
    # For triangle with sides a, a, b, semi-perimeter s = (2a + b)/2
    # Area² = s(s-a)(s-a)(s-b) = s(s-a)²(s-b)
    # Let's work with 16 * area² to avoid fractions

    # s = (2a + b)/2, so 2s = 2a + b
    # 16 * area² = 16 * s * (s-a)² * (s-b)
    #            = (2a + b) * (b)² * (2a - b) / 4  (when 2s = 2a + b)
    #            = b² * (4a² - b²) / 4
    #            = b² * (4a² - b²) / 4

    # Actually, let's use a simpler approach
    # For triangle (a, a, b), area = (b/4) * sqrt(4a² - b²)
    # For integer area, 4a² - b² must be a perfect square times 16

    discriminant = 4 * a^2 - b^2

    if discriminant <= 0
        return false
    end

    # Check if discriminant is a perfect square
    sqrt_disc = isqrt(discriminant)
    if sqrt_disc * sqrt_disc != discriminant
        return false
    end

    # Area = (b * sqrt_disc) / 4
    # For integer area, b * sqrt_disc must be divisible by 4
    return (b * sqrt_disc) % 4 == 0
end

function find_almost_equilateral_triangles(limit)
    """Find all almost equilateral triangles with perimeter <= limit."""
    total_perimeter = 0

    # For smaller limits, use brute force search
    max_a = limit ÷ 3  # maximum possible value for side a

    for a in 3:max_a
        # Check triangle (a, a, a+1)
        if 3 * a + 1 <= limit && has_integer_area(a, a + 1)
            total_perimeter += 3 * a + 1
        end

        # Check triangle (a, a, a-1)
        if a > 1 && 3 * a - 1 <= limit && has_integer_area(a, a - 1)
            total_perimeter += 3 * a - 1
        end
    end

    return total_perimeter
end

function solve()
    return find_almost_equilateral_triangles(1000000000)
end

end # module
