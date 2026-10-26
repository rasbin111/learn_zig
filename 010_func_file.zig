const std = @import("std");

pub fn sum(a: u8, b: u8) void {
    const result = a + b;
    std.debug.print("Result: {d}\n", .{result});
}

pub fn swap(a: *u8, b: *u8) void {
    const temp = b.*;
    b.* = a.*;
    a.* = temp;
}
