# Aqua.jl quality checks: stale and compat-less dependencies, method ambiguities, unbound type parameters,
# undefined exports, type piracy and more. Aqua is a test-only dependency, so run this through Pkg:
# `julia --project=. -e 'using Pkg; Pkg.test(test_args=["aqua"])'`
using Test
using Aqua
import CUDA
using ProjectEulerSolutions

@testset "Aqua" begin
    Aqua.test_all(
        ProjectEulerSolutions;
        # Only used by the test and benchmark scripts, so never loaded by the package itself
        stale_deps = (ignore = [:BenchmarkTools, :SafeTestsets],),
        # This check loads the package in an environment built from each dependency's own Project.toml.
        # CUDA_Runtime_jll's doesn't list CUDA_Compiler_jll, which it loads when it finds a CUDA driver (the
        # registry does list it), so loading fails there on a machine with a GPU. Once that's fixed upstream
        # this becomes an unexpected pass on such a machine and the flag can go.
        persistent_tasks = (broken = CUDA.functional(),),
    )
end
