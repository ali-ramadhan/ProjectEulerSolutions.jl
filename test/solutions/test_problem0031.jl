using Test
using ProjectEulerSolutions.Utils.AnswerHashing
using ProjectEulerSolutions.Problem0031

const UK_COINS = [1, 2, 5, 10, 20, 50, 100, 200]

# Edge cases
@test count_coin_combinations(0, UK_COINS) == 1  # One way to make 0: use no coins
@test count_coin_combinations(1, UK_COINS) == 1  # Only 1p
@test count_coin_combinations(2, UK_COINS) == 2  # 2p or 1p+1p

# From the problem description
@test count_coin_combinations(5, UK_COINS) == 4   # 5p, 2p+2p+1p, 2p+1p+1p+1p, 1p×5

# Correct answer
@test_answer solve() "0031"
