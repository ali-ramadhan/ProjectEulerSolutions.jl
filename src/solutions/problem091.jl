"""
Project Euler Problem 91: Right triangles with integer coordinates

The points P (x₁, y₁) and Q (x₂, y₂) are plotted at integer coordinates and are joined to
the origin O (0,0) to form ΔOPQ.

There are exactly fourteen triangles containing a right angle that can be formed when each
coordinate lies between 0 and 2 inclusive; that is, 0 ≤ x₁, y₁, x₂, y₂ ≤ 2.

Given that 0 ≤ x₁, y₁, x₂, y₂ ≤ 50, how many right triangles can be formed?
"""
module Problem091

function count_right_angle_at_origin(limit)
    """Count triangles with right angle at origin"""
    # Right angle at origin: one point on positive x-axis, other on positive y-axis
    return limit^2
end

function count_right_angle_on_axes(limit)
    """Count triangles with right angle on the axes (excluding origin)"""
    # Right angles on x-axis: P at (x,0) for x=1..limit, Q at (x,y) for y=1..limit
    # Right angles on y-axis: P at (0,y) for y=1..limit, Q at (x,y) for x=1..limit
    # Each case gives limit * limit = limit² triangles
    return 2 * limit^2
end

function count_right_angle_interior(limit)
    """
    Count triangles with right angle at interior points (not on axes or origin).

    For each interior point P(x,y), we find all points Q such that triangle OPQ
    has a right angle at P. This happens when vectors PO and PQ are perpendicular.

    If PO = (-x,-y), then PQ must be proportional to the perpendicular vector (y,-x).
    All such points Q lie on a line through P with direction vector (y,-x).

    The "primitive direction" is the reduced form of (y,-x) obtained by dividing
    by gcd(x,y). This ensures we hit every lattice point on the line without
    skipping any. For example:
    - Point P(4,6): direction (6,-4) reduces to (3,-2) since gcd(4,6) = 2
    - This means we step by (3,-2) to hit all lattice points: P±(3,-2), P±2(3,-2), etc.
    """
    count = 0

    for x in 1:limit
        for y in 1:limit
            # Point P at (x,y), count points Q that make angle OPQ = 90°
            # Vector PO = (-x,-y), need PQ ⊥ PO
            # PQ direction must be proportional to (y,-x)

            # Use GCD to get primitive direction vector
            # This is the smallest integer direction that hits all lattice points on the line
            g = gcd(x, y)
            dx = y ÷ g  # Primitive x-component
            dy = -x ÷ g # Primitive y-component

            # Count lattice points in both directions from P along the perpendicular line
            # Positive direction: P + k*(dx,dy) for k = 1,2,3,...
            k = 1
            while true
                qx = x + k * dx
                qy = y + k * dy
                if qx >= 0 && qx <= limit && qy >= 0 && qy <= limit
                    count += 1
                    k += 1
                else
                    break
                end
            end

            # Negative direction: P - k*(dx,dy) for k = 1,2,3,...
            k = 1
            while true
                qx = x - k * dx
                qy = y - k * dy
                if qx >= 0 && qx <= limit && qy >= 0 && qy <= limit
                    count += 1
                    k += 1
                else
                    break
                end
            end
        end
    end

    return count
end

function count_right_triangles(limit)
    """Count right triangles using optimized mathematical approach"""
    count = 0

    # Category 1: Right angle at origin
    count += count_right_angle_at_origin(limit)

    # Category 2: Right angles on axes
    count += count_right_angle_on_axes(limit)

    # Category 3: Right angles at interior points
    count += count_right_angle_interior(limit)

    return count
end

function solve()
    """Count right triangles with coordinates in [0, 50]"""
    return count_right_triangles(50)
end

end # module
