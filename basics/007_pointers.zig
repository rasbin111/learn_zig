const std = @import("std");

pub fn main() !void {
    var a: u8 = 10;

    const ptr: *u8 = &a;

    ptr.* = 11;

    std.debug.print("add stored in ptr: {p}\n", .{ptr});
    std.debug.print("value stored in ptr: {d}\n", .{a});
}

test "test pointers with array" {
    const arr = [_]u8{ 1, 2, 3, 4, 5 };
    const ptr = &arr[0];

    try std.testing.expectEqual(1, ptr.*);
}

test "test pointer arithmetic" {
    const arr = [_]u8{ 1, 2, 3, 4, 5 };
    var ptr: [*]const u8 = &arr;

    try std.testing.expectEqual(1, ptr[0]);

    ptr += 1;

    try std.testing.expectEqual(2, ptr[0]);
}

test "test pointer from doc" {
    const array = [_]i32{ 1, 2, 3, 4 };
    var ptr: [*]const i32 = &array;

    try std.testing.expectEqual(1, ptr[0]);
    ptr += 1;
    try std.testing.expectEqual(2, ptr[0]);
}
