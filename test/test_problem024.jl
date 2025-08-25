using ProjectEulerSolutions.Problem024: find_nth_permutation, solve

@test find_nth_permutation([0, 1, 2], 1) == [0, 1, 2]
@test find_nth_permutation([0, 1, 2], 2) == [0, 2, 1]
@test find_nth_permutation([0, 1, 2], 3) == [1, 0, 2]
@test find_nth_permutation([0, 1, 2], 4) == [1, 2, 0]
@test find_nth_permutation([0, 1, 2], 5) == [2, 0, 1]
@test find_nth_permutation([0, 1, 2], 6) == [2, 1, 0]

@test find_nth_permutation([0, 1, 2, 3], 1) == [0, 1, 2, 3]
@test find_nth_permutation([0, 1, 2, 3], 24) == [3, 2, 1, 0]  # Last permutation

solution = solve()

@test length(solution) == 10

for d in '0':'9'
    @test count(c -> c == d, solution) == 1
end

@test solution == "2783915460"
