"""
Project Euler Problem 39: Integer Right Triangles

If p is the perimeter of a right angle triangle with integral length sides, {a, b, c},
there are exactly three solutions for p = 120.
{20,48,52}, {24,45,51}, {30,40,50}

For which value of p ≤ 1000, is the number of solutions maximised?
"""
module Problem039

"""
    count_right_triangles(p)

Count the number of right triangles with integer sides whose perimeter equals p.

Mathematical derivation:

  - For a right triangle with sides a, b, c (where c is the hypotenuse)
  - We know a² + b² = c² (Pythagorean theorem)
  - And a + b + c = p (perimeter constraint)
  - Substituting c = p - a - b into the Pythagorean theorem:
    a² + b² = (p - a - b)²
  - Expanding and solving for b:
    b = (p(p - 2a)) / (2(p - a))
  - We check if this value of b is an integer, and if it forms a valid triangle with a ≤ b ≤ c
"""
function count_right_triangles(p)
    count = 0

    for a in 1:div(p, 3)
        numerator = p * (p - 2a)
        denominator = 2 * (p - a)

        if numerator % denominator == 0
            b = numerator ÷ denominator
            c = p - a - b

            if a <= b && b <= c && a^2 + b^2 == c^2
                count += 1
            end
        end
    end

    return count
end

"""
    find_max_solutions(limit)

Find the perimeter p ≤ limit that has the maximum number of integer right triangles.
Returns a tuple (p, count) where p is the perimeter and count is the number of solutions.
"""
function find_max_solutions(limit)
    max_count = 0
    max_p = 0

    for p in 12:limit  # Minimum perimeter for a right triangle is 12 (3-4-5)
        count = count_right_triangles(p)
        if count > max_count
            max_count = count
            max_p = p
        end
    end

    return max_p, max_count
end

function solve()
    p_max, count = find_max_solutions(1000)
    @info "Found p=$p_max with $count right triangles with integer sides"
    return p_max
end

end # module
