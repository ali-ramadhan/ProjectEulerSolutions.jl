"""
Project Euler Problem 101: Optimum Polynomial

If we are presented with the first k terms of a sequence, it is impossible to say with
certainty the value of the next term, as there are infinitely many polynomial functions
that can model the sequence.

As an example, let us consider the sequence of cube numbers. This is defined by the
generating function, un = n³.

1, 8, 27, 64, 125, 216, ...

Suppose we were only given the first two terms of this sequence. Working on the
assumption that the sequence is polynomial, we should use Lagrange's interpolation
method to find the polynomial function of lowest degree that models the sequence.

The unique polynomial function of degree at most one (linear) that models the first
two terms is: P₁(n) = 7n - 6.

Hence, the third term as predicted by this polynomial is P₁(3) = 15.

Even if we were presented with the first three terms, by the same process we would
find the unique polynomial function of degree at most two (quadratic) that models the
sequence: P₂(n) = 6n² - 11n + 6.

Hence, the fourth term as predicted by this polynomial is P₂(4) = 35.

Clearly the predicted value is not correct as we have seen that the fourth term should
be 64. What we have here is called a Bad OP (BOP), a polynomial that when used to
predict the next term is incorrect; the value 35 is called the First Incorrect Term (FIT).

As it turns out, for every polynomial function of degree at most n, if we are presented
with the first (n+1) terms of the sequence, we can uniquely determine the polynomial
and the next term will be correctly predicted. For a polynomial function of degree n,
this means the FIT will be the (n+2)th term.

For the sequence of cube numbers, the BOPs are OP₁, OP₂, ..., OP₁₀, and the sum of FITs is:
15 + 35 + 58 + 91 + 140 + 204 + 285 + 385 + 506 + 650 = 2169

Find the sum of FITs for the BOPs for the following tenth-degree polynomial:
un = 1 - n + n² - n³ + n⁴ - n⁵ + n⁶ - n⁷ + n⁸ - n⁹ + n¹⁰

## Solution Approach

We use Lagrange interpolation to construct optimum polynomials from the first k terms
of the sequence. For each OP of degree k-1 (based on k terms), we predict term k+1
and compare it to the actual value from the original polynomial.

The algorithm:

 1. Generate the actual sequence terms from the given polynomial
 2. For each k from 1 to 10, construct the optimum polynomial using the first k terms
 3. Evaluate this polynomial at position k+1 to get the predicted next term
 4. If it differs from the actual term, record it as a FIT

## Complexity Analysis

**Time Complexity**: O(k³) where k is the degree of the polynomial (10)

  - For each k, Lagrange interpolation takes O(k²) time
  - We do this for k = 1 to 10, giving O(k³) overall

**Space Complexity**: O(k)

  - Store k points for interpolation and polynomial coefficients

## Mathematical Background

Lagrange interpolation constructs the unique polynomial of degree at most n-1 that
passes through n given points. For points (x₀,y₀), (x₁,y₁), ..., (xₙ₋₁,yₙ₋₁):

P(x) = Σ yⱼ * Πᵢ≠ⱼ (x - xᵢ)/(xⱼ - xᵢ)

This gives us the optimum polynomial for predicting the next term in the sequence.

## Key Insights

  - A polynomial of degree n requires exactly n+1 points to uniquely determine it
  - Using fewer points gives a lower-degree approximation that may incorrectly predict future terms
  - The FIT occurs at position k+1 when using k terms to build the optimum polynomial
"""
module Problem101

"""
    evaluate_polynomial(n)

Evaluate the given tenth-degree polynomial at position n:
un = 1 - n + n² - n³ + n⁴ - n⁵ + n⁶ - n⁷ + n⁸ - n⁹ + n¹⁰
"""
function evaluate_polynomial(n)
    result = 1
    power = 1
    sign = -1

    for i in 1:10
        power *= n
        result += sign * power
        sign *= -1
    end

    return result
end

"""
    lagrange_interpolation(points, x)

Perform Lagrange interpolation on the given points and evaluate at x.
Points should be an array of (xi, yi) tuples.
"""
function lagrange_interpolation(points, x)
    n = length(points)
    result = 0.0

    for i in 1:n
        xi, yi = points[i]

        # Calculate the Lagrange basis polynomial Li(x)
        Li = 1.0
        for j in 1:n
            if i != j
                xj, _ = points[j]
                Li *= (x - xj) / (xi - xj)
            end
        end

        result += yi * Li
    end

    return round(Int, result)
end

"""
    find_fit_sum()

Find the sum of First Incorrect Terms (FITs) for Bad Optimum Polynomials (BOPs).
"""
function find_fit_sum()
    fit_sum = 0

    # For each k from 1 to 10, we construct an optimum polynomial using k terms
    for k in 1:10
        # Generate the first k terms of the actual sequence
        points = [(i, evaluate_polynomial(i)) for i in 1:k]

        # Predict the (k+1)th term using Lagrange interpolation
        predicted = lagrange_interpolation(points, k + 1)

        # Get the actual (k+1)th term
        actual = evaluate_polynomial(k + 1)

        # If prediction is wrong, this is a FIT
        if predicted != actual
            fit_sum += predicted
        end
    end

    return fit_sum
end

function solve()
    return find_fit_sum()
end

end # module
