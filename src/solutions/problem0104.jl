"""
Project Euler Problem 104: Pandigital Fibonacci ends

The Fibonacci sequence is defined by the recurrence relation:
F(n) = F(n−1) + F(n−2), where F(1) = 1 and F(2) = 1.

It turns out that F(541), which contains 113 digits, is the first Fibonacci number for which the last nine digits are 1-9 pandigital (contain all the digits 1 to 9, but not necessarily in order). And F(2749), which contains 575 digits, is the first Fibonacci number for which the first nine digits are 1-9 pandigital.

Given that F(k) is the first Fibonacci number for which the first nine digits AND the last nine digits are both 1-9 pandigital, find k.

## Solution approach

This problem requires finding large Fibonacci numbers, but we only need:
1. The last 9 digits (for pandigital check)
2. The first 9 digits (for pandigital check)

For the last 9 digits, we use modular arithmetic with mod 10^9 to avoid computing massive numbers.

For the first 9 digits, we use Binet's formula with logarithmic computation:
- F(n) ≈ φⁿ/√5, where φ = (1+√5)/2 (golden ratio)
- log₁₀(F(n)) ≈ n*log₁₀(φ) - log₁₀(√5)
- If log₁₀(F(n)) = integer_part + fractional_part, then first 9 digits ≈ floor(10^(fractional_part + 8))

We iterate through Fibonacci indices, checking both conditions until we find the first k where both ends are pandigital.

## Complexity analysis

Time complexity: O(k) where k is the answer
- Each iteration involves constant-time modular arithmetic and logarithmic computations
- Pandigital checks are O(1) since we only check 9 digits

Space complexity: O(1)
- We only store current Fibonacci terms modulo 10^9 and intermediate calculations

## Mathematical background

The key insight is using Binet's formula: F(n) = (φⁿ - ψⁿ)/√5, where:
- φ = (1+√5)/2 ≈ 1.618 (golden ratio)  
- ψ = (1-√5)/2 ≈ -0.618

For large n, ψⁿ becomes negligible, so F(n) ≈ φⁿ/√5.

Taking logarithms: log₁₀(F(n)) ≈ n*log₁₀(φ) - log₁₀(√5)

If this equals I + f where I is integer and 0 ≤ f < 1, then F(n) ≈ 10^f * 10^I.
The first 9 digits are determined by 10^f scaled appropriately.

## Key insights

1. We can't compute F(k) directly for large k due to size, but we only need specific digit ranges
2. Modular arithmetic handles the last 9 digits efficiently  
3. Logarithmic computation with Binet's formula handles the first 9 digits
4. Both F(541) and F(2749) are given as reference points, suggesting k > 2749
"""
module Problem0104

using ProjectEulerSolutions.Utils.Digits: is_pandigital

function is_pandigital_9_digits(n)
    return is_pandigital(n, 1:9)
end

function get_last_9_digits(fib_mod)
    return fib_mod
end

function get_first_9_digits(n)
    # Using Binet's formula: F(n) ≈ φⁿ/√5
    # log₁₀(F(n)) ≈ n*log₁₀(φ) - log₁₀(√5)
    phi = (1 + sqrt(5)) / 2
    log_phi = log10(phi)
    log_sqrt5 = log10(sqrt(5))
    
    log_fn = n * log_phi - log_sqrt5
    
    # Get fractional part
    fractional_part = log_fn - floor(log_fn)
    
    # First 9 digits: 10^(fractional_part + 8)
    first_9 = floor(Int, 10^(fractional_part + 8))
    
    return first_9
end

function solve()
    # Start from a reasonable point since we know F(2749) is first with pandigital first 9
    # and we need both conditions
    k = 2750
    
    # Initialize Fibonacci computation for last 9 digits (mod 10^9)
    mod_val = 1_000_000_000  # 10^9
    
    # We need to compute F(k) mod 10^9, so we need to start from F(1), F(2)
    # and work our way up to k
    a, b = 1, 1  # F(1), F(2)
    
    # Compute up to k-2, then we'll be at F(k-1), F(k)  
    for i in 3:k
        a, b = b, (a + b) % mod_val
    end
    
    # Now a = F(k-1) mod 10^9, b = F(k) mod 10^9
    while true
        # Check if both first and last 9 digits are pandigital
        last_9 = get_last_9_digits(b)
        first_9 = get_first_9_digits(k)
        
        if is_pandigital_9_digits(last_9) && is_pandigital_9_digits(first_9)
            return k
        end
        
        # Move to next Fibonacci number
        k += 1
        a, b = b, (a + b) % mod_val
    end
end

end # module