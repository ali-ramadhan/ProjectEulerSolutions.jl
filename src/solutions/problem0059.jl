"""
Project Euler Problem 59: XOR Decryption

Each character on a computer is assigned a unique code and the preferred standard is ASCII
(American Standard Code for Information Interchange). For example, uppercase A = 65,
asterisk (*) = 42, and lowercase k = 107.

A modern encryption method is to take a text file, convert the bytes to ASCII, then XOR each
byte with a given value, taken from a secret key. The advantage with the XOR function is
that using the same encryption key on the cipher text, restores the plain text; for example,
65 XOR 42 = 107, then 107 XOR 42 = 65.

For unbreakable encryption, the key is the same length as the plain text message, and the
key is made up of random bytes. The user would keep the encrypted message and the encryption
key in different locations, and without both "halves", it is impossible to decrypt the
message.

Unfortunately, this method is impractical for most users, so the modified method is to use a
password as a key. If the password is shorter than the message, which is likely, the key is
repeated cyclically throughout the message. The balance for this method is using a
sufficiently long password key for security, but short enough to be memorable.

Your task has been made easy, as the encryption key consists of three lower case characters.
Using the encrypted ASCII codes, and the knowledge that the plain text must contain common
English words, decrypt the message and find the sum of the ASCII values in the original
text.

## Solution approach

We brute-force all possible 3-character lowercase keys (26³ = 17,576 possibilities). For
each key, we decrypt a sample of the message and use heuristics to determine if the result
looks like English text: printable ASCII characters, reasonable space frequency, and
presence of common English words like "the", "and", "to", or "of".

## Complexity analysis

Time complexity: O(k × n)
- k possible keys to try (26³ = 17,576)
- Each key requires O(n) time to decrypt and validate a sample

Space complexity: O(n)
- Space to store the encrypted data and decrypted samples
"""
module Problem0059

"""
    decrypt(encrypted_data, key)

Decrypt the data using XOR with the given key. The key is repeated cyclically.
"""
function decrypt(encrypted_data, key)
    decrypted = similar(encrypted_data)
    key_length = length(key)

    for i in 1:length(encrypted_data)
        key_idx = ((i-1) % key_length) + 1
        decrypted[i] = xor(encrypted_data[i], key[key_idx])
    end

    return decrypted
end

"""
    is_english_text(text)

Check if the text appears to be readable English based on several criteria:

  - Characters are all in the printable ASCII range
  - There's a reasonable number of spaces
  - It contains common English words
"""
function is_english_text(text)
    # Check that most characters are in the printable ASCII range
    printable_count = count(c -> 32 <= c <= 126, text)
    if printable_count < 0.95 * length(text)
        return false
    end

    str = String(UInt8.(text))

    # Check for a reasonable number of spaces
    space_ratio = count(c -> c == ' ', str) / length(str)
    if space_ratio < 0.05 || space_ratio > 0.3
        return false
    end

    # Check for common English words
    str_lower = lowercase(str)
    return (
        occursin(" the ", str_lower) && (
            occursin(" and ", str_lower) ||
            occursin(" to ", str_lower) ||
            occursin(" of ", str_lower)
        )
    )
end

"""
    find_encryption_key(encrypted_data)

Try all possible 3-letter lowercase keys and find one that produces readable English text.
Returns the key as an array of ASCII values or nothing if no key is found.
"""
function find_encryption_key(encrypted_data)
    for a in 'a':'z'
        for b in 'a':'z'
            for c in 'a':'z'
                key = [Int(a), Int(b), Int(c)]

                # Decrypt a sample and check if it looks like English
                sample_length = min(200, length(encrypted_data))
                decrypted_sample = decrypt(encrypted_data[1:sample_length], key)

                if is_english_text(decrypted_sample)
                    # Double check with a larger sample
                    full_length = min(500, length(encrypted_data))
                    if is_english_text(decrypt(encrypted_data[1:full_length], key))
                        return key
                    end
                end
            end
        end
    end

    return nothing
end

"""
    solve()

Solve the problem by finding the encryption key, decrypting the message,
and calculating the sum of ASCII values in the original text.
"""
function solve()
    data_filepath = joinpath(@__DIR__, "..", "..", "data", "0059_cipher.txt")
    text = readlines(data_filepath)
    encrypted_data = parse.(Int, split(text[1], ','))

    key = find_encryption_key(encrypted_data)

    if !isnothing(key)
        decrypted_text = decrypt(encrypted_data, key)
        key_chars = String([Char(k) for k in key])

        @info "Found encryption key: $key_chars"
        @info "Decrypted text sum: $decrypted_text"

        return sum(decrypted_text)
    else
        error("No valid key found")
    end
end

end # module
