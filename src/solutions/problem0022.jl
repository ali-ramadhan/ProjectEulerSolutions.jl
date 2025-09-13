"""
Project Euler Problem 22: Names Scores

Using names.txt, a 46K text file containing over five-thousand first names, begin by sorting
it into alphabetical order. Then working out the alphabetical value for each name, multiply
this value by its alphabetical position in the list to obtain a name score.

For example, when the list is sorted into alphabetical order, COLIN, which is worth
3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain
a score of 938 × 53 = 49714.

What is the total of all the name scores in the file?

## Solution approach

1. Read and parse the names file, removing quotes and splitting by commas
2. Sort the names alphabetically
3. For each name, calculate its alphabetical value (A=1, B=2, ..., Z=26)
4. Multiply the alphabetical value by the position in the sorted list
5. Sum all the name scores

## Complexity analysis

Time complexity: O(n log n + m)
- Sorting the names takes O(n log n) where n is the number of names
- Computing name scores takes O(m) where m is the total number of characters in all names

Space complexity: O(n + m)
- We store the sorted array of names (O(n) names, O(m) total characters)
"""
module Problem0022

"""
    parse_names(content)

Parse the names from the given content string. The format is expected to be
a comma-separated list of names in double quotes.
"""
function parse_names(content)
    names = [replace(name, "\"" => "") for name in split(content, ",")]
    return sort(names)
end

"""
    name_value(name)

Calculate the alphabetical value of a name.
A=1, B=2, ..., Z=26
"""
function name_value(name)
    return sum(ch - 'A' + 1 for ch in name)
end

"""
    compute_name_scores(names)

Compute the score for each name and return the total sum.
The score for a name is its position in the sorted list multiplied by its alphabetical value.
"""
function compute_name_scores(names)
    total_score = 0
    for (i, name) in enumerate(names)
        name_score = i * name_value(name)
        total_score += name_score
    end
    return total_score
end

function solve()
    data_filepath = joinpath(@__DIR__, "..", "..", "data", "0022_names.txt")
    content = read(data_filepath, String)
    names = parse_names(content)
    return compute_name_scores(names)
end

end # module
