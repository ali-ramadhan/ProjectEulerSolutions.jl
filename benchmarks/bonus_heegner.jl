using Logging
using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.BonusHeegner: find_closest_cos_to_integer

Logging.disable_logging(Logging.Info)

@show find_closest_cos_to_integer(1000)
b = @benchmark find_closest_cos_to_integer(1000)
save_benchmark(b, "bonus-heegner", "n_1k")

@show find_closest_cos_to_integer(1000000)
b = @benchmark find_closest_cos_to_integer(1000000) samples=5 evals=1 seconds=1000
save_benchmark(b, "bonus-heegner", "n_1M")
