"""
Project Euler Problem 106: Special Subset Sums: Meta-testing

Let S(A) represent the sum of elements in set A of size n.

We shall call it a special sum set if for any two non-empty disjoint subsets, B and C, the
following properties are true:

1. S(B) ≠ S(C); that is, sums of subsets cannot be equal.
2. If B contains more elements than C then S(B) > S(C).

For this problem we assume that a given set contains n strictly increasing elements and it
already satisfies the second rule.

Surprisingly, out of the 25 possible subset pairs that can be obtained from a set for which
n = 4, only 1 requires testing for equality (first rule). Similarly, when n = 7, only 70 out
of the 966 subset pairs require testing.

For n = 12, how many of the 261625 subset pairs require testing for equality?

## Solution Approach

This problem is about optimizing the verification of special sum sets by identifying which
subset pairs actually need to be tested for Rule 1 (equal sums).

The key insight is that for a strictly increasing set {a₁ < a₂ < ... < aₙ}, we only need to
test subset pairs B and C where their index patterns "interleave":

1. No Testing Needed: If max(indices of B) < min(indices of C), then S(B) < S(C) is
   guaranteed due to the strictly increasing property.

2. Testing Required: Only when the index patterns of B and C interleave, meaning there
   exist positions where elements from B are "mixed" with elements from C in terms of their
   positions in the sorted sequence.

The mathematical condition is: Two equal-size disjoint subsets B and C (with indices b₁ < b₂
< ... < bₖ and c₁ < c₂ < ... < cₖ) need testing if and only if there exists some i where bᵢ
> cᵢ.

## Complexity Analysis

Time complexity: O(4^n) in the worst case for brute force enumeration
- Generate all possible subset pairs and check the interleaving condition
- For n=12, this is still computationally feasible

Space complexity: O(1)
- Only need to track counters, no storage of actual subsets required

## Mathematical Background

This optimization is based on the fact that in a strictly increasing sequence, if two
disjoint subsets have completely separated index ranges, their sums cannot be equal. The
interleaving condition precisely captures when equality is possible.

## Key Insights

1. Index Interleaving: The core insight is recognizing that only interleaved index
   patterns can potentially have equal sums.

2. Equal Sizes Only: We only need to check pairs of equal-size subsets, since Rule 2 is
   already satisfied by assumption.

3. Combinatorial Counting: The problem reduces to counting subset pairs with interleaved
   index patterns, which can be done efficiently.
"""
module Problem106

function needs_testing(b_indices::Vector{Int}, c_indices::Vector{Int})
    """
    Check if two disjoint subsets with given indices need testing for equality.
    For strictly increasing sets, we only need testing when indices interleave.
    """
    length(b_indices) == length(c_indices) || return false

    # Sort both index vectors
    b_sorted = sort(b_indices)
    c_sorted = sort(c_indices)

    # Check if there exists any position where b[i] > c[i]
    # This indicates "interleaving" of indices
    for i in 1:length(b_sorted)
        if b_sorted[i] > c_sorted[i]
            return true
        end
    end

    return false
end

function count_testable_pairs(n::Int)
    """
    Count the number of subset pairs that require testing for equality.
    """
    count = 0

    # Generate all possible subset pairs of equal size
    for subset_size in 1:div(n, 2)
        # Generate all subsets of size subset_size
        subsets = []

        # Generate all combinations of size subset_size from 1:n
        function generate_combinations(arr, k, start, current)
            if k == 0
                push!(subsets, copy(current))
                return
            end

            for i in start:(length(arr) - k + 1)
                push!(current, arr[i])
                generate_combinations(arr, k - 1, i + 1, current)
                pop!(current)
            end
        end

        generate_combinations(collect(1:n), subset_size, 1, Int[])

        # Check all pairs of disjoint subsets
        for i in 1:length(subsets)
            for j in (i+1):length(subsets)
                b_indices = subsets[i]
                c_indices = subsets[j]

                # Check if disjoint
                if isempty(intersect(b_indices, c_indices))
                    if needs_testing(sort(b_indices), sort(c_indices))
                        count += 1
                    end
                end
            end
        end
    end

    return count
end

function solve()
    result = count_testable_pairs(12)

    @info "For n=12, $result subset pairs require testing for equality out of 261625 " *
          "total pairs"

    return result
end

end # module
