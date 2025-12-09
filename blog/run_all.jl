# Run all benchmark scripts in the blog directory

scripts = filter(readdir(@__DIR__)) do f
    endswith(f, ".jl") && f != "run_all.jl"
end

for script in sort(scripts)
    @info "Running $script"
    include(joinpath(@__DIR__, script))
end
