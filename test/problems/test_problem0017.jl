using Test
using ProjectEulerSolutions.Utils.AnswerHashing: @test_answer
using ProjectEulerSolutions.Problem0017:
    number_to_words, count_letters, count_letters_in_range, solve

@test count_letters(number_to_words(342)) == 23  # "three hundred and forty-two"
@test count_letters(number_to_words(115)) == 20  # "one hundred and fifteen"
@test count_letters_in_range(1, 5) == 19  # "one", "two", "three", "four", "five"

@test number_to_words(1) == "one"
@test number_to_words(21) == "twenty-one"
@test number_to_words(100) == "one hundred"
@test number_to_words(101) == "one hundred and one"
@test number_to_words(999) == "nine hundred and ninety-nine"
@test number_to_words(1000) == "one thousand"

@test_answer solve() "0017"
