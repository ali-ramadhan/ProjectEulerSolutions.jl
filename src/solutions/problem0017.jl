"""
Project Euler Problem 17: Number Letter Counts

Problem description: https://projecteuler.net/problem=17
Solution description: https://aliramadhan.me/blog/project-euler/problem-0017/
"""
module Problem0017

export NUMBER_WORDS, number_to_words, count_letters, count_letters_in_range, solve

const NUMBER_WORDS = Dict(
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety",
)

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

function count_letters(str)
    return length(filter(c -> !isspace(c) && c != '-', str))
end

function count_letters_in_range(start, stop)
    return sum(count_letters(number_to_words(n)) for n in start:stop)
end

function solve()
    return count_letters_in_range(1, 1000)
end

end # module
