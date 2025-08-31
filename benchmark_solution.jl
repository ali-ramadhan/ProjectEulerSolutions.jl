using Logging
using BenchmarkTools
using ProjectEulerSolutions

function main()
    if length(ARGS) != 1
        println("Usage: julia benchmark_solution.jl <problem_number>")
        exit(1)
    end

    problem_num = parse(Int, ARGS[1])
    problem_module_name = Symbol("Problem$problem_num")

    try
        problem_module = getproperty(ProjectEulerSolutions, problem_module_name)
        solve_func = getproperty(problem_module, :solve)

        Logging.disable_logging(Logging.Info)
        result = @benchmark $solve_func()

        display(result)
    catch e
        println("Error: Could not load Problem$problem_num or its solve function")
        println("Make sure the problem solution exists and is properly implemented")
        exit(1)
    end
end

main()
