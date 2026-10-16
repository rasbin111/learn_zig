const std = @import("std");

pub fn main() !void {
    const age = 61;

    const votingMessage = switch (age) {
        1...18 => "Cant vote",
        19...60 => "Can vote",
        else => "It depends",
    };

    std.debug.print("Voting status: {s}\n", .{votingMessage});
}
