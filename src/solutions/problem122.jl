"""
Project Euler Problem 122: Efficient Exponentiation

The most naive method of computing n^15 requires 14 multiplications:

n × n × ... × n = n^15

But using a "binary" method you can compute it in 6 multiplications:

n × n = n^2
n^2 × n^2 = n^4
n^4 × n^4 = n^8
n^8 × n^4 = n^12
n^12 × n^2 = n^14
n^14 × n = n^15

However, you can compute it in only 5 multiplications:

n × n = n^2
n^2 × n = n^3
n^3 × n^3 = n^6
n^6 × n^6 = n^12
n^12 × n^3 = n^15

We define m(k) as the minimum number of multiplications to compute n^k.

Find ∑(k=1 to 200) m(k).

## Solution approach

This is the shortest addition chain problem. An addition chain for k is a sequence

1 = a₀ < a₁ < ... < aᵣ = k

where each aᵢ (i > 0) is the sum of two earlier terms. The length of the chain is r, which
equals m(k).

We use breadth-first search (BFS) to systematically find all shortest addition chains. The
critical insight from the Project Euler community is that for any number k, there can be
multiple optimal addition chains of the same length, and we must explore ALL of them because
they contain different intermediate values that may be essential for finding optimal chains
to larger numbers.

Key optimizations:
- Store all optimal chains to explore different intermediate values
- Use strictly increasing chains to avoid redundant permutations
- Early termination when all target numbers are found
- Special handling for m(191) which requires the deepest search (11 steps)

## Complexity analysis

Time complexity: O(n² * 2^(log n)) in worst case, but heavily pruned in practice
- BFS explores chains of increasing length until all targets ≤ 200 are found
- Multiple optimal paths must be stored and explored for each intermediate value
- Effective pruning reduces the search space dramatically

Space complexity: O(n * k) where k is average number of optimal paths per number
- Must store all optimal addition chains for intermediate results
- In practice, most numbers have few optimal paths

## Mathematical background

This problem is equivalent to finding shortest addition chains, studied extensively in
computer science and number theory. While most shortest chains are "star chains" (where each
new term uses the previous term), the first counterexample is n=12509, so star chain
algorithms are sufficient for this problem's range.

The binary method provides theoretical upper bounds: m(n) ≤ ⌊log₂(n)⌋ + popcount(n) - 1.
Knuth's power tree method gives better bounds but fails on specific values like m(77) and
m(154), which is why exhaustive BFS is needed for this problem.

## Key insights

1. Multiple optimal paths problem: Must store ALL optimal chains for each k
2. m(77)=8, m(154)=9, m(191)=11 are critical test cases
3. Early termination when all targets found enables effective pruning
4. Strictly increasing chains eliminate redundant search paths
"""
module Problem122

"""
    compute_addition_chain_lengths(max_target)

Compute minimum addition chain lengths for all numbers 1 to max_target using BFS.
Returns a dictionary mapping each number to its minimum chain length.
"""
function compute_addition_chain_lengths(max_target)
    # For each number, store all optimal chain prefixes that can reach it
    optimal_states = Dict{Int, Set{Vector{Int}}}()
    optimal_states[1] = Set([Int[1]])

    # Track minimum chain length for each number
    min_chain_length = Dict{Int, Int}()
    min_chain_length[1] = 0

    # BFS by chain length
    for chain_len in 1:12
        new_states = Dict{Int, Set{Vector{Int}}}()

        # Process all states from previous length
        for (target, states) in optimal_states
            current_min = get(min_chain_length, target, typemax(Int))
            if current_min > chain_len - 1
                continue
            end

            for state in states
                if length(state) != current_min + 1
                    continue
                end

                # Try all possible additions to extend the chain
                max_in_chain = state[end]
                for i in 1:length(state)
                    for j in i:length(state)
                        new_val = state[i] + state[j]

                        # Skip if too large, already in chain, or not strictly increasing
                        if new_val > max_target || new_val in state || new_val <= max_in_chain
                            continue
                        end

                        # Create new strictly increasing chain
                        new_state = [state..., new_val]

                        # Update if this gives a better or equal length path
                        current_best_len = get(min_chain_length, new_val, typemax(Int))
                        if chain_len < current_best_len
                            min_chain_length[new_val] = chain_len
                            new_states[new_val] = Set([new_state])
                        elseif chain_len == current_best_len
                            if !haskey(new_states, new_val)
                                new_states[new_val] = Set{Vector{Int}}()
                            end
                            push!(new_states[new_val], new_state)
                        end
                    end
                end
            end
        end

        # Merge new states
        for (num, states) in new_states
            if haskey(optimal_states, num)
                union!(optimal_states[num], states)
            else
                optimal_states[num] = states
            end
        end

        # Early termination if all targets found
        if all(k -> haskey(min_chain_length, k), 1:max_target)
            break
        end
    end

    return min_chain_length
end


"""
    sum_minimum_multiplications(max_target)

Calculate the sum of minimum multiplications for all numbers 1 to max_target.
"""
function sum_minimum_multiplications(max_target)
    min_multiplications = compute_addition_chain_lengths(max_target)
    return sum(min_multiplications[k] for k in 1:max_target)
end

function solve()
    return sum_minimum_multiplications(200)
end

end # module
