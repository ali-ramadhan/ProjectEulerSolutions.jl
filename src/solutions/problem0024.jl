"""
Project Euler Problem 24: Lexicographic Permutations

Problem description: https://projecteuler.net/problem=24
Solution description: https://aliramadhan.me/blog/project-euler/problem-0024/
"""
module Problem0024

function find_nth_permutation(elements, n)
    elements = deepcopy(collect(elements))

    # Convert to 0-based indexing
    n = n - 1

    result = similar(elements, 0)

    for i in length(elements):-1:1
        fact = factorial(i-1)

        idx = n ÷ fact + 1
        push!(result, elements[idx])

        deleteat!(elements, idx)

        n = n % fact
    end

    return result
end

function solve()
    digits = 0:9
    perm = find_nth_permutation(digits, 1_000_000)
    return join(string.(perm))
end

end # module
