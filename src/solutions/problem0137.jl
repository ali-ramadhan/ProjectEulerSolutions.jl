"""
Project Euler Problem 137: Fibonacci golden nuggets

Consider the infinite polynomial series A_F(x) = x F_1 + x² F_2 + x³ F_3 + ..., where F_k is
the kth term in the Fibonacci sequence: 1, 1, 2, 3, 5, 8, ...; that is,
F_k = F_{k-1} + F_{k-2}, F_1 = 1 and F_2 = 1.

For this problem we shall be interested in values of x for which A_F(x) is a positive
integer.

Surprisingly:
A_F(1/2) = (1/2)×1 + (1/2)²×1 + (1/2)³×2 + (1/2)⁴×3 + (1/2)⁵×5 + ...
         = 1/2 + 1/4 + 2/8 + 3/16 + 5/32 + ...
         = 2

The corresponding values of x for the first five natural numbers are:
- x = √2-1,        A_F(x) = 1
- x = 1/2,         A_F(x) = 2
- x = (√13-2)/3,   A_F(x) = 3
- x = (√89-5)/8,   A_F(x) = 4
- x = (√34-3)/5,   A_F(x) = 5

We shall call A_F(x) a golden nugget if x is rational, because they become increasingly
rarer; for example, the 10th golden nugget is 74049690.

Find the 15th golden nugget.

## Solution approach

The key insight is to find the closed form of the Fibonacci generating function:

Let A_F(x) = Σ(k=1 to ∞) x^k F_k

Using the Fibonacci recurrence F_k = F_{k-1} + F_{k-2}, we can derive:
A_F(x) = x F_1 + x² F_2 + Σ(k=3 to ∞) x^k (F_{k-1} + F_{k-2})
       = x + x² + x Σ(k=3 to ∞) x^{k-1} F_{k-1} + x² Σ(k=3 to ∞) x^{k-2} F_{k-2}
       = x + x² + x(A_F(x) - x) + x² A_F(x)
       = x + x² + x A_F(x) - x² + x² A_F(x)
       = x + x A_F(x) + x² A_F(x)

Therefore: A_F(x) = x + x A_F(x) + x² A_F(x)
Solving: A_F(x)(1 - x - x²) = x
So: A_F(x) = x/(1 - x - x²)

For A_F(x) = n (positive integer), we need:
x/(1 - x - x²) = n
x = n(1 - x - x²)
x = n - nx - nx²
nx² + (n+1)x - n = 0

For x to be rational, the discriminant must be a perfect square:
Δ = (n+1)² + 4n² = 5n² + 2n + 1

We need 5n² + 2n + 1 = m² for some integer m.

It turns out that golden nuggets follow a beautiful pattern:
The nth golden nugget = F_{2n} × F_{2n+1}

where F_k is the kth Fibonacci number.

## Complexity analysis

Time complexity: O(n)
- Generating the first 15 pairs of consecutive even/odd indexed Fibonacci numbers

Space complexity: O(1)
- Only storing a few Fibonacci values at a time

## Mathematical background

This problem connects to the theory of Pell equations and Fibonacci identities. The closed
form x/(1-x-x²) for the Fibonacci generating function leads to a quadratic Diophantine
equation, whose rational solutions correspond to products of consecutive Fibonacci numbers
with specific indices.

## Key insights

The golden nuggets are precisely F_{2k} × F_{2k+1} for k = 1, 2, 3, ..., making the
computation straightforward once this pattern is recognized.
"""
module Problem0137

"""
    generate_fibonacci_pair(n)

Generate the nth pair of consecutive even/odd indexed Fibonacci numbers.
Returns F_{2n} and F_{2n+1}.
"""
function generate_fibonacci_pair(n)
    # Generate Fibonacci numbers up to the required index
    fibs = [1, 1]  # F_1 = 1, F_2 = 1

    # We need F_{2n+1}, so generate up to index 2n+1
    target_index = 2n + 1

    while length(fibs) < target_index
        push!(fibs, fibs[end] + fibs[end-1])
    end

    return fibs[2n], fibs[2n+1]  # F_{2n}, F_{2n+1}
end

"""
    nth_golden_nugget(n)

Calculate the nth golden nugget using the formula: F_{2n} × F_{2n+1}
"""
function nth_golden_nugget(n)
    f_2n, f_2n_plus_1 = generate_fibonacci_pair(n)
    return f_2n * f_2n_plus_1
end

"""
    fibonacci_generating_function(x)

Calculate A_F(x) = x/(1 - x - x²) for verification purposes.
Note: This is mainly for testing small rational values.
"""
function fibonacci_generating_function(x)
    if abs(x) >= 1 || x <= 0  # Series must converge and x must be positive
        return nothing
    end
    return x / (1 - x - x^2)
end

"""
    verify_golden_nugget(value)

Verify that a value is a golden nugget by checking that the discriminant
5n² + 2n + 1 is a perfect square, where n is the value.
"""
function verify_golden_nugget(value)
    if value <= 0
        return false
    end

    # For very large numbers, the discriminant calculation might overflow
    # So we'll use a more robust approach with BigInt
    n = BigInt(value)

    # Calculate discriminant: 5n² + 2n + 1
    discriminant = 5n^2 + 2n + 1

    # Check if discriminant is a perfect square
    sqrt_discriminant = isqrt(discriminant)
    return sqrt_discriminant^2 == discriminant
end

function solve()
    return nth_golden_nugget(15)
end

end # module
