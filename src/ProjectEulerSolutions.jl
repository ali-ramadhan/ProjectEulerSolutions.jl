module ProjectEulerSolutions

for n in 1:14
    n_padded = lpad(n, 3, '0')
    include("solutions/problem$n_padded.jl")
end

end # module
