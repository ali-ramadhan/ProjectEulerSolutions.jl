using ProjectEulerSolutions.Problem0084:
    community_chest, chance, simulate_monopoly, get_modal_string, solve

# Test modal string formatting with known visit counts
test_counts = zeros(Int, 40)
test_counts[11] = 1000  # JAIL (square 10)
test_counts[25] = 800   # E3 (square 24)
test_counts[1] = 600    # GO (square 0)
@test get_modal_string(test_counts) == "102400"

# Run simulation with 4-sided dice and test properties
counts_4sided = simulate_monopoly(500000, 4)

@test length(counts_4sided) == 40
@test all(c >= 0 for c in counts_4sided)
@test sum(counts_4sided) == 500000
@test counts_4sided[31] == 0  # G2J (square 30) should have zero visits
@test length(unique(counts_4sided)) > 1  # Not all squares equally visited
@test counts_4sided[11] == maximum(counts_4sided)  # JAIL most visited

# Test 6-sided dice produces known result with enough rolls
counts_6sided = simulate_monopoly(20_000_000, 6)
@test get_modal_string(counts_6sided) == "102400"

# Test correct solution
@test solve() == "101524"
