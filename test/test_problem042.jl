using ProjectEulerSolutions.Problem042: is_triangle_number, word_value, count_triangle_words, solve

@test is_triangle_number(1)
@test is_triangle_number(3)
@test is_triangle_number(6)
@test is_triangle_number(10)
@test is_triangle_number(15)
@test is_triangle_number(21)
@test is_triangle_number(28)
@test is_triangle_number(36)
@test is_triangle_number(45)
@test is_triangle_number(55)

@test !is_triangle_number(2)
@test !is_triangle_number(4)
@test !is_triangle_number(7)
@test !is_triangle_number(11)

@test word_value("A") == 1
@test word_value("Z") == 26
@test word_value("SKY") == 55

@test count_triangle_words(["SKY"]) == 1
@test count_triangle_words(["SKY", "ABC", "THE"]) == 2

@test solve() == 162
