using ProjectEulerSolutions.Problem074: digit_factorial_sum, chain_length, solve

# Test digit factorial sums
@test digit_factorial_sum(145) == 145
@test digit_factorial_sum(69) == 363600
@test digit_factorial_sum(78) == 45360
@test digit_factorial_sum(540) == 145

# Test chain lengths
next_cache = Dict{Int, Int}()
length_cache = Dict{Int, Int}()

@test chain_length(69, next_cache, length_cache) == 5
@test chain_length(78, next_cache, length_cache) == 4
@test chain_length(540, next_cache, length_cache) == 2
@test chain_length(169, next_cache, length_cache) == 3
@test chain_length(871, next_cache, length_cache) == 2
@test chain_length(872, next_cache, length_cache) == 2
@test chain_length(145, next_cache, length_cache) == 1

@test solve() == 402
