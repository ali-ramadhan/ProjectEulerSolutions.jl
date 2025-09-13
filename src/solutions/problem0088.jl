"""
Project Euler Problem 88: Product-sum numbers

A natural number, N, that can be written as the sum and product of a given set of at least
two natural numbers, {a1, a2, ... , ak} is called a product-sum number:
N = a1 + a2 + ... + ak = a1 × a2 × ... × ak.

For example, 6 = 1 + 2 + 3 = 1 × 2 × 3.

For a given set of size, k, we shall call the smallest N with this property a minimal
product-sum number. The minimal product-sum numbers for sets of size, k = 2, 3, 4, 5, and 6
are as follows.

k=2: 4 = 2 × 2 = 2 + 2
k=3: 6 = 1 × 2 × 3 = 1 + 2 + 3
k=4: 8 = 1 × 1 × 2 × 4 = 1 + 1 + 2 + 4
k=5: 8 = 1 × 1 × 2 × 2 × 2 = 1 + 1 + 2 + 2 + 2
k=6: 12 = 1 × 1 × 1 × 1 × 2 × 6 = 1 + 1 + 1 + 1 + 2 + 6

Hence for 2 ≤ k ≤ 6, the sum of the minimal product-sum numbers is 4+6+8+8+12 = 30; note
that 8 is only counted once in the sum.

In fact, as the complete set of minimal product-sum numbers for 2 ≤ k ≤ 12 is
{4, 6, 8, 12, 15, 16}, the sum is 61.

What is the sum of all the minimal product-sum numbers for 2 ≤ k ≤ 12000?

## Solution approach

The key insight is that if we have a set of factors with product P and sum S, we can add
(P-S) ones to make the sum equal the product, giving us k = original_count + (P-S).

We use recursive generation to explore all factor combinations:
1. Start with empty set (product=1, sum=0, count=0)
2. Try multiplying by factors ≥ 2 (or ≥ last factor to avoid duplicates)
3. For each combination, calculate k and check if it gives minimal N for that k
4. Use pruning: stop when product exceeds our search limit

The search limit is 2×max_k because the worst case is k factors all equal to 2.

## Complexity analysis

Time complexity: O(2^max_k)
- In the worst case, we explore all partitions of integers up to 2×max_k
- Pruning significantly reduces the search space in practice

Space complexity: O(max_k)
- Dictionary storing minimal N for each k value
- Recursion depth is bounded by the number of factors, roughly log(2×max_k)

## Key insights

This problem showcases how recursive enumeration with intelligent pruning can solve complex
combinatorial problems efficiently. The transformation k = count + (P-S) elegantly handles
the constraint that sum equals product.
"""
module Problem0088

"""
    find_minimal_product_sums(max_k)

Find the minimal product-sum numbers for all k from 2 to max_k.

The key insight is that if we have a set of numbers with product P and sum S, we can add
(P-S) ones to make the sum equal the product. This gives us:
- k = original_count + (P - S)
- N = P (the product-sum number for this k)

We use a recursive approach to generate all possible combinations of factors, computing
their products and sums, then determine which k each combination corresponds to and track
the minimal N for each k.

Returns a dictionary mapping k → minimal N for that k.
"""
function find_minimal_product_sums(max_k)
    # Dictionary to store minimal N for each k
    minimal = Dict{Int, Int}()

    # Upper bound for search - we need N ≤ 2*max_k (worst case is all 2's)
    max_n = 2 * max_k

    # Recursive function to generate all combinations
    function generate_combinations(product, sum, count, min_factor)
        if product > max_n
            return
        end

        # Calculate k: we need (product - sum) ones to make sum = product
        # So k = count + (product - sum)
        k = count + (product - sum)

        if k <= max_k && k >= 2
            if !haskey(minimal, k) || product < minimal[k]
                minimal[k] = product
            end
        end

        # Generate more combinations by multiplying with factors
        factor = min_factor
        while product * factor <= max_n
            generate_combinations(product * factor, sum + factor, count + 1, factor)
            factor += 1
        end
    end

    # Start recursion with first factor = 2
    generate_combinations(1, 0, 0, 2)

    return minimal
end

function solve()
    minimal_nums = find_minimal_product_sums(12000)
    unique_values = Set(values(minimal_nums))
    return sum(unique_values)
end

end # module
