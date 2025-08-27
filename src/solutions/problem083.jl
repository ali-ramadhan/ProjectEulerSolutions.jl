"""
Project Euler Problem 83: Path Sum: Four Ways

In the 5×5 matrix below, the minimal path sum from the top left to the bottom right, by
moving left, right, up, and down, is indicated in bold red and is equal to 2297.

131 673 234 103  18
201  96 342 965 150
630 803 746 422 111
537 699 497 121 956
805 732 524  37 331

Find the minimal path sum from the top left to the bottom right by moving left, right, up,
and down in matrix.txt, a 31K text file containing an 80×80 matrix.

## Solution approach

With four-way movement allowed, this becomes a shortest path problem in a weighted graph. We
use Dijkstra's algorithm where each matrix cell is a node, and edges connect adjacent cells
with weights equal to the destination cell's value.

The algorithm maintains a priority queue of cells to visit, always processing the cell with
the minimum distance first. This guarantees we find the optimal path when we reach the
destination.

## Complexity analysis

Time complexity: O(mn log(mn))
- Each cell is added to and removed from the priority queue at most once
- Priority queue operations take O(log(mn)) time
- We process each edge (up to 4 per cell) once

Space complexity: O(mn)
- Distance array stores one entry per cell
- Priority queue can contain up to mn entries in the worst case
"""
module Problem083

using DataStructures
using ..Problem081: parse_matrix, read_matrix

"""
    find_minimal_path_sum(matrix)

Calculate the minimal path sum from the top left to the bottom right of the matrix, moving
left, right, up, and down.

Uses Dijkstra's algorithm to find the shortest path in a weighted graph. Each cell in the
matrix is treated as a node, and adjacent cells are connected. The weight of a path includes
the values of all cells along the path, including both the starting and ending cells.
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
