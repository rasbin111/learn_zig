const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const currentDir = std.Io.Dir.cwd();
    const file = try std.Io.Dir.createFile(currentDir, init.io, "hello.txt", .{ .read = true });
    defer file.close(init.io);
}
