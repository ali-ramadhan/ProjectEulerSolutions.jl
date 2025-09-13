module Benchmarks

export save_benchmark

using InteractiveUtils: versioninfo
using YAML
using Dates

"""
    save_benchmark(result, problem_number, benchmark_name)

Save a BenchmarkTools result to a YAML file organized by problem number.
Each problem gets its own YAML file (e.g., `problem0001.yaml`) with multiple
benchmark entries. Each benchmark includes timestamp, system information,
and formatted benchmark output with preserved ANSI color codes.

Files are automatically saved to the `benchmarks/` directory. If the directory doesn't
exist, it will be created.

# Arguments
- `result`: BenchmarkTools.Trial or BenchmarkGroup result
- `problem_number`: Problem number (integer)
- `benchmark_name`: Name for this benchmark (string)

# Example
```julia
using BenchmarkTools, ProjectEulerSolutions
result = @benchmark sum(1:1000)
save_benchmark(result, 1, "optimized")  # Saves to benchmarks/problem0001.yaml
```
"""
function save_benchmark(result, problem_number, benchmark_name)
    display(result)

    # Ensure benchmarks directory exists
    benchmarks_dir = realpath(joinpath(@__DIR__, "..", "..", "benchmarks"))
    if !isdir(benchmarks_dir)
        mkpath(benchmarks_dir)
    end

    # Generate filename
    problem_str = lpad(string(problem_number), 4, '0')
    yaml_file = joinpath(benchmarks_dir, "problem$(problem_str).yaml")

    # Get system information
    system_info = get_system_info()

    # Format benchmark output
    io = IOBuffer()
    show(IOContext(io, :color => true), MIME("text/plain"), result)
    output = String(take!(io))
    formatted_output = format_ansi_codes(output)

    # Create benchmark entry
    benchmark_entry = Dict(
        "date" => Dates.format(now(), "yyyy-mm-ddTHH:MM:SS.sss"),
        "julia_version" => system_info["julia_version"],
        "os" => system_info["os"],
        "cpu" => system_info["cpu"],
        "output" => formatted_output
    )

    # Load existing benchmarks or create new dict
    existing_benchmarks = load_existing_benchmarks(yaml_file)

    # Add new benchmark
    existing_benchmarks[benchmark_name] = benchmark_entry

    # Save to YAML file
    YAML.write_file(yaml_file, existing_benchmarks)

    @info "Benchmark saved to $yaml_file under '$benchmark_name'"
end


"""
    get_system_info()

Extract system information including Julia version, OS, and CPU details.
Uses direct system calls for efficiency instead of parsing versioninfo output.
"""
function get_system_info()
    # Julia version - directly from VERSION constant
    julia_version = "Julia $VERSION"

    # OS - using direct system calls like versioninfo does
    os = if Sys.iswindows()
        "Windows"
    elseif Sys.isapple()
        "macOS"
    else
        String(Sys.KERNEL)  # "Linux" etc.
    end

    # CPU - using direct system call like versioninfo does
    cpu_info = Sys.cpu_info()
    cpu = "$(length(cpu_info)) × $(cpu_info[1].model)"

    return Dict(
        "julia_version" => julia_version,
        "os" => os,
        "cpu" => cpu
    )
end

"""
    format_ansi_codes(text)

Convert escape sequences to the expected [XXm format for ANSI color codes.
"""
function format_ansi_codes(text)
    # Replace escape sequences (\e) with empty string, but preserve the color codes in [XXm format
    # The original code was doing: replace(output, "\\e" => "")
    # We need to preserve the ANSI codes but in [XXm format
    return replace(text, "\\e" => "")
end

"""
    load_existing_benchmarks(yaml_file)

Load existing benchmarks from a YAML file, or return an empty dict if file doesn't exist.
"""
function load_existing_benchmarks(yaml_file)
    if isfile(yaml_file)
        try
            return YAML.load_file(yaml_file)
        catch e
            @warn "Could not load existing benchmarks from $yaml_file: $e"
            return Dict()
        end
    else
        return Dict()
    end
end

end # module Benchmarks
