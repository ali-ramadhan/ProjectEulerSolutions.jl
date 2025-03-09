using ProjectEulerSolutions.Problem059: decrypt, is_english_text, find_encryption_key, solve

english_text = Int.([UInt8(c) for c in "This is a sample text with the word and also of."])
@test is_english_text(english_text) == true

non_english_text = Int.([UInt8(c) for c in "XyZ123!@#\$%^&*()"])
@test is_english_text(non_english_text) == false

@test solve() == 129448
