"""
Project Euler Problem 68: Magic 5-gon Ring

Consider a "magic" 5-gon ring, filled with the numbers 1 to 10, 
and each line (consisting of 3 numbers) adding to the same sum.

Working clockwise, and starting from the group of three with the 
numerically lowest external node, each solution can be described uniquely.

Using the numbers 1 to 10, what is the maximum 16-digit string 
for a "magic" 5-gon ring?
"""
module Problem068

using Combinatorics: combinations, permutations

"""
    is_valid_configuration(outer, inner)

Check if the given configuration of outer and inner nodes forms a valid magic n-gon ring.
Returns the magic sum if valid, 0 otherwise.

# Arguments
- `outer`: Array of values for the outer nodes (vertices) of the n-gon, arranged clockwise
- `inner`: Array of values for the inner nodes (connecting points) of the n-gon, arranged clockwise

# Details
- Each "line" consists of an outer node, its corresponding inner node, and the next inner node clockwise
- For outer[i], the line contains: outer[i] + inner[i] + inner[mod1(i+1, n)]
- The function checks if all lines sum to the same "magic" value
- For a 5-gon ring, there are 5 lines: 
  * Line 1: outer[1] + inner[1] + inner[2]
  * Line 2: outer[2] + inner[2] + inner[3]
  * ...
  * Line 5: outer[5] + inner[5] + inner[1] (wraps around to the beginning)
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

Convert a valid magic n-gon ring to its string representation.
The string starts from the outer node with the minimum value and reads clockwise.

# Arguments
- `outer`: Array of values for the outer nodes (vertices) of the n-gon, arranged clockwise
- `inner`: Array of values for the inner nodes (connecting points) of the n-gon, arranged clockwise

# Details
- First finds the index of the minimum value in the outer array
- Starting from that minimum outer node, constructs the string by reading triplets clockwise
- Each triplet consists of: outer[i] + inner[i] + inner[mod1(i+1, n)]
- For a 5-gon with minimum outer node at position 1, the string would represent:
  * outer[1],inner[1],inner[2], outer[2],inner[2],inner[3], ..., outer[5],inner[5],inner[1]
- For Project Euler Problem 68, we need to find the maximum 16-digit string,
  which requires the number 10 to be placed on an outer node. If it's placed on an inner node
  then it will appear twice leading to a 17-digit string.
"""
function ngon_string(outer, inner)
    n = length(outer)
    min_idx = argmin(outer)
    
    # Build the string by reading triplets clockwise from the minimum
    result = ""
    for i in 0:(n-1)
        idx = mod1(min_idx + i, n)
        next_idx = mod1(idx + 1, n)
        result *= string(outer[idx]) * string(inner[idx]) * string(inner[next_idx])
    end
    
    return result
end


"""
    find_magic_5gon()

Find all possible magic 5-gon ring configurations using the numbers 1-10.
Returns a list of tuples (string_representation, magic_sum, length).

# Details
- Generates all possible distributions of numbers 1-10 between outer and inner nodes
- Ensures 10 is always placed on an outer node (to get a 16-digit string rather than 17)
- For each valid distribution, checks if it forms a magic 5-gon ring (all lines sum to the same value)
- For each valid configuration, computes the string representation and saves it with the magic sum
- The full search space is large: 10C5 combinations for selecting outer nodes,
  with 5! permutations of outer nodes and 5! permutations of inner nodes for each combination
- This function is useful for verifying the solution or finding all valid magic 5-gon rings
"""
function find_magic_5gon()
    n = 5  # 5-gon
    
    # We'll try different combinations with 10 always on an outer node
    solutions = Tuple{String, Int, Int}[]
    
    # Try different configurations of outer and inner nodes
    for outer_positions in combinations(1:10, n)
        if 10 ∉ outer_positions
            continue
        end
        
        inner_positions = setdiff(1:10, outer_positions)
        
        for outer_perm in permutations(outer_positions)
            for inner_perm in permutations(inner_positions)
                magic_sum = is_valid_configuration(outer_perm, inner_perm)
                
                if magic_sum > 0
                    string_rep = ngon_string(outer_perm, inner_perm)
                    push!(solutions, (string_rep, magic_sum, length(string_rep)))
                end
            end
        end
    end
    
    return solutions
end

"""
    solve()

Find the maximum 16-digit string for a "magic" 5-gon ring.
"""
function solve()
    solutions = find_magic_5gon()
    max_16_digit = ""
    
    for (str, sum, len) in solutions
        if len == 16 && (max_16_digit == "" || str > max_16_digit)
            max_16_digit = str
        end
    end
    
    return max_16_digit
end

end # module
