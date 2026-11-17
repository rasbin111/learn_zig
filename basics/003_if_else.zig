const std = @import("std");

pub fn main(init: std.process.Init) !void {
    var reader_buffer: [1024]u8 = undefined;
    var stdin_reader = std.Io.File.stdin().reader(init.io, &reader_buffer);
    var reader = &stdin_reader.interface;

    std.debug.print("Please enter your age\n", .{});
    const age_string: []u8 = try reader.takeDelimiterExclusive('\n');

    const age: u8 = try std.fmt.parseInt(u8, age_string, 10);

    if (age >= 18) {
        std.debug.print("Yeah! you can vote\n", .{});
    } else {
        std.debug.print("Sorry Kiddo, you can't vote\n", .{});
    }
}
