const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}){};
    const allocator = gpa.allocator();

    const some_number = try allocator.create(u32);
    const another_number = try allocator.create(u32);
    const name = try allocator.alloc(u8, 10);

    defer allocator.destroy(some_number);
    defer allocator.destroy(another_number);
    defer allocator.free(name);

    some_number.* = 12;
    another_number.* = 13;
    @memcpy(name, "Ramkrishna");

    std.debug.print("value of some number: {d}\n", .{some_number.*});
    std.debug.print("value of another number: {d}\n", .{another_number.*});
    std.debug.print("value of name: {s}\n", .{name});
}
