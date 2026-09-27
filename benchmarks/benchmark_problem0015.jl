using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0015

# Arguments go in as $(Ref(x))[] so the compiler can't compute the result at compile time

@show count_lattice_paths(20, 20)
b_20x20 = @benchmark count_lattice_paths($(Ref(20))[], $(Ref(20))[])
save_benchmark(b_20x20, "problem-0015", "count_lattice_paths_20x20")
