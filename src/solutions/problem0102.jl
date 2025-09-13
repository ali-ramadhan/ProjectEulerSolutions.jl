"""
Project Euler Problem 102: Triangle containment

Three distinct points are plotted at random on a Cartesian plane, for which
-1000 ≤ x, y ≤ 1000, such that a triangle is formed.

Consider the following two triangles:

A(-340,495), B(-153,-910), C(835,-947)

X(-175,41), Y(-421,-714), Z(574,-645)

It can be verified that triangle ABC contains the origin, whereas triangle XYZ does not.

Using triangles.txt (right click and 'Save Link/Target As...'), a 27K text file
containing the co-ordinates of one thousand "random" triangles, find the number of
triangles for which the interior contains the origin.

## Solution Approach

We use the area method to determine if a triangle contains the origin. A point P is
inside triangle ABC if and only if the sum of the areas of triangles PAB, PBC, and
PCA equals the area of triangle ABC.

For computational efficiency, we use the cross product to calculate signed areas.
The origin (0,0) is inside triangle with vertices (x1,y1), (x2,y2), (x3,y3) if
all three sub-triangle areas have the same sign when computed using the cross product.

This is equivalent to checking that the origin and all three vertices are on the same
side of each edge when traversed in a consistent order.

## Complexity Analysis

Time Complexity: O(n)

  - We process each triangle exactly once, with constant-time area calculations
  - Reading and parsing the file is also O(n) where n = 1000 triangles

Space Complexity: O(1)

  - We process triangles one at a time without storing them
  - Only constant additional space needed for calculations
"""
module Problem0102

function triangle_area_signed(x1, y1, x2, y2, x3, y3)
    return (x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / 2
end

function contains_origin(x1, y1, x2, y2, x3, y3)
    # Calculate signed areas of triangles formed by origin and each edge
    area1 = triangle_area_signed(0, 0, x1, y1, x2, y2)
    area2 = triangle_area_signed(0, 0, x2, y2, x3, y3)
    area3 = triangle_area_signed(0, 0, x3, y3, x1, y1)

    # Origin is inside if all areas have same sign (all positive or all negative)
    return (area1 > 0 && area2 > 0 && area3 > 0) || (area1 < 0 && area2 < 0 && area3 < 0)
end

function solve()
    count = 0
    data_file = joinpath(@__DIR__, "..", "..", "data", "0102_triangles.txt")

    open(data_file, "r") do file
        for line in eachline(file)
            coords = parse.(Int, split(line, ','))
            x1, y1, x2, y2, x3, y3 = coords

            if contains_origin(x1, y1, x2, y2, x3, y3)
                count += 1
            end
        end
    end

    return count
end

end # module
