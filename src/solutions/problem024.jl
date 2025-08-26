"""
Project Euler Problem 24: Lexicographic Permutations

A permutation is an ordered arrangement of objects. For example, 3124 is one possible
permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically
or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1
and 2 are:

012   021   102   120   201   210

What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and
9?

## Solution approach

Instead of generating all permutations, we use the factorial number system to directly
compute the nth permutation:
1. For n elements, permutations are grouped into n sets of (n-1)! permutations each
2. Determine which group contains the target by dividing by (n-1)!
3. Select the corresponding element and remove it from the available elements
4. Repeat for the remaining elements with the remainder

This avoids generating and sorting all 10! = 3,628,800 permutations.

## Complexity analysis

Time complexity: O(n²)
- We iterate through n positions (digits 0-9, so n=10)
- For each position, we remove an element from the list which takes O(n) time
- Computing factorials takes constant time for small n

Space complexity: O(n)
- We store a copy of the elements and the result permutation
"""
module Problem024

"""
    find_nth_permutation(elements, n)

Find the nth lexicographic permutation of a collection of elements without generating
all possible permutations.
"""
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
