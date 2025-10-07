"""
Project Euler Problem 98: Anagramic Squares

By replacing each of the letters in the word CARE with 1, 2, 9, and 6 respectively, we form a square number: 1296 = 36². What is remarkable is that, by using the same digital substitution, the anagram RACE also forms a square number: 9216 = 96². We shall call CARE (and RACE) a square anagram word pair and specify further that leading zeros are not permitted, neither may a different letter have the same digital value as another letter.

Using words.txt, a 16K text file containing nearly two-thousand common English words, find all the square anagram word pairs (a palindromic word is NOT considered to be an anagram of itself).

What is the largest square number formed by any member of such a pair?
"""
module Problem0098

"""
    find_anagram_pairs(words)

Find all pairs of words that are anagrams of each other.
"""
function find_anagram_pairs(words)
    anagram_groups = Dict{String, Vector{String}}()

    for word in words
        sorted_chars = String(sort(collect(word)))
        if haskey(anagram_groups, sorted_chars)
            push!(anagram_groups[sorted_chars], word)
        else
            anagram_groups[sorted_chars] = [word]
        end
    end

    pairs = Vector{Tuple{String, String}}()
    for group in values(anagram_groups)
        if length(group) >= 2
            for i in 1:length(group)
                for j in (i + 1):length(group)
                    push!(pairs, (group[i], group[j]))
                end
            end
        end
    end

    return pairs
end

"""
    get_letter_mapping(word1, word2, number)

Try to create a letter-to-digit mapping where word1 maps to the given number.
Returns the mapping dictionary if valid, nothing otherwise.
"""
function get_letter_mapping(word1, word2, number)
    num_str = string(number)
    if length(word1) != length(num_str)
        return nothing
    end

    letter_to_digit = Dict{Char, Char}()
    digit_to_letter = Dict{Char, Char}()

    for i in 1:length(word1)
        letter = word1[i]
        digit = num_str[i]

        if haskey(letter_to_digit, letter)
            if letter_to_digit[letter] != digit
                return nothing
            end
        else
            if haskey(digit_to_letter, digit)
                return nothing
            end
            letter_to_digit[letter] = digit
            digit_to_letter[digit] = letter
        end
    end

    return letter_to_digit
end

"""
    apply_mapping(word, mapping)

Apply the letter-to-digit mapping to a word to get a number.
Returns nothing if the result would have a leading zero.
"""
function apply_mapping(word, mapping)
    if !haskey(mapping, word[1])
        return nothing
    end

    if mapping[word[1]] == '0'
        return nothing
    end

    result = ""
    for char in word
        if !haskey(mapping, char)
            return nothing
        end
        result *= mapping[char]
    end

    return parse(Int, result)
end

"""
    find_square_anagram_pairs(words)

Find all square anagram word pairs and return the largest square number.
"""
function find_square_anagram_pairs(words)
    anagram_pairs = find_anagram_pairs(words)
    max_square = 0

    for (word1, word2) in anagram_pairs
        word_length = length(word1)

        min_square = Int(ceil(sqrt(10^(word_length - 1))))
        max_square_limit = Int(floor(sqrt(10^word_length - 1)))

        for n in min_square:max_square_limit
            square = n * n
            mapping = get_letter_mapping(word1, word2, square)

            if mapping !== nothing
                mapped_number = apply_mapping(word2, mapping)

                if mapped_number !== nothing && ispow2(mapped_number)
                    max_square = max(max_square, square, mapped_number)
                end
            end
        end
    end

    return max_square
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
    data_filepath = joinpath(@__DIR__, "..", "..", "data", "0098_words.txt")
    words = parse_words_file(data_filepath)
    return find_square_anagram_pairs(words)
end

end # module
