"""
Project Euler Problem 79: Passcode Derivation

A common security method used for online banking is to ask the user for three random
characters from a passcode. For example, if the passcode was 531278, they may ask for the
2nd, 3rd, and 5th characters; the expected reply would be: 317.

The text file, keylog.txt, contains fifty successful login attempts.

Given that the three characters are always asked for in order, analyse the file so as to
determine the shortest possible secret passcode of unknown length.

## Solution approach

We model this as a directed graph where an edge from digit A to digit B means A must appear
before B in the passcode. From each login attempt "abc", we add edges a→b, a→c, and b→c.

The shortest passcode is the topological ordering of this graph. We use Kahn's algorithm
to find a valid topological sort.

## Complexity analysis

Time complexity: O(V + E)
- V is the number of unique digits, E is the number of ordering constraints
- Kahn's algorithm runs in O(V + E)

Space complexity: O(V + E)
- Stores the directed graph and in-degree counts
"""
module Problem0079

"""
    read_login_attempts(filename)

Read the login attempts from the specified file.
Each line in the file should contain one login attempt.
"""
function read_login_attempts(filename)
    attempts = String[]
    open(filename) do file
        for line in eachline(file)
            cleaned_line = strip(line)
            if !isempty(cleaned_line)
                push!(attempts, cleaned_line)
            end
        end
    end
    return attempts
end

"""
    build_order_constraints(login_attempts)

Build a directed graph of ordering constraints from login attempts.
"""
function build_order_constraints(login_attempts)
    # Create a directed graph (adjacency list)
    order_graph = Dict{Char, Set{Char}}()

    # Also track unique digits that appear in the login attempts
    unique_digits = Set{Char}()

    for attempt in login_attempts
        for digit in attempt
            push!(unique_digits, digit)
            if !haskey(order_graph, digit)
                order_graph[digit] = Set{Char}()
            end
        end

        # Add ordering constraints: for each triplet abc, a must come before b and c, and b before c
        for i in 1:(length(attempt) - 1)
            for j in (i + 1):length(attempt)
                push!(order_graph[attempt[i]], attempt[j])
            end
        end
    end

    return order_graph, unique_digits
end

"""
    topological_sort(graph, vertices)

Perform a topological sort using Kahn's algorithm.
"""
function topological_sort(graph, vertices)
    # Calculate in-degree for each vertex
    in_degree = Dict{Char, Int}()
    for v in vertices
        in_degree[v] = 0
    end

    for (_, neighbors) in graph
        for neighbor in neighbors
            in_degree[neighbor] += 1
        end
    end

    # Vertices with in-degree 0 can be added to the result first
    queue = Char[]
    for (v, degree) in in_degree
        if degree == 0
            push!(queue, v)
        end
    end

    # Resulting topological order
    result = Char[]

    while !isempty(queue)
        v = popfirst!(queue)
        push!(result, v)

        # Decrease in-degree of neighbors
        if haskey(graph, v)
            for neighbor in graph[v]
                in_degree[neighbor] -= 1
                if in_degree[neighbor] == 0
                    push!(queue, neighbor)
                end
            end
        end
    end

    # If we couldn't visit all vertices, there's a cycle
    if length(result) != length(vertices)
        error("Graph contains a cycle, no valid passcode exists.")
    end

    return result
end

"""
    derive_passcode(login_attempts)

Derive the shortest possible passcode from the login attempts.
"""
function derive_passcode(login_attempts)
    order_graph, unique_digits = build_order_constraints(login_attempts)
    ordered_digits = topological_sort(order_graph, unique_digits)
    return join(ordered_digits)
end

function solve()
    data_filepath = joinpath(@__DIR__, "..", "..", "data", "0079_keylog.txt")
    attempts = read_login_attempts(data_filepath)
    result = derive_passcode(attempts)
    @info "Derived shortest passcode from topological sort: $result"
    return result
end

end # module
