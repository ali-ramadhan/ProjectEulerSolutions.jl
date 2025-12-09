using BenchmarkTools
using ProjectEulerSolutions.Utils: save_benchmark
using ProjectEulerSolutions.Problem0009: find_pythagorean_triplets

for n in (1000, 1000000, 1234567890)
    @show n, find_pythagorean_triplets(n)
    benchmark = @benchmark find_pythagorean_triplets($n) samples=100 seconds=1000
    save_benchmark(benchmark, "problem-0009", "n_$n")
end

