using ProjectEulerSolutions.Problem0042: word_value, count_triangle_words, solve

@test word_value("A") == 1
@test word_value("Z") == 26
@test word_value("SKY") == 55

@test count_triangle_words(["SKY"]) == 1
@test count_triangle_words(["SKY", "ABC", "THE"]) == 2

@test solve() == 162
