const std = @import("std");

const Point = struct {
    y: f32,
    x: f32,
    pub fn init(x: f32, y: f32) Point {
        return Point{ .x = x, .y = y };
    }
};

pub fn main() !void {
    const p1: Point = .{ .x = 10, .y = 11 };
    const p2: Point = Point.init(22, 32);

    std.debug.print("{}\n", .{p1});
    std.debug.print("{}\n", .{@TypeOf(p1)});

    std.debug.print("{}\n", .{p2});
}
