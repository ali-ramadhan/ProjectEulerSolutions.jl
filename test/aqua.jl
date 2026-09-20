# Aqua.jl quality checks: stale and compat-less dependencies, method ambiguities, unbound type parameters,
# undefined exports, type piracy and more. Aqua is a test-only dependency, so run this through Pkg:
# `julia --project=. -e 'using Pkg; Pkg.test(test_args=["aqua"])'`
using Test
using Aqua
using ProjectEulerSolutions

@testset "Aqua" begin
    Aqua.test_all(
        ProjectEulerSolutions;
        # Only used by the test and benchmark scripts, so never loaded by the package itself
        stale_deps = (ignore = [:BenchmarkTools, :SafeTestsets],),
    )
end
