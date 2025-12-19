"""
Project Euler Problem 28: Number Spiral Diagonals

Problem description: https://projecteuler.net/problem=28
Solution description: https://aliramadhan.me/blog/project-euler/problem-0028/
"""
module Problem0028

function diagonal_sum(n)
    if iseven(n)
        error("Spiral size must be odd")
    end

    m = (n - 1) ÷ 2

    sum_k = m * (m + 1) ÷ 2
    sum_k² = m * (m + 1) * (2 * m + 1) ÷ 6

    return 1 + 16 * sum_k² + 4 * sum_k + 4 * m
end

function solve()
    return diagonal_sum(1001)
end

end # module
