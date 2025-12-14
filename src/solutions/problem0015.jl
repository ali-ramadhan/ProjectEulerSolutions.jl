"""
Project Euler Problem 15: Lattice Paths

Problem description: https://projecteuler.net/problem=15
Solution description: https://aliramadhan.me/blog/project-euler/problem-0015/
"""
module Problem0015

function count_lattice_paths(n, m)
    return binomial(n+m, n)
end

function solve()
    return count_lattice_paths(20, 20)
end

end # module
