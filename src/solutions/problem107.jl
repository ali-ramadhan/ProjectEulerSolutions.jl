"""
Project Euler Problem 107: Minimal Network

The following undirected network consists of seven vertices and twelve edges with a total
weight of 243.

The same network can be represented by the matrix below.

Although it is possible to select any two vertices and travel between them via the network,
the matrix contains redundant edges. It is possible to remove certain edges and still ensure
that all points on the network remain connected.

The network which achieves this, and has the minimum total weight, is called a minimal
spanning tree.

By finding the minimal spanning tree for the given network, and by reducing the network to a
minimal spanning tree, the maximum saving which can be achieved is 243 − 93 = 150.

Using network.txt, a 6K text file containing a network with forty vertices, find the maximum
saving which can be achieved by removing redundant edges whilst ensuring that the network
remains connected.

## Solution approach

This is a classic Minimum Spanning Tree (MST) problem. We need to:

1. Parse the adjacency matrix from the input file
2. Convert it to a list of edges with weights
3. Use Kruskal's algorithm with Union-Find to find the MST
4. Calculate the difference between original total weight and MST weight

Kruskal's algorithm works by:
- Sorting all edges by weight
- Processing edges from lightest to heaviest
- Adding an edge to MST if it doesn't create a cycle (using Union-Find)
- Stopping when we have n-1 edges for n vertices

## Complexity analysis

Time complexity: O(E log E)
- Parsing matrix: O(V²) where V is number of vertices
- Sorting edges: O(E log E) where E is number of edges
- Union-Find operations: O(E α(V)) ≈ O(E) for practical purposes

Space complexity: O(E + V)
- Storing edges: O(E)
- Union-Find structure: O(V)

## Mathematical background

A spanning tree of a connected graph G is a subgraph that:
- Includes all vertices of G
- Is a tree (connected and acyclic)
- Has exactly |V| - 1 edges

The minimum spanning tree is the spanning tree with minimum total edge weight. Kruskal's
algorithm is a greedy algorithm that always finds the optimal MST.
"""
module Problem107

"""
    UnionFind

Disjoint Set Union (DSU) data structure for efficiently managing disjoint sets.

This implementation uses two key optimizations:
1. **Path compression** in `find`: Makes all nodes on the path point directly to the root
2. **Union by rank**: Always attaches the shorter tree under the taller tree

Used in Kruskal's MST algorithm to detect cycles: if two vertices are already in the 
same connected component, adding an edge between them would create a cycle.

# Fields
- `parent::Vector{Int}`: parent[i] points to the parent of element i (or itself if root)
- `rank::Vector{Int}`: rank[i] is the approximate height of the tree rooted at i

# Time Complexity
- `find` and `union!`: O(α(n)) where α is the inverse Ackermann function
- For practical purposes, this is effectively O(1)
"""
struct UnionFind
    parent::Vector{Int}
    rank::Vector{Int}
end

"""
    UnionFind(n::Int)

Create a UnionFind structure for n elements (numbered 1 to n).
Initially, each element is its own parent (forms singleton sets).
"""
function UnionFind(n::Int)
    UnionFind(collect(1:n), zeros(Int, n))
end

"""
    find(uf::UnionFind, x::Int) -> Int

Find the root representative of the set containing element x.

Uses **path compression**: during traversal, makes all nodes on the path point 
directly to the root. This flattens the tree structure and makes future lookups 
much faster.

# Example
```julia
uf = UnionFind(5)
union!(uf, 1, 2)
union!(uf, 2, 3)
find(uf, 3)  # Returns the same root as find(uf, 1)
```
"""
function find(uf::UnionFind, x::Int)
    if uf.parent[x] != x
        uf.parent[x] = find(uf, uf.parent[x])  # Path compression
    end
    return uf.parent[x]
end

"""
    union!(uf::UnionFind, x::Int, y::Int) -> Bool

Merge the sets containing elements x and y.

Uses **union by rank**: always attaches the tree with smaller rank under the 
tree with larger rank. This keeps trees balanced and prevents degeneration 
into linked lists.

# Returns
- `true`: if x and y were in different sets and have been successfully merged
- `false`: if x and y were already in the same set (would create a cycle)

# Example
```julia
uf = UnionFind(4)
union!(uf, 1, 2)  # Returns true: 1 and 2 are now connected
union!(uf, 1, 2)  # Returns false: already in same set
union!(uf, 3, 4)  # Returns true: 3 and 4 are now connected  
union!(uf, 2, 3)  # Returns true: merges {1,2} and {3,4} into {1,2,3,4}
```
"""
function union!(uf::UnionFind, x::Int, y::Int)
    root_x = find(uf, x)
    root_y = find(uf, y)

    if root_x == root_y
        return false  # Already in same set
    end

    # Union by rank: attach shorter tree under taller tree
    if uf.rank[root_x] < uf.rank[root_y]
        uf.parent[root_x] = root_y
    elseif uf.rank[root_x] > uf.rank[root_y]
        uf.parent[root_y] = root_x
    else
        # Same rank: pick one as root and increment its rank
        uf.parent[root_y] = root_x
        uf.rank[root_x] += 1
    end

    return true
end

function parse_network_matrix(filename::String)
    lines = readlines(filename)
    n = length(lines)

    edges = Tuple{Int, Int, Int}[]  # (vertex1, vertex2, weight)
    total_weight = 0

    for (i, line) in enumerate(lines)
        # Remove line numbers and arrow prefix (e.g., "1→")
        clean_line = split(line, "→")[end]
        values = split(clean_line, ',')

        for (j, val) in enumerate(values)
            if j > i && val != "-"  # Only process upper triangle to avoid duplicates
                weight = parse(Int, val)
                push!(edges, (i, j, weight))
                total_weight += weight
            end
        end
    end

    return edges, total_weight, n
end

function minimum_spanning_tree_weight(edges::Vector{Tuple{Int, Int, Int}}, n::Int)
    # Sort edges by weight
    sort!(edges, by = x -> x[3])

    uf = UnionFind(n)
    mst_weight = 0
    edges_added = 0

    for (u, v, weight) in edges
        if union!(uf, u, v)
            mst_weight += weight
            edges_added += 1
            if edges_added == n - 1  # MST has n-1 edges
                break
            end
        end
    end

    return mst_weight
end

function solve()
    data_file = joinpath(@__DIR__, "..", "..", "data", "0107_network.txt")
    edges, total_weight, n = parse_network_matrix(data_file)

    mst_weight = minimum_spanning_tree_weight(edges, n)
    max_saving = total_weight - mst_weight

    @info "Network analysis: $n vertices, $(length(edges)) edges, " *
          "total weight: $total_weight, MST weight: $mst_weight"

    return max_saving
end

end # module
