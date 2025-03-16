using ProjectEulerSolutions.Problem064: period_of_continued_fraction_sqrt, count_continued_fraction_sqrt_with_odd_period, solve

@test period_of_continued_fraction_sqrt(2) == 1    # √2 = [1; (2)]
@test period_of_continued_fraction_sqrt(3) == 2    # √3 = [1; (1,2)]
@test period_of_continued_fraction_sqrt(5) == 1    # √5 = [2; (4)]
@test period_of_continued_fraction_sqrt(6) == 2    # √6 = [2; (2,4)]
@test period_of_continued_fraction_sqrt(7) == 4    # √7 = [2; (1,1,1,4)]
@test period_of_continued_fraction_sqrt(8) == 2    # √8 = [2; (1,4)]
@test period_of_continued_fraction_sqrt(10) == 1   # √10 = [3; (6)]
@test period_of_continued_fraction_sqrt(11) == 2   # √11 = [3; (3,6)]
@test period_of_continued_fraction_sqrt(12) == 2   # √12 = [3; (2,6)]
@test period_of_continued_fraction_sqrt(13) == 5   # √13 = [3; (1,1,1,1,6)]

@test period_of_continued_fraction_sqrt(1) == 0
@test period_of_continued_fraction_sqrt(4) == 0
@test period_of_continued_fraction_sqrt(9) == 0
@test period_of_continued_fraction_sqrt(16) == 0
@test period_of_continued_fraction_sqrt(25) == 0

@test count_continued_fraction_sqrt_with_odd_period(13) == 4

@test solve() == 1322
