"""
Project Euler Problem 83: Path Sum: Four Ways

In the 5×5 matrix below, the minimal path sum from the top left to the bottom right,
by moving left, right, up, and down, is indicated in bold red and is equal to 2297.

[Matrix shown in problem]

Find the minimal path sum from the top left to the bottom right by moving left, right, up,
and down in matrix.txt, a 31K text file containing an 80×80 matrix.
"""
module Problem083

using DataStructures

"""
    parse_matrix(str)

Parse a matrix from a string where each row is a comma-separated list of numbers.
Returns a 2D array of integers.
"""
function parse_matrix(str)
    lines = split(strip(str), r"\r?\n")
    rows = length(lines)

    # Determine number of columns based on first row
    cols = length(split(lines[1], ','))

    matrix = Array{Int}(undef, rows, cols)

    for (i, line) in enumerate(lines)
        nums = split(line, ',')
        for (j, num) in enumerate(nums)
            matrix[i, j] = parse(Int, num)
        end
    end

    return matrix
end

"""
    read_matrix(filename)

Read a matrix from a file where each row is a comma-separated list of numbers.
"""
function read_matrix(filename)
    content = read(filename, String)
    return parse_matrix(content)
end

"""
    find_minimal_path_sum(matrix)

Calculate the minimal path sum from the top left to the bottom right
of the matrix, moving left, right, up, and down.

Uses Dijkstra's algorithm to find the shortest path in a weighted graph.
Each cell in the matrix is treated as a node, and adjacent cells are connected.
The weight of a path includes the values of all cells along the path,
including both the starting and ending cells.
"""
function find_minimal_path_sum(matrix)
    rows, cols = size(matrix)

    # Handle empty matrix
    if rows == 0 || cols == 0
        return 0
    end

    # Initialize distances to infinity
    distances = fill(typemax(Int), rows, cols)

    # Distance to the starting point is its own value
    distances[1, 1] = matrix[1, 1]

    # Priority queue for Dijkstra's algorithm
    # We store (distance, (row, col)) pairs
    pq = PriorityQueue{Tuple{Int, Int}, Int}()
    enqueue!(pq, (1, 1) => distances[1, 1])

    # Possible movements: right, down, left, up
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

    while !isempty(pq)
        # Get the node with minimum distance
        (row, col), dist = dequeue_pair!(pq)

        # If we've reached the destination, we're done
        if row == rows && col == cols
            break
        end

        # If we've found a shorter path already, skip
        if dist > distances[row, col]
            continue
        end

        # Check all neighboring cells
        for (dr, dc) in directions
            new_row, new_col = row + dr, col + dc

            # Skip if out of bounds
            if new_row < 1 || new_row > rows || new_col < 1 || new_col > cols
                continue
            end

            # Calculate new distance
            new_dist = distances[row, col] + matrix[new_row, new_col]

            # If we found a shorter path, update distance and enqueue
            if new_dist < distances[new_row, new_col]
                distances[new_row, new_col] = new_dist
                enqueue!(pq, (new_row, new_col) => new_dist)
            end
        end
    end

    return distances[rows, cols]
end

function solve()
    data_filepath = joinpath(@__DIR__, "..", "..", "data", "0083_matrix.txt")
    matrix = read_matrix(data_filepath)
    return find_minimal_path_sum(matrix)
end

end # module
