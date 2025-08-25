"""
Project Euler Problem 15: Lattice Paths

Starting in the top left corner of a 2 × 2 grid, and only being able to move to
the right and down, there are exactly 6 routes to the bottom right corner.

How many such routes are there through a 20 × 20 grid?
"""
module Problem015

"""
    count_lattice_paths(n, m)

Count the number of paths from the top-left to bottom-right corner of an n×m grid,
moving only right and down.

For a grid with n rows and m columns, we need to make exactly n moves down and m moves right.
This is a combination problem: binomial(n+m, n) or equivalently binomial(n+m, m).
"""
function count_lattice_paths(n, m)
    return binomial(n+m, n)
end

function solve()
    return count_lattice_paths(20, 20)
end

end # module
