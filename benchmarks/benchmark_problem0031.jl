using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0031

const UK_COINS = [1, 2, 5, 10, 20, 50, 100, 200]
const US_COINS = [1, 5, 10, 25, 50, 100]

@show count_coin_combinations(200, UK_COINS)
b = @benchmark count_coin_combinations(200, $UK_COINS)
save_benchmark(b, "problem-0031", "uk_200p")

@show count_coin_combinations(1000, UK_COINS)
b = @benchmark count_coin_combinations(1000, $UK_COINS)
save_benchmark(b, "problem-0031", "uk_1000p")

@show count_coin_combinations(200, US_COINS)
b = @benchmark count_coin_combinations(200, $US_COINS)
save_benchmark(b, "problem-0031", "us_200c")

@show count_coin_combinations(1000, US_COINS)
b = @benchmark count_coin_combinations(1000, $US_COINS)
save_benchmark(b, "problem-0031", "us_1000c")
