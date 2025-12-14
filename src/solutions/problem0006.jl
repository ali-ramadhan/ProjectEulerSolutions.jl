"""
Project Euler Problem 6: Sum Square Difference

Problem description: https://projecteuler.net/problem=6
Solution description: https://aliramadhan.me/blog/project-euler/problem-0006/
"""
module Problem0006

using ProjectEulerSolutions.Utils.Sequences: sum_of_squares, square_of_sum

function sum_square_difference(n)
    return square_of_sum(n) - sum_of_squares(n)
end

function solve()
    return sum_square_difference(100)
end

end # module
