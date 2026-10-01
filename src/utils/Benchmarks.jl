module Benchmarks

export save_benchmark

using InteractiveUtils: versioninfo
using CUDA: CUDA
using YAML
using Dates
using OrderedCollections: OrderedDict

# CPU name mapping to simplify verbose CPU strings
const CPU_NAME_MAP = Dict(
    "48 × AMD Ryzen Threadripper 7960X 24-Cores" => "AMD Ryzen Threadripper 7960X",
    "24 × AMD Ryzen 9 5900X 12-Core Processor            " => "AMD Ryzen 9 5900X",
    "96 × AMD EPYC 7402 24-Core Processor" => "2 × AMD EPYC 7402",
    "128 × AMD EPYC 9374F 32-Core Processor" => "2 × AMD EPYC 9374F",
    "8 × Intel(R) Core(TM) Ultra 5 238V" => "Intel Core Ultra 5 238V",
    "8 × Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz" => "Intel Core i7-7700HQ",
    "8 × Intel(R) Core(TM) i7-4810MQ CPU @ 2.80GHz" => "Intel Core i7-4810MQ",
    "2 × Intel(R) Core(TM)2 Duo CPU     E7400  @ 2.80GHz" => "Intel Core 2 Duo E7400",
    "4 × AMD Phenom(tm) II X4 970 Processor" => "AMD Phenom II X4 970",
)

# GPU name mapping to simplify the names CUDA reports
const GPU_NAME_MAP = Dict(
    "Tesla V100-PCIE-32GB" => "NVIDIA V100 PCIe 32GB",
    "NVIDIA A100-PCIE-40GB" => "NVIDIA A100 PCIe 40GB",
)

"""
    save_benchmark(result, problem_tag, benchmark_name; thread_count=nothing, gpu=false)

Save a BenchmarkTools result to a YAML file organized by problem tag.
Each problem gets its own YAML file (e.g., `problem-0001-benchmarks.yaml`, `bonus-root13-benchmarks.yaml`)
with multiple benchmark entries. Each benchmark includes timestamp, system information,
and formatted benchmark output with preserved ANSI color codes.

Files are automatically saved to the `benchmarks/benchmark_data/` directory. If the directory doesn't
exist, it will be created.

# Arguments
- `result`: BenchmarkTools.Trial or BenchmarkGroup result
- `problem_tag`: Tag that forms the filename (e.g., "problem-0005", "bonus-root13")
- `benchmark_name`: Name for this benchmark (string)
- `thread_count`: The number of threads a multi-threaded benchmark ran with
- `gpu`: Whether the benchmark ran on the current CUDA device. The result is then saved under the GPU's name instead
  of the CPU's, with the CPU as `host_cpu` and the CUDA runtime, CUDA.jl and NVIDIA driver versions.

# Example
```julia
using BenchmarkTools, ProjectEulerSolutions
result = @benchmark sum(1:1000)
save_benchmark(result, "problem-0001", "optimized")  # Saves to benchmarks/benchmark_data/problem-0001-benchmarks.yaml
save_benchmark(result, "bonus-root13", "v1")         # Saves to benchmarks/benchmark_data/bonus-root13-benchmarks.yaml
```
"""
function save_benchmark(result, problem_tag, benchmark_name; thread_count=nothing, gpu=false)
    display(result)

    # Ensure benchmarks directory exists
    benchmarks_dir = abspath(joinpath(@__DIR__, "..", "..", "benchmarks", "benchmark_data"))
    if !isdir(benchmarks_dir)
        mkpath(benchmarks_dir)
    end

    # Generate filename
    yaml_file = joinpath(benchmarks_dir, "$(problem_tag)-benchmarks.yaml")

    # Get system information
    system_info = get_system_info()

    # Format benchmark output
    io = IOBuffer()
    show(IOContext(io, :color => true), MIME("text/plain"), result)
    output = String(take!(io))
    formatted_output = format_ansi_codes(output)

    # Create benchmark entry (the CPU or GPU is the key, not stored in entry)
    benchmark_entry = OrderedDict{String, Any}(
        "date" => Dates.format(now(), "yyyy-mm-ddTHH:MM:SS.sss"),
        "julia_version" => system_info["julia_version"],
        "os" => system_info["os"],
        "output" => formatted_output
    )

    if !isnothing(thread_count)
        benchmark_entry["thread_count"] = thread_count
    end

    # A GPU result is saved under the GPU, and records the CPU it ran alongside and the CUDA software it used
    processor = system_info["cpu"]
    if gpu
        gpu_info = get_gpu_info()
        processor = gpu_info["gpu"]
        benchmark_entry["host_cpu"] = system_info["cpu"]
        benchmark_entry["cuda_runtime"] = gpu_info["cuda_runtime"]
        benchmark_entry["cuda_jl"] = gpu_info["cuda_jl"]
        benchmark_entry["nvidia_driver"] = gpu_info["nvidia_driver"]
    end

    # Load existing benchmarks or create new OrderedDict
    existing_benchmarks = load_existing_benchmarks(yaml_file)

    # Add new benchmark nested under benchmark_name -> CPU or GPU
    if !haskey(existing_benchmarks, benchmark_name)
        existing_benchmarks[benchmark_name] = OrderedDict{String,Any}()
    end
    existing_benchmarks[benchmark_name][processor] = benchmark_entry

    # Sort keys alphabetically before writing to maintain consistent order
    sorted_benchmarks = sort_benchmark_keys(existing_benchmarks)

    # Save to YAML file
    YAML.write_file(yaml_file, sorted_benchmarks)

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
    cpu_raw = "$(length(cpu_info)) × $(cpu_info[1].model)"
    cpu = get(CPU_NAME_MAP, cpu_raw, cpu_raw)

    return Dict(
        "julia_version" => julia_version,
        "os" => os,
        "cpu" => cpu
    )
end

"""
    get_gpu_info()

The current CUDA device's name, and the CUDA runtime, CUDA.jl and NVIDIA driver versions.
"""
function get_gpu_info()
    gpu_raw = CUDA.name(CUDA.device())
    return Dict(
        "gpu" => get(GPU_NAME_MAP, gpu_raw, gpu_raw),
        "cuda_runtime" => string(CUDA.runtime_version()),
        "cuda_jl" => string(pkgversion(CUDA)),
        "nvidia_driver" => nvidia_driver_version()
    )
end

# The NVIDIA driver version as nvidia-smi shows it, e.g. 535.309.01. NVML.driver_version() parses it into a
# VersionNumber, which drops the zero (535.309.1).
function nvidia_driver_version()
    CUDA.NVML.has_nvml() || return "unknown"
    buffer = Vector{Cchar}(undef, CUDA.NVML.NVML_SYSTEM_DRIVER_VERSION_BUFFER_SIZE)
    CUDA.NVML.nvmlSystemGetDriverVersion(pointer(buffer), length(buffer))
    return GC.@preserve buffer unsafe_string(pointer(buffer))
end

"""
    format_ansi_codes(text)

Convert escape sequences to the expected [XXm format for ANSI color codes.
Removes the ANSI escape character (0x1b) to convert sequences like `\u001b[90m` to `[90m`.
"""
function format_ansi_codes(text)
    # Remove ANSI escape character (0x1b) to get clean [XXm format
    return replace(text, '\x1b' => "")
end

"""
    sort_benchmark_keys(benchmarks)

Sort benchmark dictionary keys alphabetically at both levels:
- Top level: benchmark names
- Second level: CPU or GPU names within each benchmark
Returns a new OrderedDict with sorted keys.
"""
function sort_benchmark_keys(benchmarks::AbstractDict)
    sorted = OrderedDict{String,Any}()
    for name in sort(collect(keys(benchmarks)))
        cpu_dict = benchmarks[name]
        if cpu_dict isa AbstractDict
            sorted[name] = OrderedDict{String,Any}(sort(collect(cpu_dict), by=first))
        else
            sorted[name] = cpu_dict
        end
    end
    return sorted
end

"""
    load_existing_benchmarks(yaml_file)

Load existing benchmarks from a YAML file, or return an empty OrderedDict if file doesn't exist.
Uses OrderedDict to preserve key ordering through round-trips.
"""
function load_existing_benchmarks(yaml_file)
    if isfile(yaml_file)
        try
            data = YAML.load_file(yaml_file; dicttype=OrderedDict{String,Any})
            # YAML.load_file returns nothing for empty files
            return isnothing(data) ? OrderedDict{String,Any}() : data
        catch e
            @warn "Could not load existing benchmarks from $yaml_file: $e"
            return OrderedDict{String,Any}()
        end
    else
        return OrderedDict{String,Any}()
    end
end

end # module Benchmarks
