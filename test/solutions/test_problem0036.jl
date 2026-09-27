using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0036: find_double_base_palindromes_naive, find_double_base_palindromes, solve

# HackerRank sample: the binary palindromes below 10 are 0, 1, 3, 5, 7 and 9, which sum to 25
@test find_double_base_palindromes(10, 2) == [0, 1, 3, 5, 7, 9]

# 0 is a palindrome in every base, so it's the only one below 1, and nothing is below 0
@test all(find_double_base_palindromes(1, K) == [0] for K in 2:9)
@test isempty(find_double_base_palindromes(0, 2))

# 585 = 1001001001 in binary from the problem statement, and the bound is exclusive
@test 585 ∈ find_double_base_palindromes(586, 2)
@test 585 ∉ find_double_base_palindromes(585, 2)

# The numbers below 10,000 that are palindromes in base 10 and base K, as listed by OEIS
oeis_terms = [
    2 => [0, 1, 3, 5, 7, 9, 33, 99, 313, 585, 717, 7447, 9009],                           # https://oeis.org/A007632
    3 => [0, 1, 2, 4, 8, 121, 151, 212, 242, 484, 656, 757],                              # https://oeis.org/A007633
    4 => [0, 1, 2, 3, 5, 55, 373, 393, 666, 787, 939, 7997],                              # https://oeis.org/A029961
    5 => [0, 1, 2, 3, 4, 6, 88, 252, 282, 626, 676, 1221],                                # https://oeis.org/A029962
    6 => [0, 1, 2, 3, 4, 5, 7, 55, 111, 141, 191, 343, 434, 777, 868, 1441, 7667, 7777],  # https://oeis.org/A029963
    7 => [0, 1, 2, 3, 4, 5, 6, 8, 121, 171, 242, 292],                                    # https://oeis.org/A029964
    8 => [0, 1, 2, 3, 4, 5, 6, 7, 9, 121, 292, 333, 373, 414, 585, 3663, 8778],           # https://oeis.org/A029804
    9 => [0, 1, 2, 3, 4, 5, 6, 7, 8, 191, 282, 373, 464, 555, 646, 656, 6886],            # https://oeis.org/A029965
]
for (K, terms) in oeis_terms
    @test find_double_base_palindromes(10_000, K) == terms
end

# Agrees with checking every number in every base the HackerRank version asks about, also when N cuts a length short
for K in 2:9, N in (10, 100, 12_345, 10^5, 10^6)
    @test find_double_base_palindromes(N, K) == find_double_base_palindromes_naive(N, K)
end

# Correct answer
@test_answer solve() "0036"
