const std = @import("std");
const funcs = @import("010_func_file.zig");

pub fn main() !void {
    funcs.sum(10, 20);

    var a: u8 = 10;
    var b: u8 = 20;

    funcs.swap(&a, &b);

    std.debug.print("value of a after swap: {d}\n", .{a});
}
