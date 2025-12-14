"""
Project Euler Problem 5: Smallest Multiple

Problem description: https://projecteuler.net/problem=5
Solution description: https://aliramadhan.me/blog/project-euler/problem-0005/
"""
module Problem0005

function smallest_multiple(n)
    result = 1
    for i in 2:n
        result = lcm(result, i)
    end
    return result
end

function solve()
    return smallest_multiple(20)
end

end # module
