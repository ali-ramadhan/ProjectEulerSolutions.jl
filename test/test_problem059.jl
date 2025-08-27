using Test
using ProjectEulerSolutions.Problem059: decrypt, is_english_text, find_encryption_key, solve

# Test decryption function
plain_data = [72, 101, 108, 108, 111]  # "Hello"
key = [120, 121, 122]  # "xyz"
encrypted = decrypt(plain_data, key)
decrypted = decrypt(encrypted, key)  # Should get back original
@test decrypted == plain_data

# Test English text detection
english_text = Int.([UInt8(c) for c in "This is a sample text with the word and also of."])
@test is_english_text(english_text)

non_english_text = Int.([UInt8(c) for c in "XyZ123!@#\$%^&*()"])
@test !is_english_text(non_english_text)

# Test text with too few spaces
no_spaces = Int.([UInt8(c) for c in "Thisisatextwithoutanyspaces"])
@test !is_english_text(no_spaces)

# Test text with non-printable characters
non_printable = [1, 2, 3, 32, 116, 104, 101]  # Contains control characters
@test !is_english_text(non_printable)

@test solve() == 129448
