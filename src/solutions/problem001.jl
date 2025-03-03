"""
Project Euler problem 1: Multiples of 3 or 5

If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9.
The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000.
"""
module Problem001

"""
    sum_multiples(factors, limit)

Calculate the sum of all numbers below `limit` that are multiples of any number in `factors`.
"""
function sum_multiples(factors, limit)
    multiples = Set{Int}()
    
    for factor in factors
        for n in factor:factor:(limit-1)
            push!(multiples, n)
        end
    end
    
    return sum(multiples)
end

function solve()
    return sum_multiples([3, 5], 1000)
end

end # module