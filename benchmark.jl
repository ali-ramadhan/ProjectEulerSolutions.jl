using BenchmarkTools
using ProjectEulerSolutions

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
