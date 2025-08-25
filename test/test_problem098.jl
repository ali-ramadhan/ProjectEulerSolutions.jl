using ProjectEulerSolutions.Problem098:
    find_anagram_pairs,
    get_letter_mapping,
    apply_mapping,
    is_perfect_square,
    find_square_anagram_pairs,
    solve

# Test anagram pair finding
pairs = find_anagram_pairs(["CARE", "RACE", "DOG", "GOD", "CAT"])
@test length(pairs) == 2
@test ("CARE", "RACE") in pairs || ("RACE", "CARE") in pairs
@test ("DOG", "GOD") in pairs || ("GOD", "DOG") in pairs

# Test perfect square detection
@test is_perfect_square(36)
@test is_perfect_square(1296)
@test is_perfect_square(9216)
@test !is_perfect_square(10)
@test !is_perfect_square(50)

# Test letter mapping for CARE -> 1296
mapping = get_letter_mapping("CARE", "RACE", 1296)
@test mapping !== nothing
@test mapping['C'] == '1'
@test mapping['A'] == '2'
@test mapping['R'] == '9'
@test mapping['E'] == '6'

# Test applying mapping RACE with CARE->1296 mapping should give 9216
@test apply_mapping("RACE", mapping) == 9216

# Test that 9216 is indeed a perfect square (96²)
@test is_perfect_square(9216)
@test Int(sqrt(9216)) == 96

# Test with example from problem: CARE and RACE should produce square numbers
@test find_square_anagram_pairs(["CARE", "RACE"]) >= 9216

# The correct answer for the full problem
@test solve() == 18769
