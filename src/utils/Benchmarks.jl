module Benchmarks

export save_benchmark

using InteractiveUtils: versioninfo

"""
    save_benchmark(result, filename)

Save a BenchmarkTools result to a text file with ANSI color codes stripped of escape
characters. The output is compatible with YAML and web parsers that expect ANSI codes in
`[36m` format. Also includes Julia version information at the end.

Files are automatically saved to the `benchmarks/` directory. If the directory doesn't
exist, it will be created.

# Arguments
- `result`: BenchmarkTools.Trial or BenchmarkGroup result
- `filename`: Output filename (string) - will be saved in benchmarks/ directory

# Example
```julia
using BenchmarkTools, ProjectEulerSolutions
result = @benchmark sum(1:1000)
save_benchmark(result, "benchmark_output.txt")  # Saves to benchmarks/benchmark_output.txt
```
"""
function save_benchmark(result, filename)
    display(result)

    # Ensure benchmarks directory exists and construct full path
    benchmarks_dir = joinpath(@__DIR__, "..", "..", "benchmarks")
    if !isdir(benchmarks_dir)
        mkpath(benchmarks_dir)
    end
    
    # If filename is not an absolute path, save to benchmarks directory
    full_path = if isabspath(filename)
        filename
    else
        joinpath(benchmarks_dir, filename)
    end

    io = IOBuffer()
    show(IOContext(io, :color => true), MIME("text/plain"), result)
    output = String(take!(io))
    output = replace(output, "\e" => "")

    version_io = IOBuffer()
    versioninfo(version_io)
    version_output = String(take!(version_io))
    version_output = replace(version_output, "\e" => "")

    open(full_path, "w") do f
        write(f, "versioninfo():\n")
        write(f, version_output)
        write(f, "\nBenchmark:\n")
        write(f, output)
    end
end

end # module Benchmarks
