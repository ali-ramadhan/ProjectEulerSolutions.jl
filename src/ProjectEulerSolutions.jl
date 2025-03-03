module ProjectEulerSolutions

for n in 1:10
    n_padded = lpad(n, 3, '0')
    include("solutions/problem$n_padded.jl")
end

end # module
