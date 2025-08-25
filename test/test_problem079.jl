using ProjectEulerSolutions.Problem079:
    build_order_constraints, topological_sort, derive_passcode, read_login_attempts, solve

# Test with a simple example
sample_attempts = ["317", "318", "319"]
order_graph, unique_digits = build_order_constraints(sample_attempts)

# Check that all digits are identified
@test unique_digits == Set(['3', '1', '7', '8', '9'])

# Check that the ordering constraints are correct
@test '1' in order_graph['3']
@test '7' in order_graph['3']
@test '8' in order_graph['3']
@test '9' in order_graph['3']
@test '7' in order_graph['1']
@test '8' in order_graph['1']
@test '9' in order_graph['1']

# Test topological sort
ordered_digits = topological_sort(order_graph, unique_digits)
@test ordered_digits[1] == '3'
@test ordered_digits[2] == '1'
@test Set(ordered_digits[3:5]) == Set(['7', '8', '9'])

# Test the passcode
passcode = derive_passcode(sample_attempts)

# The passcode should contain all the unique digits
@test Set(passcode) == unique_digits

# The passcode should respect the ordering constraints
@test findfirst('3', passcode) < findfirst('1', passcode)
@test findfirst('1', passcode) < findfirst('7', passcode)
@test findfirst('1', passcode) < findfirst('8', passcode)
@test findfirst('1', passcode) < findfirst('9', passcode)

# Test with the example from the problem
example_passcode = "531278"
example_attempt = "317"

@test findfirst(example_attempt[1], example_passcode) <
      findfirst(example_attempt[2], example_passcode)
@test findfirst(example_attempt[2], example_passcode) <
      findfirst(example_attempt[3], example_passcode)

# Test the file reading function with a temporary file
function test_file_reading()
    test_filename = "test_keylog.txt"
    test_attempts = ["123", "456", "789"]

    # Create a temporary file
    open(test_filename, "w") do file
        for attempt in test_attempts
            println(file, attempt)
        end
    end

    # Read the file back
    read_attempts = read_login_attempts(test_filename)

    # Clean up
    rm(test_filename)

    return read_attempts == test_attempts
end

@test test_file_reading()

@test solve() == "73162890"
