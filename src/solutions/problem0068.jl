"""
Project Euler Problem 68: Magic 5-gon Ring

Consider a "magic" 5-gon ring, filled with the numbers 1 to 10, and each line (consisting of
3 numbers) adding to the same sum.

Working clockwise, and starting from the group of three with the numerically lowest external
node, each solution can be described uniquely.

Using the numbers 1 to 10, what is the maximum 16-digit string for a "magic" 5-gon ring?

## Solution approach

This solution uses mathematical deduction instead of brute force:

1. **16-digit constraint**: For a 16-digit string, 10 must be on an outer node (otherwise
   we get 17 digits since inner nodes appear twice).

2. **Logical deduction for maximum**: For the lexicographically maximum string:
   - Outer nodes must be {6, 7, 8, 9, 10} (larger numbers for maximum string)
   - Inner nodes must be {1, 2, 3, 4, 5} (smaller numbers to balance the sums)

3. **Magic sum calculation**: Using the constraint 5×magic_sum = sum(outer) + 2×sum(inner):
   - sum(outer) = 6+7+8+9+10 = 40
   - sum(inner) = 1+2+3+4+5 = 15
   - magic_sum = (40 + 2×15) / 5 = 14

4. **Targeted construction**: With these constraints, we only need to find valid arrangements
   of {1,2,3,4,5} on inner nodes and {6,7,8,9,10} on outer nodes that sum to 14.

## Complexity analysis

Time complexity: O(5! × 5!) = O(14,400) in worst case
- Much more efficient than brute force O(C(10,5) × 5! × 5!) ≈ O(3.6 × 10^7)
- In practice, early termination makes it even faster

Space complexity: O(1)
- Store current configuration and results
- No significant additional storage needed

## Mathematical background

The magic sum formula: For any valid n-gon configuration, the sum of all lines equals
sum(outer_nodes) + 2×sum(inner_nodes). Since there are n lines, each with the same sum:
magic_sum = (sum(outer) + 2×sum(inner)) / n

For the maximal 5-gon solution, this mathematical constraint combined with the requirement
for maximum lexicographic value uniquely determines the number placement.
"""
module Problem0068

using Combinatorics: permutations

"""
    is_valid_configuration(outer, inner)

Check if the given configuration of outer and inner nodes forms a valid magic n-gon ring.
Returns the magic sum if valid, 0 otherwise.

# Arguments

  - `outer`: Array of values for the outer nodes (vertices) of the n-gon, arranged clockwise
  - `inner`: Array of values for the inner nodes (connecting points) of the n-gon, arranged
    clockwise

# Details

  - Each "line" consists of an outer node, its corresponding inner node, and the next inner
    node clockwise

  - For outer[i], the line contains: outer[i] + inner[i] + inner[mod1(i+1, n)]
  - The function checks if all lines sum to the same "magic" value
  - For a 5-gon ring, there are 5 lines:

      + Line 1: outer[1] + inner[1] + inner[2]
      + Line 2: outer[2] + inner[2] + inner[3]
      + ...
      + Line 5: outer[5] + inner[5] + inner[1] (wraps around to the beginning)
"""
function is_valid_configuration(outer, inner)
    n = length(outer)

    if length(inner) != n
        return 0
    end

    # Calculate the magic sum using the first line
    magic_sum = outer[1] + inner[1] + inner[mod1(2, n)]

    # Check all lines have the same sum
    for i in 1:n
        next_i = mod1(i + 1, n)
        if outer[i] + inner[i] + inner[next_i] != magic_sum
            return 0
        end
    end

    return magic_sum
end

"""
    ngon_string(outer, inner)

Convert a valid magic n-gon ring to its string representation. The string starts from the
outer node with the minimum value and reads clockwise.

# Arguments

  - `outer`: Array of values for the outer nodes (vertices) of the n-gon, arranged clockwise
  - `inner`: Array of values for the inner nodes (connecting points) of the n-gon, arranged
    clockwise

# Details

  - First finds the index of the minimum value in the outer array

  - Starting from that minimum outer node, constructs the string by reading triplets
    clockwise
  - Each triplet consists of: outer[i] + inner[i] + inner[mod1(i+1, n)]
  - For a 5-gon with minimum outer node at position 1, the string would represent:

      + outer[1],inner[1],inner[2], outer[2],inner[2],inner[3], ...,
        outer[5],inner[5],inner[1]
  - For Project Euler Problem 68, we need to find the maximum 16-digit string, which
    requires the number 10 to be placed on an outer node. If it's placed on an inner node
    then it will appear twice leading to a 17-digit string.
"""
function ngon_string(outer, inner)
    n = length(outer)
    min_idx = argmin(outer)

    # Build the string by reading triplets clockwise from the minimum
    result = ""
    for i in 0:(n - 1)
        idx = mod1(min_idx + i, n)
        next_idx = mod1(idx + 1, n)
        result *= string(outer[idx]) * string(inner[idx]) * string(inner[next_idx])
    end

    return result
end

"""
    find_max_magic_5gon()

Find the maximum 16-digit string for a magic 5-gon ring using logical deduction.

For the maximum solution:
- Outer nodes: {6, 7, 8, 9, 10}
- Inner nodes: {1, 2, 3, 4, 5} 
- Magic sum: 14

This function systematically tries arrangements of these specific number sets rather than
all possible permutations, making it much more efficient than brute force.
"""
function find_max_magic_5gon()
    # For maximum 16-digit solution, use logical deduction:
    # - Outer nodes: {6, 7, 8, 9, 10} (for maximum lexicographic value)
    # - Inner nodes: {1, 2, 3, 4, 5} (to balance the magic sum)
    # - Expected magic sum: (40 + 2*15) / 5 = 14
    
    outer_candidates = [6, 7, 8, 9, 10]
    inner_candidates = [1, 2, 3, 4, 5]
    target_magic_sum = 14
    
    max_solution = ""
    
    # Try different arrangements of the predetermined sets
    for outer_perm in permutations(outer_candidates)
        for inner_perm in permutations(inner_candidates)
            magic_sum = is_valid_configuration(outer_perm, inner_perm)
            
            if magic_sum == target_magic_sum
                string_rep = ngon_string(outer_perm, inner_perm)
                
                # Since we want the maximum string and it must be 16 digits
                if length(string_rep) == 16 && string_rep > max_solution
                    max_solution = string_rep
                end
            end
        end
    end
    
    return max_solution
end

"""
    solve()

Find the maximum 16-digit string for a "magic" 5-gon ring using logical deduction.

Returns the lexicographically maximum 16-digit string representation.
"""
function solve()
    result = find_max_magic_5gon()
    
    @info "Found maximum 16-digit magic 5-gon: $result"
    
    return result
end

end # module
