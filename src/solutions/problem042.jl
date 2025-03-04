"""
Project Euler Problem 42: Coded Triangle Numbers

The nth term of the sequence of triangle numbers is given by, t_n = ½n(n+1);
so the first ten triangle numbers are:
1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

By converting each letter in a word to a number corresponding to its alphabetical position
and adding these values we form a word value. For example, the word value for SKY is
19 + 11 + 25 = 55 = t_10. If the word value is a triangle number then we shall call the word
a triangle word.

Using words.txt, a 16K text file containing nearly two-thousand common English words,
how many are triangle words?
"""
module Problem042

"""
    is_triangle_number(n)

Check if a number is a triangle number using the formula t_n = n(n+1)/2.
A number is a triangle number if (-1 + sqrt(1 + 8n))/2 is a positive integer.
"""
function is_triangle_number(n)
    x = (sqrt(1 + 8 * n) - 1) / 2
    return isinteger(x)
end

"""
    word_value(word)

Calculate the value of a word by summing the alphabetical positions of its letters.
A=1, B=2, ..., Z=26
"""
function word_value(word)
    return sum(Int(c) - Int('A') + 1 for c in word)
end

"""
    count_triangle_words(words)

Count the number of triangle words in a list of words.
A triangle word is a word whose value is a triangle number.
"""
function count_triangle_words(words)
    triangle_count = 0

    for word in words
        value = word_value(word)
        if is_triangle_number(value)
            triangle_count += 1
        end
    end

    return triangle_count
end

"""
    parse_words_file(filename)

Parse the words.txt file and return a list of words.
The file contains words in quotes, separated by commas.
"""
function parse_words_file(filename)
    content = read(filename, String)
    words = [replace(w, "\"" => "") for w in split(content, ",")]
    return words
end

function solve()
    data_filepath = joinpath(@__DIR__, "..", "..", "data", "0042_words.txt")
    words = parse_words_file(data_filepath)
    return count_triangle_words(words)
end

end # module
