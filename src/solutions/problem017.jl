"""
Project Euler Problem 17: Number Letter Counts

If the numbers 1 to 5 are written out in words: one, two, three, four, five,
then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words,
how many letters would be used?

NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two)
contains 23 letters and 115 (one hundred and fifteen) contains 20 letters.
The use of "and" when writing out numbers is in compliance with British usage.
"""
module Problem017

const NUMBER_WORDS = Dict(
    1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five",
    6 => "six", 7 => "seven", 8 => "eight", 9 => "nine", 10 => "ten",
    11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen",
    16 => "sixteen", 17 => "seventeen", 18 => "eighteen", 19 => "nineteen", 20 => "twenty",
    30 => "thirty", 40 => "forty", 50 => "fifty", 60 => "sixty",
    70 => "seventy", 80 => "eighty", 90 => "ninety"
)

"""
    number_to_words(n)

Convert a number to its British English word representation.
Uses the British convention of including 'and' between the hundreds and the rest.
"""
function number_to_words(n)
    if n == 1000
        return "one thousand"
    elseif n >= 100
        hundreds_digit = n ÷ 100
        remainder = n % 100

        if remainder == 0
            return "$(NUMBER_WORDS[hundreds_digit]) hundred"
        else
            return "$(NUMBER_WORDS[hundreds_digit]) hundred and $(number_to_words(remainder))"
        end
    elseif n > 20
        tens = (n ÷ 10) * 10
        ones = n % 10

        if ones == 0
            return NUMBER_WORDS[tens]
        else
            return "$(NUMBER_WORDS[tens])-$(NUMBER_WORDS[ones])"
        end
    else
        return NUMBER_WORDS[n]
    end
end

"""
    count_letters(str)

Count the number of letters in a string, ignoring spaces and hyphens.
"""
function count_letters(str)
    # Filter out spaces and hyphens, then count the remaining characters
    return length(filter(c -> !isspace(c) && c != '-', str))
end

"""
    count_letters_in_range(start, stop)

Count the total number of letters when writing out all numbers from start to stop in words.
"""
function count_letters_in_range(start, stop)
    return sum(count_letters(number_to_words(n)) for n in start:stop)
end

function solve()
    return count_letters_in_range(1, 1000)
end

end # module
