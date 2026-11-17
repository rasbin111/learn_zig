const std = @import("std");

pub fn main() !void {
    const arr = [_]u8{ 1, 2, 3, 4, 5, 6 };
    const arr2: [5]u8 = .{ 1, 2, 3, 5, 7 };

    std.debug.print("1: {d}\n", .{arr[0]});
    std.debug.print("1: {d}\n", .{arr2[0]});

    // modifiable array
    var nums: [20]u32 = undefined;

    for (&nums, 0..) |*item, i| {
        item.* = @intCast(i);
    }

    std.debug.print("1: {d}\n", .{nums[7]});

    const arr3 = arr ++ arr2;
    std.debug.print("Len arr3: {d}\n", .{arr3.len});

    const arr4: [10]i32 = @splat(9);
    std.debug.print("arr4: {d}\n", .{arr4[4]});
}
