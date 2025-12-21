# Project Euler Problem 22: Names Scores
# https://www.hackerrank.com/contests/projecteuler/challenges/euler022/problem
#
# Project Euler: https://projecteuler.net/problem=22
# Solution: https://aliramadhan.me/blog/project-euler/problem-0022/
#
# Problem:
#   You are given around five-thousand first names, begin by sorting it into
#   alphabetical order. Then working out the alphabetical value for each name,
#   multiply this value by its alphabetical position in the list to obtain a
#   name score.
#
#   For example, when the list in sample is sorted into alphabetical order,
#   PAMELA, which is worth 16 + 1 + 13 + 5 + 12 + 1 = 48, is the 5th name in
#   the list. So, PAMELA would obtain a score of 5 x 48 = 240.
#
#   You are given Q queries, each query is a name, you have to print the score.
#
# Input Format:
#   First line: N (number of names)
#   Next N lines: a name
#   Next line: Q (number of queries)
#   Next Q lines: a name to query
#
# Constraints:
#   1 <= N <= 5200
#   Length of each word will be less than 12
#   1 <= Q <= 100
#
# Output Format:
#   Print the name score for each query.

function name_value(name)
    return sum(Int(ch) - Int('A') + 1 for ch in name)
end

N = parse(Int, readline())
names = [readline() for _ in 1:N]
sort!(names)

# Build a dictionary mapping name to its score
name_scores = Dict{String, Int}()
for (i, name) in enumerate(names)
    name_scores[name] = i * name_value(name)
end

Q = parse(Int, readline())
for _ in 1:Q
    query = readline()
    println(name_scores[query])
end
