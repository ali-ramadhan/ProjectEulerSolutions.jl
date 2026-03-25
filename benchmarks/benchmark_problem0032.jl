using BenchmarkTools
using ProjectEulerSolutions.Utils.Benchmarks
using ProjectEulerSolutions.Problem0032: find_pandigital_products

@show find_pandigital_products(4)
b = @benchmark find_pandigital_products(4)
save_benchmark(b, "problem-0032", "pandigital_4")

@show find_pandigital_products(5)
b = @benchmark find_pandigital_products(5)
save_benchmark(b, "problem-0032", "pandigital_5")

@show find_pandigital_products(6)
b = @benchmark find_pandigital_products(6)
save_benchmark(b, "problem-0032", "pandigital_6")

@show find_pandigital_products(7)
b = @benchmark find_pandigital_products(7)
save_benchmark(b, "problem-0032", "pandigital_7")

@show find_pandigital_products(8)
b = @benchmark find_pandigital_products(8)
save_benchmark(b, "problem-0032", "pandigital_8")

@show find_pandigital_products(9)
b = @benchmark find_pandigital_products(9)
save_benchmark(b, "problem-0032", "pandigital_9")
