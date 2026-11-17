const std = @import("std");

fn fib(iteration: u32) u32 {
    if (iteration < 2) return iteration;

    return fib(iteration - 1) + fib(iteration - 2);
}

test "comtime fib" {
    const io = std.testing.io;
    const start_time = std.Io.Clock.Timestamp.now(io, .real);
    _ = comptime fib(10);
    const end_time = std.Io.Clock.Timestamp.now(io, .real);
    const time_diff = end_time.raw.toMicroseconds() - start_time.raw.toMicroseconds();
    std.debug.print("Comptime Time diff: {d} micros\n", .{time_diff});
}

test "fib" {
    const io = std.testing.io;
    const start_time = std.Io.Clock.Timestamp.now(io, .real);
    _ = fib(10);
    const end_time = std.Io.Clock.Timestamp.now(io, .real);
    const time_diff = end_time.raw.toMicroseconds() - start_time.raw.toMicroseconds();
    std.debug.print("Normal Time diff: {d} micros\n", .{time_diff});
}

fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}

test "max test for u32" {
    const a: u32 = 10;
    const b: u32 = 22;

    const result = max(u32, a, b);

    try std.testing.expectEqual(22, result);
}

test "max test for f32" {
    const a: f32 = 10.04;
    const b: f32 = 10.003;

    const result = max(f32, a, b);

    try std.testing.expectEqual(10.04, result);
}

pub fn main() !void {
    const a = 10;

    comptime var b = a * a;

    const arr = [_]comptime_int{ 10, 20, 30 };

    inline for (arr) |item| {
        b += item;
    }

    std.debug.print("var b: {d}\n", .{b});
}
