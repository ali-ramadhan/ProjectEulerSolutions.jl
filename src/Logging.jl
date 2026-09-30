"""
Timestamped logging for Project Euler solutions, tests and benchmarks.

Loading the package replaces the global logger with one that starts every log message with the local time,
including milliseconds and the UTC offset:

    [2026-09-30T19:42:13.123-04:00] Info: Benchmark saved to ...
"""
module Logging

using Dates
using Logging: AbstractLogger, Info, default_metafmt, global_logger  # from the standard library of the same name
import Logging: handle_message, min_enabled_level, shouldlog
using Printf

export timestamp

"""
    timestamp()

Return the current local time in ISO 8601 format with milliseconds and the UTC offset,
e.g. `2026-09-30T19:42:13.123-04:00`.
"""
function timestamp()
    local_time = now()

    # UTC offsets are whole minutes, so rounding removes the time that passed between the two clock readings.
    utc_offset = round(local_time - now(UTC), Minute)
    sign = utc_offset < Minute(0) ? '-' : '+'
    hours, minutes = divrem(abs(Dates.value(utc_offset)), 60)

    return Dates.format(local_time, dateformat"yyyy-mm-ddTHH:MM:SS.sss") * @sprintf("%c%02d:%02d", sign, hours, minutes)
end

# Like Julia's `ConsoleLogger` but without the boxes: every message starts a new line with the timestamp and level, and
# key-value pairs and the source location of warnings and errors follow on indented lines.
struct TimestampedLogger <: AbstractLogger
    lock::ReentrantLock
    message_limits::Dict{Any,Int}  # how many more times each message logged with `maxlog` may be shown
end

TimestampedLogger() = TimestampedLogger(ReentrantLock(), Dict{Any,Int}())

min_enabled_level(::TimestampedLogger) = Info
shouldlog(logger::TimestampedLogger, level, _module, group, id) = @lock logger.lock get(logger.message_limits, id, 1) > 0

function handle_message(logger::TimestampedLogger, level, message, _module, group, id, file, line;
                        maxlog = nothing, kwargs...)
    if maxlog isa Integer
        remaining = @lock logger.lock begin
            logger.message_limits[id] = get(logger.message_limits, id, maxlog) - 1
        end
        remaining >= 0 || return
    end

    color, prefix, suffix = default_metafmt(level, _module, group, id, file, line)

    # Written to stderr in one piece so that messages logged from different threads don't interleave
    buffer = IOBuffer()
    io = IOContext(buffer, stderr)
    print(io, "[", timestamp(), "] ")
    printstyled(io, prefix; bold = true, color)
    println(io, " ", indent(string(message), 2))
    for (key, value) in kwargs
        println(io, "  ", key, " = ", indent(sprint(showvalue, value; context = IOContext(io, :limit => true)), 4))
    end
    isempty(suffix) || printstyled(io, "  ", suffix, "\n"; color = :light_black)
    write(stderr, take!(buffer))
    return nothing
end

indent(text, spaces) = replace(text, "\n" => "\n" * " "^spaces)

# How `ConsoleLogger` shows values, so that e.g. `exception = (err, backtrace)` prints a stack trace
showvalue(io, value) = show(io, MIME"text/plain"(), value)
showvalue(io, err::Exception) = showerror(io, err)
showvalue(io, (err, backtrace)::Tuple{Exception,Any}) = showerror(io, err, backtrace; backtrace = true)

__init__() = global_logger(TimestampedLogger())

end # module Logging
