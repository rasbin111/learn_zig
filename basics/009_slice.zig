const std = @import("std");

pub fn main() !void {
    const arr1 = [_]u8{ 1, 2, 3, 4, 5 };

    const sl1 = arr1[1..5];

    std.debug.print("l: {d}\n", .{sl1[sl1.len - 1]});

    const sl2 = &.{ 1, 2, 3, 4 };

    std.debug.print("l: {d}\n", .{sl2[sl2.len - 1]});
    std.debug.print("{}\n", .{@TypeOf(arr1)});
    std.debug.print("{}\n", .{@TypeOf(&sl1[0])});
}
