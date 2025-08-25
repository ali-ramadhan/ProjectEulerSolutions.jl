using ProjectEulerSolutions.Problem054:
    HighCard,
    OnePair,
    TwoPairs,
    ThreeOfAKind,
    Straight,
    Flush,
    FullHouse,
    FourOfAKind,
    StraightFlush,
    RoyalFlush,
    parse_card,
    parse_hand,
    compare_hands,
    evaluate_hand,
    solve

@test parse_card("5H").value == 5
@test parse_card("5H").suit == 'H'
@test parse_card("TC").value == 10
@test parse_card("JC").value == 11
@test parse_card("QC").value == 12
@test parse_card("KC").value == 13
@test parse_card("AC").value == 14

@test evaluate_hand(parse_hand("5H 5C 6S 7S KD"))[1] == OnePair
@test evaluate_hand(parse_hand("2C 3S 8S 8D TD"))[1] == OnePair
@test evaluate_hand(parse_hand("5D 8C 9S JS AC"))[1] == HighCard
@test evaluate_hand(parse_hand("2C 5C 7D 8S QH"))[1] == HighCard
@test evaluate_hand(parse_hand("2D 9C AS AH AC"))[1] == ThreeOfAKind
@test evaluate_hand(parse_hand("3D 6D 7D TD QD"))[1] == Flush
@test evaluate_hand(parse_hand("4D 6S 9H QH QC"))[1] == OnePair
@test evaluate_hand(parse_hand("3D 6D 7H QD QS"))[1] == OnePair
@test evaluate_hand(parse_hand("2H 2D 4C 4D 4S"))[1] == FullHouse
@test evaluate_hand(parse_hand("3C 3D 3S 9S 9D"))[1] == FullHouse
@test evaluate_hand(parse_hand("TC JC QC KC AC"))[1] == RoyalFlush
@test evaluate_hand(parse_hand("9C TC JC QC KC"))[1] == StraightFlush
@test evaluate_hand(parse_hand("2C 3C 4C 5C AC"))[1] == StraightFlush
@test evaluate_hand(parse_hand("2C 3C 4C 5C AC"))[2][1] == 5  # A-5 straight flush is 5-high

@test compare_hands(parse_hand("TC JC QC KC AC"), parse_hand("9C TC JC QC KC")) == true  # Royal flush beats straight flush
@test compare_hands(parse_hand("9C TC JC QC KC"), parse_hand("6C 6S 6H 6D KD")) == true  # Straight flush beats four of a kind
@test compare_hands(parse_hand("6C 6S 6H 6D KD"), parse_hand("KS KC KH QS QC")) == true  # Four of a kind beats full house
@test compare_hands(parse_hand("KS KC KH QS QC"), parse_hand("2D 4D 6D 8D TD")) == true  # Full house beats flush
@test compare_hands(parse_hand("2D 4D 6D 8D TD"), parse_hand("9C TC JD QH KS")) == true  # Flush beats straight
@test compare_hands(parse_hand("9C TC JD QH KS"), parse_hand("KS KC KH 2D 3H")) == true  # Straight beats three of a kind
@test compare_hands(parse_hand("KS KC KH 2D 3H"), parse_hand("JS JC 2S 2C 4D")) == true  # Three of a kind beats two pairs
@test compare_hands(parse_hand("JS JC 2S 2C 4D"), parse_hand("AS AC AD 4H 8C")) == false # Two pairs loses to three of a kind
@test compare_hands(parse_hand("JS JC 2S 2C 4D"), parse_hand("QS QC 8S 8C 4D")) == false # Two pairs loses to higher two pairs
@test compare_hands(parse_hand("AS AC 3D 4H 8C"), parse_hand("KS KC 2D 3H 8C")) == true  # Higher pair wins
@test compare_hands(parse_hand("KS KC 2D 3H 8C"), parse_hand("2S 2C AD 4H 8C")) == true  # Higher pair wins
@test compare_hands(parse_hand("2S 2C AD 4H 8C"), parse_hand("KD QC JS 9H 2C")) == true  # One pair beats high card

@test solve() == 376
