"""
Project Euler Problem 22: Names Scores

Problem description: https://projecteuler.net/problem=22
Solution description: https://aliramadhan.me/blog/project-euler/problem-0022/
"""
module Problem0022

function parse_names(content)
    names = [replace(name, "\"" => "") for name in split(content, ",")]
    return sort(names)
end

function name_value(name)
    return sum(ch - 'A' + 1 for ch in name)
end

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
