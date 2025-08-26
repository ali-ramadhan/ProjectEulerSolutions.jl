using BenchmarkTools
using ProjectEulerSolutions
using Statistics
using Dates

function benchmark_problem(problem_num)
    problem_num = lpad(problem_num, 3, '0')
    module_name = Symbol("Problem$problem_num")

    if module_name ∈ names(ProjectEulerSolutions; all = true)
        problem_mod = getfield(ProjectEulerSolutions, module_name)

        print("Problem $problem_num: ")
        @btime $problem_mod.solve()
        return true
    else
        println("Problem$problem_num not found in ProjectEulerSolutions")
        return false
    end
end

function benchmark_all_problems()
    # Get a list of all implemented problem numbers
    problem_modules = []
    for name in names(ProjectEulerSolutions; all = true)
        module_name = string(name)
        if startswith(module_name, "Problem") &&
           length(module_name) >= 8 &&
           all(isdigit, module_name[8:end])
            push!(problem_modules, parse(Int, module_name[8:end]))
        end
    end

    sort!(problem_modules)

    for problem_num in problem_modules
        benchmark_problem(problem_num)
    end
end

function format_time(nanoseconds)
    if nanoseconds < 1000
        return "$(round(nanoseconds, digits=1)) ns"
    elseif nanoseconds < 1_000_000
        return "$(round(nanoseconds / 1000, digits=1)) μs"
    elseif nanoseconds < 1_000_000_000
        return "$(round(nanoseconds / 1_000_000, digits=1)) ms"
    else
        return "$(round(nanoseconds / 1_000_000_000, digits=2)) s"
    end
end

function benchmark_and_update_readme()
    # Get a list of all implemented problem numbers
    problem_modules = []
    for name in names(ProjectEulerSolutions; all = true)
        module_name = string(name)
        if startswith(module_name, "Problem") &&
           length(module_name) >= 8 &&
           all(isdigit, module_name[8:end])
            push!(problem_modules, parse(Int, module_name[8:end]))
        end
    end

    sort!(problem_modules)

    # Benchmark each problem and collect results
    results = []
    for problem_num in problem_modules
        problem_num_str = lpad(problem_num, 3, '0')
        module_name = Symbol("Problem$problem_num_str")

        if module_name ∈ names(ProjectEulerSolutions; all = true)
            problem_mod = getfield(ProjectEulerSolutions, module_name)

            print("Benchmarking Problem $problem_num_str... ")
            benchmark_result = @benchmark $problem_mod.solve()
            median_time = median(benchmark_result).time
            formatted_time = format_time(median_time)
            println(formatted_time)

            push!(results, (problem_num, formatted_time))
        end
    end

    # Generate markdown table
    timestamp = now()
    markdown_content = """
## Performance benchmarks

Last updated: $timestamp

| Problem | Median Time |
|---------|-------------|
"""

    for (problem_num, time) in results
        problem_str = lpad(problem_num, 3, '0')
        time_str = rpad(time, 11)  # Pad to match "Median Time" column width
        markdown_content *= "| $problem_str     | $time_str |\n"
    end

    # Read current README content
    readme_path = "README.md"
    current_content = read(readme_path, String)

    # Find and replace the benchmark section, or append if not found
    benchmark_section_start = findfirst("## Performance benchmarks", current_content)
    if benchmark_section_start !== nothing
        # Find the next section or end of file
        remaining_content = current_content[benchmark_section_start[1]:end]
        next_section = findnext(r"\n## [^B]", remaining_content, 1)

        if next_section !== nothing
            # Replace the benchmark section
            before_benchmark = current_content[1:(benchmark_section_start[1] - 1)]
            after_benchmark = remaining_content[next_section[1]:end]
            new_content = before_benchmark * markdown_content * after_benchmark
        else
            # Benchmark section is at the end, replace everything after it
            before_benchmark = current_content[1:(benchmark_section_start[1] - 1)]
            new_content = before_benchmark * markdown_content
        end
    else
        # Append benchmark section at the end
        new_content = current_content * "\n" * markdown_content
    end

    # Write updated content back to README
    write(readme_path, new_content)

    println("\nBenchmark results updated in README.md")
    return results
end
