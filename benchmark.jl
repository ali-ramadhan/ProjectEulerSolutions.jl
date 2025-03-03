using BenchmarkTools
using ProjectEulerSolutions

function benchmark_all_problems()
    # Get a list of all module methods that match our naming pattern
    problem_modules = []
    for name in names(ProjectEulerSolutions; all=true)
        module_name = string(name)
        if startswith(module_name, "Problem") && all(isdigit, module_name[8:end])
            push!(problem_modules, name)
        end
    end
    
    sort!(problem_modules, by=x -> parse(Int, string(x)[8:end]))
    
    for problem in problem_modules
        problem_mod = getfield(ProjectEulerSolutions, problem)
        problem_num = string(problem)[8:end]
        
        # Run the benchmark
        print("Problem $problem_num: ")
        @btime $problem_mod.solve()
    end
end

benchmark_all_problems()
