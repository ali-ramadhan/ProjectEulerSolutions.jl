"""
Project Euler Problem 66: Diophantine Equation

Consider quadratic Diophantine equations of the form:
x² - Dy² = 1

For example, when D=13, the minimal solution in x is 649² - 13 × 180² = 1.

It can be assumed that there are no solutions in positive integers when D is square.

By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the following:
3² - 2 × 2² = 1
2² - 3 × 1² = 1
9² - 5 × 4² = 1
5² - 6 × 2² = 1
8² - 7 × 3² = 1

Hence, by considering minimal solutions in x for D ≤ 7, the largest x is obtained when D=5.

Find the value of D ≤ 1000 in minimal solutions of x for which the largest value of x is obtained.
"""
module Problem066

"""
    pell_solution(D)

Find the minimal solution (x, y) to Pell's equation x² - Dy² = 1 using continued fractions.
Returns (0, 0) if D is a perfect square (as no solution exists in positive integers).

This implementation uses the continued fraction expansion of √D to find convergents
until finding the first one that satisfies the Pell equation.
Uses BigInt to handle extremely large solutions.
"""
function pell_solution(D)
    D = BigInt(D)
    a₀ = isqrt(D)
    if a₀^2 == D
        return BigInt(0), BigInt(0)  # No solution for perfect squares
    end
    
    # Initialize for the continued fraction
    m = BigInt(0)
    d = BigInt(1)
    a = a₀
    
    # Initialize convergents
    p₀, p₁ = BigInt(1), BigInt(a₀)
    q₀, q₁ = BigInt(0), BigInt(1)
    
    # Compute the continued fraction and convergents until we find a solution
    while p₁^2 - D*q₁^2 != 1
        # Update continued fraction terms
        m = d * a - m
        d = (D - m^2) ÷ d
        a = (a₀ + m) ÷ d
        
        # Update convergents
        p₀, p₁ = p₁, a*p₁ + p₀
        q₀, q₁ = q₁, a*q₁ + q₀
    end
    
    return p₁, q₁
end

"""
    find_d_with_largest_x(limit)

Find the value of D ≤ limit for which the minimal solution to Pell's equation
x² - Dy² = 1 has the largest value of x.

Returns a tuple (d, x) where:
- d is the value of D that produces the largest x
- x is the largest minimal solution value

Uses BigInt to handle extremely large solutions.
"""
function find_d_with_largest_x(limit)
    max_x = BigInt(0)
    max_d = 0
    
    for d in 2:limit
        # Skip perfect squares as they have no solution in positive integers
        if isqrt(d)^2 == d
            continue
        end
        
        x, y = pell_solution(d)
        if x > max_x
            max_x = x
            max_d = d
        end
    end
    
    return max_d, max_x
end

function solve()
    d, x = find_d_with_largest_x(1000)
    return d
end

end # module
