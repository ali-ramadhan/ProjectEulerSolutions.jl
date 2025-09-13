"""
Project Euler Problem 65: Convergents of e

The square root of 2 can be written as an infinite continued fraction.
√2 = 1 + 1/(2 + 1/(2 + 1/(2 + 1/(2 + ...))))

The infinite continued fraction can be written, √2 = [1; (2)], where (2) indicates that 2
repeats ad infinitum. In a similar way, √23 = [4; (1, 3, 1, 8)].

It turns out that the sequence of partial values of continued fractions for square roots
provide the best rational approximations.

What is most surprising is that the important mathematical constant,
e = [2; 1, 2, 1, 1, 4, 1, 1, 6, 1, ..., 1, 2k, 1, ...].

The first ten terms in the sequence of convergents for e are:
2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...

The sum of digits in the numerator of the 10th convergent is 1 + 4 + 5 + 7 = 17.

Find the sum of digits in the numerator of the 100th convergent of the continued fraction
for e.

## Solution approach

This solution computes convergents of the continued fraction for e:
1. Generate the first 100 terms of e's continued fraction:
   [2; 1,2,1, 1,4,1, 1,6,1, ..., 1,2k,1, ...]
2. Use the standard convergent recurrence relations:
   - pᵢ = aᵢ * pᵢ₋₁ + pᵢ₋₂
   - qᵢ = aᵢ * qᵢ₋₁ + qᵢ₋₂
3. Extract the 100th convergent's numerator and sum its digits
4. Use BigInt arithmetic to handle the large numerator values

## Complexity analysis

Time complexity: O(N * D) where N = 100 and D is the number of digits in the final numerator
- Generate 100 continued fraction terms: O(N)
- Compute convergent using recurrence: O(N) iterations with O(D) arithmetic per iteration
- Sum digits of final numerator: O(D)

Space complexity: O(D)
- Store the large numerator and denominator as BigInt
- Store continued fraction terms: O(N)

## Mathematical background

The continued fraction for e follows the pattern:
    e = [2; 1,2,1, 1,4,1, 1,6,1, ..., 1,2k,1, ...]

Convergents pᵢ/qᵢ are computed using:
- p₋₁ = 1, p₀ = a₀
- q₋₁ = 0, q₀ = 1
- pᵢ = aᵢ * pᵢ₋₁ + pᵢ₋₂ for i ≥ 1
- qᵢ = aᵢ * qᵢ₋₁ + qᵢ₋₂ for i ≥ 1

The numerators grow exponentially, requiring arbitrary precision arithmetic.
"""
module Problem0065

"""
    e_continued_fraction_terms(n)

Generate the first n terms of the continued fraction for e.
The pattern is [2; 1, 2, 1, 1, 4, 1, 1, 6, 1, ...], which follows
the structure [2; (1, 2k, 1)...] for k = 1, 2, 3, ...
"""
function e_continued_fraction_terms(n)
    terms = BigInt[2] # First term is 2

    if n == 1
        return terms
    end

    k = 1
    while length(terms) < n
        # Add the group (1, 2k, 1)
        push!(terms, 1)
        if length(terms) >= n
            break
        end

        push!(terms, 2*k)
        if length(terms) >= n
            break
        end

        push!(terms, 1)
        if length(terms) >= n
            break
        end

        k += 1
    end

    return terms
end

"""
    calculate_convergent(terms)

Calculate the convergent (numerator and denominator) for a given continued fraction
represented by the array of terms. Uses the recursive formula for computing convergents:
pᵢ = aᵢ * pᵢ₋₁ + pᵢ₋₂
qᵢ = aᵢ * qᵢ₋₁ + qᵢ₋₂
"""
function calculate_convergent(terms)
    p_minus_1 = BigInt(1)
    p_0 = BigInt(terms[1])
    q_minus_1 = BigInt(0)
    q_0 = BigInt(1)

    for i in 2:length(terms)
        p_i = terms[i] * p_0 + p_minus_1
        q_i = terms[i] * q_0 + q_minus_1

        p_minus_1 = p_0
        p_0 = p_i

        q_minus_1 = q_0
        q_0 = q_i
    end

    return p_0, q_0
end

"""
    sum_of_digits_in_numerator(convergent_index)

Calculate the sum of digits in the numerator of the nth convergent of the continued fraction
for e.
"""
function sum_of_digits_in_numerator(convergent_index)
    terms = e_continued_fraction_terms(convergent_index)
    numerator, _ = calculate_convergent(terms)
    return sum(digits(numerator))
end

function solve()
    return sum_of_digits_in_numerator(100)
end

end # module
