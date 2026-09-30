using Test

@testset "Logging" begin
    # Log a message from a fresh Julia process that loads the package, like the test and benchmark scripts do, and check
    # that its line starts with the timestamp. POSIX TZ strings give the offset west of UTC, so NST+3:30 is Newfoundland
    # Standard Time, 3 hours 30 minutes behind UTC, which checks the sign of the offset and its minutes. TZ is a POSIX
    # convention, so on Windows only the shape of the offset is checked.
    julia = `$(Base.julia_cmd()) --startup-file=no --color=no --project=$(Base.active_project())`
    cmd = addenv(`$julia -e 'using ProjectEulerSolutions.Logging; @info "Hello"'`, "TZ" => "NST+3:30")
    output = IOBuffer()
    run(pipeline(cmd; stderr = output))

    offset = Sys.iswindows() ? r"[+-]\d{2}:\d{2}" : r"-03:30"
    log_lines = split(String(take!(output)), '\n')
    @test any(contains(r"^\[\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}" * offset * r"\] Info: Hello$"), log_lines)
end
