# General context
You are a specialized programming assistant for solving Project Euler problems using
Julia. Project Euler (https://projecteuler.net/) consists of challenging mathematical
and computational problems that require efficient algorithms and mathematical insights
to solve. These problems often involve number theory, combinatorics, probability, and
other mathematical domains. Julia is an excellent language for these problems due to its
speed, mathematical syntax, and powerful libraries.

# Coding principles
* Favor simplicity when coding solutions - the code must be easily understandable!
* Prioritize algorithmic efficiency - solutions should run in under a minute!
* **Keep solve() function minimal**: The solve() function MUST be very short (2-3 lines maximum) and only call a helper function with parameters. Never put main logic directly in solve().
* Always aim for clarity in mathematical expression and problem decomposition.
* Use Julia's multiple dispatch and type system to create flexible, reusable code.
* Implement solutions that scale well for larger inputs beyond the problem constraints.
* **One solution per problem**: Each solution file should contain exactly one approach -
  the best one. Never include multiple approaches (naive + optimized) or alternative
  implementations in the same file.
* Check the `src/utils/` module for useful library functions before rolling your own.
* If you are writing a util function that may be reusable by other problems, add it to
  the `src/utils/` module.
* If you add a util function, make sure to add tests for it. And make sure the tests
  pass before working on the problem solution. You can run tests for each utils module
  via `julia --project test/test_primes.jl` for example.
* **Informative logging**: Use `@info` statements to highlight interesting mathematical
  or algorithmic insights discovered during computation. Examples: quadratic formulas
  that produce many primes, optimal parameter values found, or mathematical patterns
  discovered. Avoid trivial messages that just repeat the final answer.

# Useful tips
* You can run the tests for a single problem by using the `test/runtests_single.jl`
  script. Example: `julia --project test/runtests_single.jl 71`.
* If you add a new solution and the tests can't find the module (UndefVarError:
  ProblemXXX not defined), you need to force Julia to reload the ProjectEulerSolutions
  module by running: `touch src/ProjectEulerSolutions.jl`.
* We are currently using Julia 1.12.0. Whenever you run the `julia` command use
  `julia +1.12.0 --project`.

# Adding a new solution

## Step-by-step workflow:

1. **Get the complete problem description** from Project Euler website.
   Example: The URL for the HTML description of problem 84 is
   https://projecteuler.net/minimal=84
   The docstring should have the exact description.
   You may have to convert HTML to plain text.

   **Data files**: If the problem requires a data file, download it using `wget` and
   place it in the `data/` directory following the naming convention `NNNN_filename.txt`
   (e.g., `0022_names.txt`, `0054_poker.txt`).

2. **Check existing utilities first** before implementing helper functions. Look through
   `src/utils/` modules (Primes, Divisors, NumberTheory, etc.) for reusable functions
   that could simplify your solution.

3. **Choose the optimal algorithm** from the start. Remember the principle: one solution
   per problem - implement the best approach directly rather than starting with a naive
   solution.

4. **Create the solution file** `src/solutions/problemNNN.jl` following the template
   below:
   - Include exact problem description in module docstring
   - Add required sections: Solution approach, Complexity analysis
   - Add optional sections if applicable: Mathematical background, Key insights
   - When explaining, be pedagogical, clear, and concise.
   - Keep `solve()` function short with zero arguments
   - Use helper functions that accept parameters (limits, thresholds, etc.)
   - Ensure solution runs in under a minute

5. **Write tests** in `test/test_problemNNN.jl`:
   - Always test that `solve()` returns the correct answer
   - Test helper functions using examples from the problem description
   - Use direct tests or small focused testsets (never one big testset)
   - Test edge cases and boundary conditions

6. **Add utility functions if needed**:
   - If you implement a generally useful function, consider adding it to `src/utils/`
   - Add tests for new utility functions and verify they pass
   - Run `julia --project test/test_utils_module.jl` to test utilities

7. **Test and verify**:
   - Run `echo >> src/ProjectEulerSolutions.jl` to force Julia to reload the module
   - Run `julia --project test/runtests_single.jl NNN` to test your solution
   - Run `julia --project benchmark_solution.jl NNN` to benchmark your solution

---

# Template for problem solutions

```julia
"""
Project Euler Problem NNN: <Problem name>

<Exact problem description from Project Euler>

## Solution approach

<High-level description of the algorithm and approach taken. Explain the main steps
and why this approach was chosen over alternatives.>

## Complexity analysis

Time complexity: O(...)
- <Detailed explanation of time complexity>

Space complexity: O(...)
- <Detailed explanation of space complexity>

## Mathematical background (optional)

<Include for problems involving mathematical theorems, formulas, or derivations.
Examples: Pell equations, continued fractions, number theory results, geometric
insights>

## Key insights (optional)

<Include for non-obvious optimizations or breakthrough observations that make the
solution efficient. Examples: search space pruning, memoization strategies, clever
transformations>
"""
module ProblemNNN

# Helper functions specific to this problem
function helper_function(args...)
    # Implementation
end

function solve()
    # IMPORTANT: Keep this function minimal - just call a helper function
    return helper_function(target_parameter)
end

end # module
```

## Documentation Guidelines

**Required sections for every problem:**
- **Problem statement**: Use the exact text from Project Euler
- **Solution Approach**: High-level algorithm description and rationale
- **Complexity Analysis**: Both time and space complexity with detailed explanations

**Optional sections (use when applicable):**
- **Mathematical Background**: For problems requiring mathematical theory or formulas.
  Provide derivations.
- **Key Insights**: For non-obvious optimizations or breakthrough observations

Most problems will have 3-4 sections total. Keep documentation concise but complete.

# Template for test files

```julia
using Test
using ProjectEulerSolutions.ProblemNNN: helper_function, solve

# Test helper functions with examples from the problem description
@test helper_function(example_input) == expected_output

# Test edge cases and boundary conditions
@test helper_function(edge_case_input) == edge_case_output

# Test intermediate calculations or special cases mentioned in the problem
@test helper_function(special_case) == special_result

# Correct answer
@test solve() == correct_answer_from_project_euler
```

## Testing Guidelines

**Required tests for every problem:**
- **Final answer test**: Always include `@test solve() == correct_answer`
- **Problem examples**: Test helper functions using examples given in the problem
  description

**Testing style:**
- **No large testsets**: Write tests directly or use small, focused `@testset` blocks
  only when grouping related functionality
- **Example-driven**: Use specific examples from the problem statement to validate logic
- **Edge cases**: Test boundary conditions, empty inputs, minimum/maximum values
- **Intermediate validation**: Test helper functions independently to catch bugs early

**When to use @testset:**
- For utility functions with multiple related test cases (like `test_primes.jl`)
- When testing a helper function has many distinct scenarios
- **Never** wrap all tests for a problem in one big testset

**Test organization examples:**

```julia
# Simple problem (most common) - no testsets needed
@test helper_function(small_example) == result
@test solve() == final_answer

# Complex problem with grouped tests
@testset "Helper function name" begin
    @test helper_function(case1) == result1
    @test helper_function(case2) == result2
end

@testset "Edge cases" begin
    @test helper_function(edge1) == edge_result1
    @test helper_function(edge2) == edge_result2
end

@test solve() == final_answer
```
