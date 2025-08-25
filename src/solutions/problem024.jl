"""
Project Euler Problem 24: Lexicographic Permutations

A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation
of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically,
we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

012   021   102   120   201   210

What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
"""
module Problem024

"""
    find_nth_permutation(elements, n)

Find the nth lexicographic permutation of a collection of elements without generating
all possible permutations.

Algorithm:

  - Uses the factorial number system to directly calculate which element goes in each position
  - For n elements, the permutations can be divided into n groups of (n-1)! permutations each
  - We determine which group contains our target permutation to select each element

Example: Finding the 10th permutation of [0, 1, 2, 3]

 1. First digit: With 3! = 6 permutations per first digit

      + 9 ÷ 6 = 1 with remainder 3, so select elements[1] = 1
      + Result so far: [1], remaining: [0, 2, 3], remainder: 3

 2. Second digit: With 2! = 2 permutations per second digit

      + 3 ÷ 2 = 1 with remainder 1, so select elements[1] = 2
      + Result so far: [1, 2], remaining: [0, 3], remainder: 1
 3. Third digit: With 1! = 1 permutation per third digit

      + 1 ÷ 1 = 1 with remainder 0, so select elements[1] = 3
      + Result so far: [1, 2, 3], remaining: [0]
 4. Last digit: Only one possibility: 0

      + Final result: [1, 2, 3, 0]
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
