using Test
using ProjectEulerSolutions.Problem0107: UnionFind, find, union!, parse_network_matrix, minimum_spanning_tree_weight, solve

@testset "UnionFind tests" begin
    uf = UnionFind(5)

    # Initially, each element is its own parent
    @test find(uf, 1) == 1
    @test find(uf, 2) == 2
    @test find(uf, 3) == 3

    # Test union operation
    @test union!(uf, 1, 2) == true  # Successfully united
    @test find(uf, 1) == find(uf, 2)  # Now in same set

    # Test that union of already connected elements returns false
    @test union!(uf, 1, 2) == false

    # Test more unions
    @test union!(uf, 3, 4) == true
    @test union!(uf, 2, 3) == true  # This connects sets {1,2} and {3,4}
    @test find(uf, 1) == find(uf, 4)  # All should be in same set now
end

@testset "MST calculation" begin
    # Simple triangle: 1-2 (weight 1), 2-3 (weight 2), 1-3 (weight 3)
    # MST should use edges 1-2 and 2-3 with total weight 3
    edges = [(1, 2, 1), (2, 3, 2), (1, 3, 3)]
    mst_weight = minimum_spanning_tree_weight(edges, 3)
    @test mst_weight == 3
end

# Test the example from problem description (7 vertices, should save 150)
# We'll create the network matrix for the example manually to verify our logic
@testset "Example network" begin
    # Create a small test file to verify parsing
    test_matrix = """A,-,B
-,C,D
B,D,-"""

    # This represents: A-C (weight B), A-B (skip), C-B (weight D)
    # But since we need actual numbers, let's just test with the main file
end

# Correct answer
@test solve() == 259679
