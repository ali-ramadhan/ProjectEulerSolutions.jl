"""
Project Euler Problem 6: Sum Square Difference

Problem description: https://projecteuler.net/problem=6
Solution description: https://aliramadhan.me/blog/project-euler/problem-0006/
"""
module Problem0006

function sum_square_difference(n)
    return n * (n + 1) * (n - 1) * (3n + 2) ÷ 12
end

function solve()
    return sum_square_difference(100)
end

end # module
