"""
Project Euler Problem 105: Special Subset Sums: Testing

Let S(A) represent the sum of elements in set A of size n.

We shall call it a special sum set if for any two non-empty disjoint subsets, B and C, the
following properties are true:

1. S(B) ≠ S(C); that is, sums of subsets cannot be equal.
2. If B contains more elements than C then S(B) > S(C).

For example, {81, 88, 75, 42, 87, 84, 86, 65} is not a special sum set because 65 + 87 + 88
= 75 + 81 + 84, whereas {157, 150, 164, 119, 79, 159, 161, 139, 158} satisfies both rules
for all possible subset pair combinations and S(A) = 1286.

Using sets.txt, a 4K text file with one-hundred sets containing seven to twelve elements
(the two examples given above are the first two sets in the file), identify all the special
sum sets, A₁, A₂, ..., Aₖ, and find the value of S(A₁) + S(A₂) + ... + S(Aₖ).

## Solution Approach

This problem builds directly on Problem 103, using the same verification algorithm for
special sum sets. The approach is:

1. Data Parsing: Read the sets from the provided file, parsing each comma-separated line
   into a vector of integers.

2. Verification: For each set, use the optimized `is_special_sum_set` function from
   Problem 103 that implements both required rules:
   - Rule 2: Check that sum of k+1 smallest elements > sum of k largest elements
   - Rule 1: Generate all subset sums and verify no duplicates exist

3. Accumulation: Sum the total of all sets that pass the special sum set test.

## Complexity Analysis

Time complexity: O(m × n × 2^n) where m = 100 sets, n ≤ 12 elements per set
- For each of the 100 sets, verification requires O(2^n) subset sum generation
- Rule 2 check is O(n²) but negligible compared to Rule 1's O(2^n)
- With n ≤ 12, this gives at most 4096 subsets per set, totaling ~400K operations

Space complexity: O(2^n) = O(4096) for the largest sets
- Store subset sums in a Set for duplicate detection during Rule 1 verification

## Key Insights

1. Problem 103 Reuse: The verification logic is identical to Problem 103, allowing
   direct reuse of the optimized `is_special_sum_set` function.

2. Data Scale: With only 100 sets of at most 12 elements each, the brute force approach
   of checking all 2^n subsets is feasible and runs in reasonable time.

3. Example Verification: The problem provides two examples - the first fails (sum = 650)
   and the second passes (sum = 1286), giving us test cases.
"""
module Problem105

using ..Problem103: is_special_sum_set

function parse_sets_file(filename::String)
    sets = Vector{Vector{Int}}()

    for line in eachline(filename)
        line = strip(line)
        if !isempty(line)
            set = parse.(Int, split(line, ','))
            push!(sets, set)
        end
    end

    return sets
end

function solve()
    filename = joinpath(@__DIR__, "..", "..", "data", "0105_sets.txt")
    sets = parse_sets_file(filename)

    total_sum = 0
    special_count = 0

    for set in sets
        if is_special_sum_set(set)
            total_sum += sum(set)
            special_count += 1
        end
    end

    @info "Found $special_count special sum sets out of $(length(sets)) total sets " *
          "with total sum $total_sum"

    return total_sum
end

end # module
